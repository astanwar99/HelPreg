import 'package:flutter/material.dart';
import 'package:pregnency_helper/constants.dart';

class ReusableChildCard extends StatelessWidget {
  ReusableChildCard({this.childCardIcon, this.childCardText});

  final IconData childCardIcon;
  final String childCardText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          childCardIcon,
          size: 80.0,
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(
          childCardText,
          style: kLabelTextStyle,
        ),
      ],
    );
  }
}
