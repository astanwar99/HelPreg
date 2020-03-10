import 'package:flutter/material.dart';
import 'package:pregnency_helper/components/reusable_card.dart';
import 'package:pregnency_helper/components/reusable_child_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pregnency_helper/screens/user_activities/bmi.dart';
import 'package:pregnency_helper/screens/user_activities/user_profile.dart';

class UserScreen extends StatefulWidget {
  static String id = 'user_screen';
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('USER'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ReusableCard(
                      colour: Colors.lightBlueAccent,
                      cardChild: ReusableChildCard(
                        childCardIcon: FontAwesomeIcons.user,
                        childCardText: 'PROFILE',
                      ),
                      launchScreen: UserProfile.id,
                    ),
                  ),
                  Expanded(
                    child: ReusableCard(
                      colour: Colors.lightBlueAccent,
                      cardChild: ReusableChildCard(
                        childCardIcon: FontAwesomeIcons.weight,
                        childCardText: 'BMI Tracker',
                      ),
                      launchScreen: BMI.id,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ReusableCard(
                      colour: Colors.lightBlueAccent,
                      cardChild: ReusableChildCard(
                        childCardIcon: FontAwesomeIcons.nutritionix,
                        childCardText: 'NUTRITION',
                      ),
                      //launchScreen: ,
                    ),
                  ),
                  Expanded(
                    child: ReusableCard(
                      colour: Colors.lightBlueAccent,
                      cardChild: ReusableChildCard(
                        childCardIcon: FontAwesomeIcons.medkit,
                        childCardText: 'SYMPTOMS',
                      ),
                      //launchScreen: ,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ReusableCard(
                      colour: Colors.lightBlueAccent,
                      cardChild: ReusableChildCard(
                        childCardIcon: FontAwesomeIcons.comments,
                        childCardText: 'FORUM',
                      ),
                      //launchScreen: ,
                    ),
                  ),
                  Expanded(
                    child: ReusableCard(
                      colour: Colors.lightBlueAccent,
                      cardChild: ReusableChildCard(
                        childCardIcon: FontAwesomeIcons.ambulance,
                        childCardText: 'EMERGENCY',
                      ),
                      //launchScreen: ,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
