import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:machine_test/routes/LoginScreen/login_screen.dart';
import 'package:machine_test/routes/VerificationScreen/verification_screen.dart';
import 'package:machine_test/utils/api_adress/api_adress.dart';
import 'package:machine_test/utils/snackbar/custom_snack.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController referralController = TextEditingController();
  bool _passwordVisible = false;
  bool progressIndi = false;

  Future<void> postRegister() async {
    String url = "$baseURL$registrationEndPoint";
    Uri uri = Uri.parse(url);
    Map<String, dynamic> body = {
      "email": emailController.text,
      "password": passwordController.text,
      "referralCode": referralController.text,
      "userId": "62a833766ec5dafd6780fc85"
    };
    var response = await post(uri, body: body);
    setState(() {
      progressIndi = false;
    });
    showInSnackBar("OTP Sent successful", context);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          return VerificationScreen(text: emailController.text);
        },
      ),
    );
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      showInSnackBar("OTP Sent successful", context);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            return VerificationScreen(text: emailController.text);
          },
        ),
      );
      log(json.decode(response.body).toString());
    } else {
      log(json.decode(response.body).toString());
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
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ));
            },
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
                    scale: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                "Let's Begin!",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 15),
              const Text("Please enter your credentials to proceed"),
              const SizedBox(height: 28),
              TextField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: const InputDecoration(hintText: "Your Email"),
              ),
              const SizedBox(height: 5),
              TextField(
                keyboardType: TextInputType.emailAddress,
                controller: passwordController,
                obscureText: _passwordVisible,
                decoration: InputDecoration(
                  hintText: "Create Password",
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 5),
              TextField(
                keyboardType: TextInputType.emailAddress,
                controller: referralController,
                decoration:
                    const InputDecoration(hintText: "Referral Code (Optional)"),
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          progressIndi = true;
          postRegister();
        },
        backgroundColor: const Color.fromARGB(255, 255, 17, 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: const Icon(
          Icons.arrow_forward,
          color: Colors.white,
        ),
      ),
    );
  }
}
