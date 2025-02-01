import 'dart:async';

import 'package:flutter/material.dart';
import 'package:machine_test/routes/DashboradScreen/dashborad_screen.dart';
import 'package:machine_test/routes/LoginScreen/login_screen.dart';
import 'package:machine_test/utils/snackbar/custom_snack.dart';
import 'package:machine_test/utils/state_controller/login_controller/login_controller.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class VerificationScreen extends StatefulWidget {
  final String? text;
  const VerificationScreen({super.key, this.text});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  @override
  void initState() {
    final verificationcontroller =
        Provider.of<LoginController>(context, listen: false);
    verificationcontroller.timerCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );

    final verificationcontroller =
        Provider.of<LoginController>(context, listen: false);

    return Scaffold(
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
      body: Padding(
        padding: const EdgeInsets.only(right: 45, left: 45),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Image.asset("assets/images/otpPhoto.png"),
            const SizedBox(height: 28),
            const Text(
              "OTP Verification",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 15),
            const Text("We have sent a unique OTP number"),
            const SizedBox(height: 8),
            Text(
              "to your moblie ${widget.text}",
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 28),
            Pinput(
              controller: verificationcontroller.pinController,
              defaultPinTheme: defaultPinTheme,
              separatorBuilder: (index) => const SizedBox(width: 8),
              hapticFeedbackType: HapticFeedbackType.lightImpact,
              onCompleted: (pin) {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const DashboradScreen(),
                ));
              },
              onChanged: (value) {},
              cursor: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 50),
                    width: 22,
                    height: 1,
                    color: focusedBorderColor,
                  ),
                ],
              ),
              followingPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: focusedBorderColor),
                ),
              ),
              focusedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: focusedBorderColor),
                ),
              ),
              submittedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  color: fillColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: focusedBorderColor),
                ),
              ),
              errorPinTheme: defaultPinTheme.copyBorderWith(
                border: Border.all(color: Colors.redAccent),
              ),
            ),
            const SizedBox(height: 15),
            Consumer<LoginController>(builder: (context, ref, child) {
              return Row(
                children: [
                  Text(
                    ref.formattedTime(ref.secondsRemaining),
                    style: const TextStyle(fontSize: 16),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      if (ref.enableResend == true) {
                        ref.secondsRemaining = 10;
                        ref.enableResend = false;
                        ref.notifyListeners();
                        if (ref.timer?.isActive ?? false) {
                          ref.timer?.cancel();
                          ref.notifyListeners();
                        }
                        ref.timer =
                            Timer.periodic(const Duration(seconds: 1), (_) {
                          if (ref.secondsRemaining > 0) {
                            ref.secondsRemaining--;
                            ref.notifyListeners();
                          } else {
                            ref.enableResend = true;
                            ref.timer?.cancel();
                            ref.notifyListeners();
                          }
                        });
                        showInSnackBar("OTP resend succesful", context);
                      }
                    },
                    child: Text(
                      'Send Again',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: ref.enableResend == true
                            ? Colors.black
                            : Colors.grey,
                      ),
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
