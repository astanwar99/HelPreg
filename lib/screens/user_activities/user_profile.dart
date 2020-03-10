import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pregnency_helper/components/reusable_card.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

class UserProfile extends StatefulWidget {
  static String id = 'user_profile';
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final _auth = FirebaseAuth.instance;
  bool profileExists = false;
  String name;
  String email;
  String bloodGroup;
  String mobile;
  String eMobile;
  String dob;
  String height;
  String prePregWeight;

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
        name = userProfile.data['name'];
        email = userProfile.data['email'];
        bloodGroup = userProfile.data['bloodg'];
        dob = userProfile.data['dob'];
        mobile = userProfile.data['mobile'];
        eMobile = userProfile.data['emobile'];
        prePregWeight = userProfile.data['weight'];
        height = userProfile.data['height'];
        profileExists = true;
        setState(() {});
        break;
      }
    }
    return null;
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildProfileWarning() {
    return FutureBuilder<String>(
      future: getProfile(), // a Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return CircularProgressIndicator();
          default:
            if (snapshot.hasError)
              return new Text('Error: ${snapshot.error}');
            else
              return Visibility(
                visible: !profileExists,
                child: Row(children: <Widget>[
                  Text('Update your Profile.'),
                  RaisedButton(
                    child: Text('Update now'),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  TextFormField(
                                    decoration:
                                        InputDecoration(labelText: 'Name'),
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return 'All fields are required';
                                      }
                                      return null;
                                    },
                                    onSaved: (String value) {
                                      name = value;
                                    },
                                  ),
                                  TextFormField(
                                    decoration:
                                        InputDecoration(labelText: 'Height'),
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return 'All fields are required';
                                      }
                                      return null;
                                    },
                                    onSaved: (String value) {
                                      height = value;
                                    },
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                        labelText: 'Pre-pregnancy weight'),
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return 'All fields are required';
                                      }
                                      return null;
                                    },
                                    onSaved: (String value) {
                                      prePregWeight = value;
                                    },
                                  ),
                                  RaisedButton(
                                    child: Text("Submit"),
                                    onPressed: () {
                                      setState(() {
                                        if (!_formKey.currentState.validate()) {
                                          return;
                                        }
                                        _formKey.currentState.save();
                                        profileExists = true;
                                        _firestore.collection('users').add({
                                          'email': loggedInUser.email,
                                          'name': name,
                                          'weight': prePregWeight,
                                          'height': height,
                                          'dob': null,
                                          'mobile': null,
                                          'emobile': null,
                                          'bloodgroup': null,
                                        });
                                        Navigator.pop(context);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ]),
              );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pending Claims'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          profileExists ? Text('Current Profile') : _buildProfileWarning(),
          Expanded(
            child: ReusableCard(
              colour: Colors.lightBlueAccent,
              cardChild: Center(child: Text('Name: $name')),
            ),
          ),
          Expanded(
            child: ReusableCard(
              colour: Colors.lightBlueAccent,
              cardChild: Center(child: Text('Email: $email')),
            ),
          ),
          Expanded(
            child: ReusableCard(
              colour: Colors.lightBlueAccent,
              cardChild: Center(child: Text('Mobile: $mobile')),
            ),
          ),
          Expanded(
            child: ReusableCard(
              colour: Colors.lightBlueAccent,
              cardChild: Center(child: Text('Emergency Mobile: $eMobile')),
            ),
          ),
          Expanded(
            child: ReusableCard(
              colour: Colors.lightBlueAccent,
              cardChild: Center(child: Text('BloodGroup: $bloodGroup')),
            ),
          ),
          Expanded(
            child: ReusableCard(
              colour: Colors.lightBlueAccent,
              cardChild: Center(child: Text('DOB: $dob')),
            ),
          ),
          Expanded(
            child: ReusableCard(
              colour: Colors.lightBlueAccent,
              cardChild: Center(child: Text('Height: $height')),
            ),
          ),
          Expanded(
            child: ReusableCard(
              colour: Colors.lightBlueAccent,
              cardChild: Center(child: Text('Weight: $prePregWeight')),
            ),
          ),
        ],
      ),
    );
  }
}
