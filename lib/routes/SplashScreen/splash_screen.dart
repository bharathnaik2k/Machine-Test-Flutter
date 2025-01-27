import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:machine_test/components/divice_info.dart';
import 'package:machine_test/utils/api_adress/api_adress.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool circularProgressIndicator = true;

  Future<void> postDeviceInfo() async {
    try {
      String url = "$baseURL$deviceInfoEndPoint";
      Uri uri = Uri.parse(url);
      Map<String, dynamic> body = diviceInfo;
      var response = await http.post(
        uri,
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        circularProgressIndicator = false;
        log(circularProgressIndicator.toString());
        naviFun();
        setState(() {});
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void naviFun() {
    Navigator.of(context).pushReplacementNamed("/LoginScreen");
  }

  @override
  void initState() {
    postDeviceInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          circularProgressIndicator == true
              ? const Center(
                  child: CircularProgressIndicator(
                    strokeCap: StrokeCap.round,
                    color: Colors.red,
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
