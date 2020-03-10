import 'package:flutter/material.dart';
import 'package:pregnency_helper/components/reusable_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pregnency_helper/constants.dart';
import 'dart:math';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

class BMI extends StatefulWidget {
  static String id = 'bmi_screen';
  @override
  _BMIState createState() => _BMIState();
}

class _BMIState extends State<BMI> {
  final _auth = FirebaseAuth.instance;
  bool profileExists = false;

  int prevWeight;
  double height;
  String prevBmi;
  String curBmi;
  String res;
  String comments;

  int curWeight = 60;
  BMIBrain bmi;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String> getProfile() async {
    final userProfiles = await _firestore.collection('users').getDocuments();
    for (var userProfile in userProfiles.documents) {
      if (loggedInUser.email == userProfile.data['email']) {
        prevWeight = userProfile.data['weight'];
        height = userProfile.data['height'];
        profileExists = true;
        setState(() {
          prevBmi = (prevWeight / pow(height, 2)).toStringAsFixed(1);
        });
        break;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('USER'),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ReusableCard(
              colour: Colors.lightBlueAccent,
              cardChild: Center(child: Text('Your BMI was: $prevBmi')),
              //launchScreen: ,
            ),
            ReusableCard(
              colour: Colors.lightBlueAccent,
              cardChild: Center(child: Text('$comments')),
              //launchScreen: ,
            ),
            ReusableCard(
              colour: Colors.lightBlueAccent,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Current Weight',
                    style: kLabelTextStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      Text(
                        prevWeight.toString(),
                        style: kNumberTextStyle,
                      ),
                      Text(
                        'kg',
                        style: kLabelTextStyle,
                      )
                    ],
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: Color(0xFF0094CC),
                      inactiveTrackColor: Color(0xFF82F7FF),
                      thumbColor: Color(0xFF0094CC),
                      overlayColor: Color(0x290094CC),
                      thumbShape:
                          RoundSliderThumbShape(enabledThumbRadius: 15.0),
                      overlayShape:
                          RoundSliderOverlayShape(overlayRadius: 30.0),
                    ),
                    child: Slider(
                      value: curWeight.toDouble(),
                      min: 40,
                      max: 140,
                      onChanged: (double newValue) {
                        setState(() {
                          curWeight = newValue.floor();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            ReusableCard(
              colour: Colors.lightBlueAccent,
              cardChild: Column(
                children: <Widget>[
                  Text('Your BMI was: $curBmi'),
                  Text('$res'),
                ],
              ),
              //launchScreen: ,
            ),
          ],
        ),
      ),
    );
  }
}

class BMIBrain {
  final int curWeight;
  final int prevWeight;
  final double prevBmi;
  final double height;
  double _bmi;
  int weightGain;

  BMIBrain(this.prevWeight, this.curWeight, this.height, this.prevBmi) {
    weightGain = curWeight - prevWeight;
  }

  String calculateBMI() {
    _bmi = curWeight / pow(height / 100, 2);
    return _bmi.toStringAsFixed(1);
  }

  String getResult() {
    if (prevBmi >= 25) {
      if (weightGain > 6 || weightGain < 12)
        return 'Your weight gain is normal';
      else if (weightGain >= 12)
        return 'You are gaining more weight.';
      else
        return 'You are loosing weight';
    } else if (_bmi >= 18) {
      if (weightGain > 12 || weightGain < 18)
        return 'Your weight gain is normal';
      else if (weightGain >= 18)
        return 'You are gaining more weight.';
      else
        return 'You are loosing weight';
    } else {
      if (weightGain > 14 || weightGain < 20)
        return 'Your weight gain is normal';
      else if (weightGain >= 20)
        return 'You are gaining more weight.';
      else
        return 'You are loosing weight';
    }
  }

  String getComments() {
    if (_bmi >= 25) {
      return 'You were over-weight';
    } else if (_bmi >= 18) {
      return 'You had normal weight';
    } else {
      return 'You were under-weight';
    }
  }
}
