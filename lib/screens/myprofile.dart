import 'package:all_in_one_news/screens/editProfile.dart';
import 'package:all_in_one_news/screens/home.dart';
import 'package:all_in_one_news/screens/savedNews.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'video.dart';

class MyProfile extends StatefulWidget {
  final String uid;
  final String fname;
  final String dob;
  final String mail;
  final String gender;
  final String location;
  final String mobile;
  final String photo;
  final String pincode;

  const MyProfile({
    Key key,
    this.uid,
    this.fname,
    this.dob,
    this.mail,
    this.gender,
    this.location,
    this.pincode,
    this.photo,
    this.mobile,
  }) : super(key: key);

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  User currentUser;

  @override
  initState() {
    this.getCurrentUser();
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
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: Icon(
                  Icons.bookmark_border_outlined,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SavedNews(
                                uid: widget.uid,
                              )));
                },
              ),
            )
          ],
        ),
        drawer: Drawer(
          child: SafeArea(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                    title: Text('Home'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).pop();
                    }),
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
                    Navigator.of(context).pop();
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
              Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.35,
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: widget.photo != null
                          ? NetworkImage(widget.photo)
                          : AssetImage('assets/profilephoto.png'),
                      radius: MediaQuery.of(context).size.width * 0.17,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.fname,
                      style: TextStyle(color: Colors.deepOrange, fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextButton(
                        child: Text(
                          'Edit Profile',
                          style: TextStyle(color: Colors.deepOrange),
                        ),
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => editProfile(
                                      imgPath: widget.photo,
                                      name: widget.fname,
                                      location: widget.location,
                                      pincode: widget.pincode,
                                      dob: widget.dob,
                                      mobile: widget.mobile,
                                      mail: widget.mail,
                                      gender: widget.gender,
                                    ))))
                  ],
                ),
                color: Colors.black12,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Location',
                        style: TextStyle(
                          color: Colors.black26,
                          fontSize: 15,
                        ),
                      ),
                      TextField(
                          readOnly: true,
                          enableInteractiveSelection: false,
                          decoration: InputDecoration(
                            hintText: widget.location,
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
                        'Pincode',
                        style: TextStyle(
                          color: Colors.black26,
                          fontSize: 15,
                        ),
                      ),
                      TextField(
                          readOnly: true,
                          enableInteractiveSelection: false,
                          decoration: InputDecoration(
                            hintText: widget.pincode,
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
                          readOnly: true,
                          enableInteractiveSelection: false,
                          decoration: InputDecoration(
                            hintText: widget.dob,
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
                        'Gender',
                        style: TextStyle(
                          color: Colors.black26,
                          fontSize: 15,
                        ),
                      ),
                      TextField(
                          readOnly: true,
                          enableInteractiveSelection: false,
                          decoration: InputDecoration(
                            hintText: widget.gender,
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
                        'WhatsApp',
                        style: TextStyle(
                          color: Colors.black26,
                          fontSize: 15,
                        ),
                      ),
                      TextField(
                          readOnly: true,
                          enableInteractiveSelection: false,
                          decoration: InputDecoration(
                            hintText: '+91-' + widget.mobile,
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
                        'Email',
                        style: TextStyle(
                          color: Colors.black26,
                          fontSize: 15,
                        ),
                      ),
                      TextField(
                          readOnly: true,
                          enableInteractiveSelection: false,
                          decoration: InputDecoration(
                            hintText: widget.mail,
                            hintStyle: TextStyle(color: Colors.black),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                          )),
                    ]),
              ),
              ElevatedButton(
                child: Text('LogOut'),
                onPressed: () {
                  FirebaseAuth.instance
                      .signOut()
                      .then((value) => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePage(
                                    uid: null,
                                  ))));
                },
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
