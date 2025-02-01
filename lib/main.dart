import 'package:flutter/material.dart';
import 'package:machine_test/routes/LoginScreen/login_screen.dart';
import 'package:machine_test/routes/SplashScreen/splash_screen.dart';
import 'package:machine_test/utils/state_controller/login_controller/login_controller.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginController(),
          child: const MaterialApp(
            home: LoginScreen(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Roboto_Flex",
        ),
        home: const SplashScreen(),
        // initialRoute: "/SplashScreen",
        // routes: {
        //   "/SplashScreen": (context) => const SplashScreen(),
        //   "/LoginScreen": (context) => const LoginScreen(),
        //   "/RegistrationScreen": (context) => const RegistrationScreen(),
        //   "/DashboradScreen": (context) => const DashboradScreen(),
        // },
      ),
    );
  }
}
