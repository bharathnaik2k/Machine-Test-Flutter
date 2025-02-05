import 'package:flutter/material.dart';
import 'package:machine_test/routes/LoginScreen/login_screen.dart';
import 'package:machine_test/utils/state_controller/registration_controller/registration_controller.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    final RegistrationController registrationController =
        Provider.of<RegistrationController>(context, listen: false);
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
                controller: registrationController.emailController,
                decoration: const InputDecoration(hintText: "Your Email"),
              ),
              const SizedBox(height: 5),
              Consumer<RegistrationController>(builder: (context, ref, child) {
                return TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: ref.passwordController,
                  obscureText: ref.passwordVisible,
                  decoration: InputDecoration(
                    hintText: "Create Password",
                    suffixIcon: IconButton(
                      icon: Icon(
                        ref.passwordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.green,
                      ),
                      onPressed: () {
                        ref.passwordVisible = !ref.passwordVisible;
                        ref.notifyListeners();
                      },
                    ),
                  ),
                );
              }),
              const SizedBox(height: 5),
              TextField(
                keyboardType: TextInputType.emailAddress,
                controller: registrationController.referralController,
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
          registrationController.progressIndicator = true;
          registrationController.postRegister(context);
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
