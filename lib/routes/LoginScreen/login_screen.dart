import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:machine_test/routes/RegistrationScreen/registration_screen.dart';
import 'package:machine_test/routes/VerificationScreen/verification_screen.dart';
import 'package:machine_test/utils/api_adress/api_adress.dart';
import 'package:machine_test/utils/snackbar/custom_snack.dart';
import 'package:pinput/pinput.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool phone = true;
  TextEditingController inputController = TextEditingController();
  bool progressIndi = false;

  Future<void> postSendcode() async {
    String url = "$baseURL$otpAndResendEndPoint";
    Uri uri = Uri.parse(url);
    Map<String, dynamic> body = {
      "mobileNumber": inputController.text,
      "deviceId": "62b341aeb0ab5ebe28a758a3",
    };
    var response = await http.post(uri, body: body);
    setState(() {
      progressIndi = false;
    });
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      showInSnackBar("OTP Sent successful", context);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            return VerificationScreen(
              text: inputController.text,
            );
          },
        ),
      );
      log(json.decode(response.body).toString());
    } else {
      showInSnackBar("User does't exits please Register", context);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            return const RegistrationScreen();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 18),
          child: GestureDetector(
            onTap: () {},
            child: const Icon(
              Icons.arrow_back_ios,
              size: 30,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 45, left: 45),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Opacity(
                  opacity: 0.4,
                  child: Image.asset(
                    "assets/images/logo.png",
                    scale: 1,
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: 200,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: const Color.fromARGB(255, 205, 205, 205),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          phone = true;
                          setState(() {});
                        },
                        child: Container(
                          width: 100,
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: phone == true
                                ? const Color.fromARGB(255, 255, 17, 0)
                                : Colors.transparent,
                          ),
                          child: Center(
                            child: Text(
                              "Phone",
                              style: TextStyle(
                                color:
                                    phone == true ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          phone = false;
                          setState(() {});
                        },
                        child: Container(
                          width: 100,
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: phone == false
                                ? const Color.fromARGB(255, 255, 17, 0)
                                : Colors.transparent,
                          ),
                          child: Center(
                            child: Text(
                              "Email",
                              style: TextStyle(
                                color: phone == false
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                "Glad to see you!",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 15),
              const Text("Please provide your phone number"),
              const SizedBox(height: 28),
              TextField(
                onChanged: (value) {
                  setState(() {});
                },
                keyboardType: phone == true
                    ? TextInputType.number
                    : TextInputType.emailAddress,
                maxLength: phone == true ? 10 : 100,
                controller: inputController,
                decoration: InputDecoration(
                  counterText: "",
                  hintText: phone == true ? "Phone" : "Email",
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: TextButton(
                  style: ButtonStyle(
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    backgroundColor: MaterialStatePropertyAll(
                      inputController.length == 0
                          ? const Color.fromARGB(255, 255, 145, 145)
                          : Colors.red,
                    ),
                    minimumSize: const MaterialStatePropertyAll(
                      Size(180.0, 52.0),
                    ),
                  ),
                  onPressed: () {
                    if (inputController.length >= 10) {
                      if (progressIndi == false) {
                        postSendcode();
                        progressIndi = true;
                        setState(() {});
                      }
                    }
                  },
                  child: progressIndi == true
                      ? const CircularProgressIndicator(
                          strokeAlign: 0,
                          // strokeWidth:
                          // ,
                        )
                      : const Text(
                          "Send Code",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}
