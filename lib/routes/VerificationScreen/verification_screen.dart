import 'dart:async';

import 'package:flutter/material.dart';
import 'package:machine_test/routes/DashboradScreen/dashborad_screen.dart';
import 'package:machine_test/routes/LoginScreen/login_screen.dart';
import 'package:machine_test/utils/snackbar/custom_snack.dart';
import 'package:pinput/pinput.dart';

class VerificationScreen extends StatefulWidget {
  final String? text;
  const VerificationScreen({super.key, required this.text});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  TextEditingController pinController = TextEditingController();
  int secondsRemaining = 120;
  bool enableResend = false;
  Timer? timer;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String formattedTime(int timeInSeconds) {
    int sec = timeInSeconds % 60;
    int min = timeInSeconds ~/ 60;
    return "${min.toString().padLeft(2, '0')} : ${sec.toString().padLeft(2, '0')}";
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining > 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          enableResend = true;
        });
        timer?.cancel();
      }
    });
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
              controller: pinController,
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
            Row(
              children: [
                Text(
                  formattedTime(secondsRemaining),
                  style: const TextStyle(fontSize: 16),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    if (enableResend == true) {
                      setState(() {
                        secondsRemaining = 120;
                        enableResend = false;
                        if (timer?.isActive ?? false) timer?.cancel();
                        timer = Timer.periodic(const Duration(seconds: 1), (_) {
                          if (secondsRemaining > 0) {
                            setState(() {
                              secondsRemaining--;
                            });
                          } else {
                            setState(() {
                              enableResend = true;
                            });
                            timer?.cancel();
                          }
                        });
                        showInSnackBar("OTP resend succesful", context);
                      });
                    }
                  },
                  child: Text(
                    'Send Again',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: enableResend == true ? Colors.black : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
