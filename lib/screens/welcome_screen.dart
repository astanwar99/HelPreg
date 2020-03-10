import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:pregnency_helper/components/multi_button.dart';
import 'package:pregnency_helper/screens/login_screen.dart';
import 'package:pregnency_helper/screens/registration_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child:
                        Image.asset('assets/pregnancy_helper_logo_small.png'),
                    height: 60.0,
                  ),
                ),
                Text(
                  'HelPreg',
                  style: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            MultiButton('Log In', Colors.lightBlueAccent, () {
              Navigator.pushNamed(context, LoginScreen.id);
            }),
            MultiButton('Register', Colors.blueAccent, () {
              Navigator.pushNamed(context, RegistrationScreen.id);
            })
          ],
        ),
      ),
    );
  }
}
