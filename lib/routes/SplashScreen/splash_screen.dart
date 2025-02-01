import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:machine_test/components/divice_info.dart';
import 'package:machine_test/routes/LoginScreen/login_screen.dart';
import 'package:machine_test/utils/api_adress/api_adress.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<void> postDeviceInfo(BuildContext context) async {
    try {
      String url = "$baseURL$deviceInfoEndPoint";
      Uri uri = Uri.parse(url);
      Map<String, dynamic> body = diviceInfo;
      var response = await http.post(
        uri,
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        naviFun(context);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void naviFun(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    postDeviceInfo(context);
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            height: double.infinity,
            width: double.infinity,
            "assets/images/backGround.png",
            fit: BoxFit.fitHeight,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              "assets/images/logo.png",
              height: 220,
              width: 220,
            ),
          ),
          const Center(
            child: CircularProgressIndicator(
              strokeCap: StrokeCap.round,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
