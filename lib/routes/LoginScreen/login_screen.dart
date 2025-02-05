import 'package:flutter/material.dart';
import 'package:machine_test/utils/state_controller/login_controller/login_controller.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: const Color.fromARGB(255, 205, 205, 205),
                  ),
                  child: Consumer<LoginController>(
                    builder: (context, value, child) {
                      return Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              value.phone = true;
                              value.notifyListeners();
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: 45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: value.phone == true
                                    ? const Color.fromARGB(255, 255, 17, 0)
                                    : Colors.transparent,
                              ),
                              child: Center(
                                child: Text(
                                  "Phone",
                                  style: TextStyle(
                                    color: value.phone == true
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              value.phone = false;
                              value.notifyListeners();
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: 45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: value.phone == false
                                    ? const Color.fromARGB(255, 255, 17, 0)
                                    : Colors.transparent,
                              ),
                              child: Center(
                                child: Text(
                                  "Email",
                                  style: TextStyle(
                                    color: value.phone == false
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
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
              Consumer<LoginController>(builder: (context, ref, child) {
                return TextField(
                  onChanged: (value) {
                    ref.notifyListeners();
                  },
                  keyboardType: ref.phone == true
                      ? TextInputType.number
                      : TextInputType.emailAddress,
                  maxLength: ref.phone == true ? 10 : 100,
                  controller: ref.inputController,
                  decoration: InputDecoration(
                    counterText: "",
                    hintText: ref.phone == true ? "Phone" : "Email",
                  ),
                );
              }),
              const SizedBox(height: 20),
              Center(
                child:
                    Consumer<LoginController>(builder: (context, ref, child) {
                  return TextButton(
                    style: ButtonStyle(
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      backgroundColor: MaterialStatePropertyAll(
                        ref.inputController.length == 0
                            ? const Color.fromARGB(255, 255, 145, 145)
                            : Colors.red,
                      ),
                      minimumSize: MaterialStatePropertyAll(
                        Size(MediaQuery.of(context).size.width * 0.6, 52.0),
                      ),
                    ),
                    onPressed: () {
                      if (ref.inputController.length >= 10) {
                        if (ref.progressIndi == false) {
                          ref.postSendcode(context);
                          ref.progressIndi = true;
                          ref.notifyListeners();
                          // Navigator.of(context).pushReplacement(
                          //   MaterialPageRoute(
                          //     builder: (context) {
                          //       return const RegistrationScreen();
                          //     },
                          //   ),
                          // );
                        }
                      }
                    },
                    child: ref.progressIndi == true
                        ? const CircularProgressIndicator(
                            strokeAlign: 0,
                          )
                        : const Text(
                            "Send Code",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  );
                }),
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}
