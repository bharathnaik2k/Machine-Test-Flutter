import 'dart:async';

import 'package:flutter/material.dart';
 class VerificationController with ChangeNotifier{
  
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