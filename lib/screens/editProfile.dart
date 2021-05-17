import 'package:all_in_one_news/screens/home.dart';
import 'package:all_in_one_news/screens/myprofile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'profile.dart';
import 'video.dart';

class editProfile extends StatefulWidget {
  final String imgPath;
  final String name;
  final String location;
  final String pincode;
  final String dob;
  final String mobile;
  final String mail;
  final String gender;
  const editProfile(
      {Key key,
      this.imgPath,
      this.name,
      this.location,
      this.pincode,
      this.dob,
      this.mobile,
      this.mail,
      this.gender})
      : super(key: key);

  @override
  _editProfileState createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
  User currentUser;
  TextEditingController firstNameInputController = new TextEditingController();
  TextEditingController locationInputController = new TextEditingController();
  TextEditingController mobileInputController = new TextEditingController();
  TextEditingController emailInputController = new TextEditingController();
  TextEditingController pincodeInputController = new TextEditingController();
  final dateController = TextEditingController();

  @override
  initState() {
    this.getCurrentUser();
    firstNameInputController.text = widget.name;
    locationInputController.text = widget.location;
    mobileInputController.text = widget.mobile;
    emailInputController.text = widget.mail;
    pincodeInputController.text = widget.pincode;
    dateController.text = widget.dob;
    super.initState();
  }

  void getCurrentUser() async {
    currentUser = await FirebaseAuth.instance.currentUser;
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black87,
        ),
        drawer: Drawer(
          child: SafeArea(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  title: Text('Home'),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyHomePage(
                                  uid: currentUser.uid,
                                )));
                  },
                ),
                Divider(),
                ListTile(
                  title: Text('Video'),
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => VideoNews()));
                  },
                ),
                Divider(),
                ListTile(
                  title: Text('Profile'),
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Profile()));
                  },
                ),
                Divider(),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(widget.imgPath),
                radius: MediaQuery.of(context).size.width * 0.3,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name',
                        style: TextStyle(
                          color: Colors.black26,
                          fontSize: 15,
                        ),
                      ),
                      TextField(
                          controller: firstNameInputController,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.black),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                          )),
                      Text(
                        'Location',
                        style: TextStyle(
                          color: Colors.black26,
                          fontSize: 15,
                        ),
                      ),
                      TextField(
                          controller: locationInputController,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.black),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                          )),
                      Text(
                        'Pincode',
                        style: TextStyle(
                          color: Colors.black26,
                          fontSize: 15,
                        ),
                      ),
                      TextField(
                          controller: pincodeInputController,
                          decoration: InputDecoration(
                            // hintText: widget.pincode,
                            hintStyle: TextStyle(color: Colors.black),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                          )),
                    ]),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date of Birth',
                        style: TextStyle(
                          color: Colors.black26,
                          fontSize: 15,
                        ),
                      ),
                      TextField(
                        controller: dateController,
                        onTap: () async {
                          var date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100));
                          dateController.text =
                              date.toString().substring(0, 10);
                        },
                      ),
                    ]),
              ),
              // Padding(
              //   padding:
              //       const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30.0),
              //   child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Text(
              //           'Gender',
              //           style: TextStyle(
              //             color: Colors.black26,
              //             fontSize: 15,
              //           ),
              //         ),
              //         TextField(
              //             readOnly: true,
              //             enableInteractiveSelection: false,
              //             decoration: InputDecoration(
              //               hintText: widget.Gender,
              //               hintStyle: TextStyle(color: Colors.black),
              //               enabledBorder: UnderlineInputBorder(
              //                   borderSide: BorderSide(color: Colors.grey)),
              //             )),
              //       ]),
              // ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'WhatsApp',
                        style: TextStyle(
                          color: Colors.black26,
                          fontSize: 15,
                        ),
                      ),
                      TextField(
                          controller: mobileInputController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            // hintText: '+91-' + widget.mobile,
                            hintStyle: TextStyle(color: Colors.black),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                          )),
                    ]),
              ),
              // Padding(
              //   padding:
              //       const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30.0),
              //   child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Text(
              //           'Email',
              //           style: TextStyle(
              //             color: Colors.black26,
              //             fontSize: 15,
              //           ),
              //         ),
              //         TextField(
              //             readOnly: true,
              //             enableInteractiveSelection: false,
              //             decoration: InputDecoration(
              //               hintText: widget.mail,
              //               hintStyle: TextStyle(color: Colors.black),
              //               enabledBorder: UnderlineInputBorder(
              //                   borderSide: BorderSide(color: Colors.grey)),
              //             )),
              //       ]),
              // ),
              ElevatedButton(
                child: Text('Update'),
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection("users")
                      .doc(currentUser.uid)
                      .update({
                    'fname': firstNameInputController.text,
                    'location': locationInputController.text,
                    'pincode': pincodeInputController.text,
                    'dateofbirth': dateController.text,
                    'phone': mobileInputController.text
                  }).then((value) {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyProfile(
                                  uid: currentUser.uid,
                                  fname: firstNameInputController.text,
                                  location: locationInputController.text,
                                  pincode: pincodeInputController.text,
                                  photo: widget.imgPath,
                                  mobile: mobileInputController.text,
                                  mail: widget.mail,
                                  dob: widget.dob,
                                  gender: widget.gender,
                                )));
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
