import 'package:flutter/material.dart';

void showInSnackBar(String message ,BuildContext context) {
  var snackBar = SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
