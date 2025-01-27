import 'package:flutter/material.dart';
import 'package:machine_test/routes/DashboradScreen/dashborad_screen.dart';
import 'package:machine_test/routes/LoginScreen/login_screen.dart';
import 'package:machine_test/routes/RegistrationScreen/registration_screen.dart';
import 'package:machine_test/routes/SplashScreen/splash_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Roboto_Flex",
      ),
      initialRoute: "/SplashScreen",
      routes: {
        "/SplashScreen": (context) => const SplashScreen(),
        "/LoginScreen": (context) => const LoginScreen(),
        "/RegistrationScreen": (context) => const RegistrationScreen(),
        "/DashboradScreen": (context) => const DashboradScreen(),
      },
    );
  }
}
