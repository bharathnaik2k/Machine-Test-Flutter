import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:machine_test/routes/VerificationScreen/verification_screen.dart';
import 'package:machine_test/utils/api_adress/api_adress.dart';
import 'package:machine_test/utils/snackbar/custom_snack.dart';

class RegistrationController with ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController referralController = TextEditingController();
  bool passwordVisible = false;
  bool progressIndicator = false;

  Future<void> postRegister(BuildContext context) async {
    String url = "$baseURL$registrationEndPoint";
    Uri uri = Uri.parse(url);
    Map<String, dynamic> body = {
      "email": emailController.text,
      "password": passwordController.text,
      "referralCode": referralController.text,
      "userId": "62a833766ec5dafd6780fc85"
    };
    var response = await http.post(uri, body: body);

    progressIndicator = false;

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
}
