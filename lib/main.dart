import 'package:flutter/material.dart';
import 'package:pregnency_helper/screens/welcome_screen.dart';
import 'package:pregnency_helper/screens/login_screen.dart';
import 'package:pregnency_helper/screens/registration_screen.dart';
import 'package:pregnency_helper/screens/doctor_screen.dart';
import 'package:pregnency_helper/screens/user_screen.dart';
import 'package:pregnency_helper/screens/user_activities/bmi.dart';
import 'package:pregnency_helper/screens/user_activities/user_profile.dart';

void main() => runApp(HelPreg());

class HelPreg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.lightBlueAccent,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        UserScreen.id: (context) => UserScreen(),
        DoctorScreen.id: (context) => DoctorScreen(),
        BMI.id: (context) => BMI(),
        UserProfile.id: (context) => UserProfile(),
      },
    );
  }
}
