import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:pregnency_helper/components/multi_button.dart';
import 'package:pregnency_helper/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pregnency_helper/screens/user_screen.dart';
import 'package:pregnency_helper/screens/doctor_screen.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

enum loginType { doctor, user }

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool showSpinner = false;
  loginType _type = loginType.user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child:
                        Image.asset('assets/pregnancy_helper_logo_small.png'),
                  ),
                ),
              ),
              ListTile(
                title: const Text('User'),
                leading: Radio(
                  value: loginType.user,
                  groupValue: _type,
                  onChanged: (loginType value) {
                    setState(() {
                      _type = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Doctor'),
                leading: Radio(
                  value: loginType.doctor,
                  groupValue: _type,
                  onChanged: (loginType value) {
                    setState(() {
                      _type = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  if (_type == loginType.user)
                    value = 'user.' + value;
                  else
                    value = 'doctor.' + value;
                  email = value.trim();
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your email.',
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password.',
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              MultiButton('Log In', Colors.lightBlueAccent, () {
                setState(() {
                  showSpinner = true;
                });
                try {
                  final user = _auth.signInWithEmailAndPassword(
                      email: email, password: password);
                  if (user != null) {
                    if (_type == loginType.user)
                      Navigator.pushNamed(
                        context,
                        UserScreen.id,
                      );
                    else
                      Navigator.pushNamed(
                        context,
                        DoctorScreen.id,
                      );
                  }
                  setState(() {
                    showSpinner = false;
                  });
                } catch (e) {
                  print(e);
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
