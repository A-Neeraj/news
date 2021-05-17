import 'package:all_in_one_news/screens/Login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'myprofile.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  initState() {
    if (FirebaseAuth.instance.currentUser == null) {
      Navigator.pop(context);
      // Navigator.pop(context);
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Login()));
      });
    } else {
      FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser.uid)
          .get()
          .then((value) => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => MyProfile(
                        fname: value['fname'],
                        location: value['location'],
                        mail: value['email'],
                        uid: FirebaseAuth.instance.currentUser.uid,
                        photo: value['photo'],
                        pincode: value['pincode'],
                        dob: value['dateofbirth'],
                        mobile: value['phone'],
                        gender: value['gender'],
                      ))))
          .catchError((err) => print(err));
    }
    super.initState();
  }

  Widget build(BuildContext context) {
    return Container();
  }
}
