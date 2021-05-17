import 'dart:io';

import 'package:all_in_one_news/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  TextEditingController firstNameInputController;
  TextEditingController locationInputController;
  TextEditingController mobileInputController;
  TextEditingController emailInputController;
  TextEditingController pwdInputController;
  TextEditingController confirmPwdInputController;
  TextEditingController pincodeInputController;
  final dateController = TextEditingController();
  @override
  initState() {
    firstNameInputController = new TextEditingController();
    locationInputController = new TextEditingController();
    mobileInputController = new TextEditingController();
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
    confirmPwdInputController = new TextEditingController();
    pincodeInputController = new TextEditingController();
    super.initState();
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  String pwdValidator(String value) {
    if (value.length < 8) {
      return 'Password must be longer than 8 characters';
    } else {
      return null;
    }
  }

  final picker = ImagePicker();
  String chosengender;
  var imgpath;
  File _imageFile;

  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = File(pickedFile.path);
    });
  }

  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = basename(_imageFile.path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    taskSnapshot.ref.getDownloadURL().then((value) {
      imgpath = value;
      print(value);
    });
  }

  var _chosenValue = 'Male';
  String holder = '';
  void getGender() {
    setState(() {
      holder = _chosenValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    int _value;
    return Scaffold(
        appBar: AppBar(
          title: Text("Register"),
        ),
        body: Container(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
                child: Form(
              key: _registerFormKey,
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    radius: MediaQuery.of(context).size.width * 0.3,
                    child: _imageFile == null
                        ? GestureDetector(
                            onTap: () async {
                              pickImage();
                            },
                            child: Image.asset('assets/profilephoto.png'),
                          )
                        : GestureDetector(
                            onTap: () async {
                              pickImage();
                            },
                            child: CircleAvatar(
                              radius: MediaQuery.of(context).size.width * 0.8,
                              backgroundImage: FileImage(_imageFile),
                            ),
                          ),
                  ),
                  TextFormField(
                    decoration:
                        InputDecoration(labelText: 'Name*', hintText: "John"),
                    controller: firstNameInputController,
                    validator: (value) {
                      if (value.length < 3) {
                        return "Please enter a valid first name.";
                      }
                    },
                  ),
                  TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Location*',
                          hintText: "West Bengal, India"),
                      controller: locationInputController,
                      validator: (value) {
                        if (value.length < 3) {
                          return "Please enter a valid location.";
                        }
                      }),
                  TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Pincode*',
                        hintText: '721305',
                      ),
                      keyboardType: TextInputType.number,
                      controller: pincodeInputController,
                      validator: (value) {
                        if (value.length != 6) {
                          return "Please enter a valid pincode.";
                        }
                      }),
                  TextFormField(
                      decoration: InputDecoration(
                        labelText: 'WhatsApp Number*',
                      ),
                      keyboardType: TextInputType.number,
                      controller: mobileInputController,
                      validator: (value) {
                        if (value.length < 10) {
                          return "Please enter a valid mobile number.";
                        }
                      }),
                  TextField(
                    controller: dateController,
                    decoration: InputDecoration(
                        labelText: 'Date Of Birth*', hintText: 'Date Of Birth'),
                    onTap: () async {
                      var date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100));
                      dateController.text = date.toString().substring(0, 10);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    // padding: EdgeInsets.only(top: 8),
                    height: 50,
                    child: DropdownButton<String>(
                      isExpanded: true,
                      focusColor: Colors.white,
                      value: _chosenValue,
                      elevation: 5,
                      underline: Container(
                        padding: EdgeInsets.all(100),
                        height: 1,
                        color: Colors.grey,
                      ),
                      style: TextStyle(color: Colors.white),
                      iconEnabledColor: Colors.black,
                      items: <String>['Male', 'Female', 'Others']
                          .map<DropdownMenuItem<String>>((String value) {
                        chosengender = value;
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                      hint: Text(
                        "Gender*",
                        style: TextStyle(fontSize: 18),
                      ),
                      onChanged: (String value) {
                        setState(() {
                          _chosenValue = value;
                        });
                      },
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Email*', hintText: "john.doe@gmail.com"),
                    controller: emailInputController,
                    keyboardType: TextInputType.emailAddress,
                    validator: emailValidator,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Password*', hintText: "********"),
                    controller: pwdInputController,
                    obscureText: true,
                    validator: pwdValidator,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Confirm Password*', hintText: "********"),
                    controller: confirmPwdInputController,
                    obscureText: true,
                    validator: pwdValidator,
                  ),
                  RaisedButton(
                    child: Text("Register"),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    onPressed: () async {
                      getGender();
                      if (_registerFormKey.currentState.validate()) {
                        if (pwdInputController.text ==
                                confirmPwdInputController.text &&
                            dateController.text != null &&
                            _chosenValue != null) {
                          await uploadImageToFirebase(context);
                          FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: emailInputController.text,
                                  password: pwdInputController.text)
                              .then((currentUser) => FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(FirebaseAuth.instance.currentUser.uid)
                                  .set({
                                    "uid":
                                        FirebaseAuth.instance.currentUser.uid,
                                    "fname": firstNameInputController.text,
                                    "phone": mobileInputController.text,
                                    "email": emailInputController.text,
                                    "location": locationInputController.text,
                                    "photo": imgpath,
                                    "pincode": pincodeInputController.text,
                                    'dateofbirth': dateController.text,
                                    'gender': holder,
                                  })
                                  .then((result) => {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => MyHomePage(
                                                uid: FirebaseAuth
                                                    .instance.currentUser.uid,
                                              ),
                                            )),
                                        firstNameInputController.clear(),
                                        mobileInputController.clear(),
                                        locationInputController.clear(),
                                        emailInputController.clear(),
                                        pwdInputController.clear(),
                                        confirmPwdInputController.clear()
                                      })
                                  .catchError((err) => print(err)))
                              .catchError((err) => print(err));
                        } else {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Error"),
                                  content: Text(
                                      "The passwords do not match \nOr, Date of Birth not enter\nOr, Gender not selected"),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text("Close"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                );
                              });
                        }
                      }
                    },
                  ),
                  Text("Already have an account?"),
                  FlatButton(
                    child: Text("Login here!"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ))));
  }
}
