import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:machine_test/routes/RegistrationScreen/registration_screen.dart';
import 'package:machine_test/routes/VerificationScreen/verification_screen.dart';
import 'package:machine_test/utils/api_adress/api_adress.dart';
import 'package:machine_test/utils/snackbar/custom_snack.dart';

class LoginController with ChangeNotifier {
  bool phone = true;
  TextEditingController inputController = TextEditingController();
  bool progressIndi = false;

  Future<void> postSendcode(BuildContext context) async {
    String url = "$baseURL$otpAndResendEndPoint";
    Uri uri = Uri.parse(url);
    Map<String, dynamic> body = {
      "mobileNumber": inputController.text,
      "deviceId": "62b341aeb0ab5ebe28a758a3",
    };
    var response = await http.post(uri, body: body);

    progressIndi = false;

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
  notifyListeners();

  TextEditingController pinController = TextEditingController();
  int secondsRemaining = 10;
  bool enableResend = false;
  Timer? timer;

  String formattedTime(int timeInSeconds) {
    int sec = timeInSeconds % 60;
    int min = timeInSeconds ~/ 60;
    return "${min.toString().padLeft(2, '0')} : ${sec.toString().padLeft(2, '0')}";
  }

  void timerCall() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer _) {
      if (secondsRemaining > 0) {
        secondsRemaining--;
        notifyListeners();
      } else {
        enableResend = true;
        timer?.cancel();
        notifyListeners();
      }
    });
  }
}
