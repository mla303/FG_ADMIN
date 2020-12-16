import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fg_admin/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'editProfile.dart';

class Profile extends StatefulWidget {
  DocumentSnapshot profile_document;
  String photo_url="";
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  void initState() {
    // TODO: implement initState
    print(FirebaseAuth.instance.currentUser.uid);
    FirebaseFirestore.instance.collection("Profile").doc(FirebaseAuth.instance.currentUser.uid).get().then((doc) {
     setState(() {
       widget.profile_document = doc;
       widget.photo_url=doc["photo url"];
     });
      print(widget.profile_document);
    });
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Image.asset('images/F G  T R C K N L G Y.png', fit: BoxFit.cover),
        backgroundColor: Color(0xFFFF3D3A3A),
      ),
      body: widget.profile_document==null
          ?Center(child: CircularProgressIndicator(),)
          :SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                width: 75.0,
              ),

              //***** PROFILE PICTURE

              CircleAvatar(
                backgroundColor: Colors.black12,
                backgroundImage:widget.photo_url!=""|| widget.photo_url!=null? NetworkImage(widget.photo_url

                ):null,
                // widget.photo_url==""|| widget.photo_url==null? Icon(Icons.person,color: Colors.black54,):Image.network(
                //     widget.photo_url



                radius: 60.0,
              ),
              SizedBox(height: 15.0),
              Text(
                'Admin',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  fontFamily: 'PoppinBold',
                ),
              ),
              Divider(height: 10.0),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Personal info',
                      style: TextStyle(
                          fontFamily: 'PoppinBold',
                          fontSize: 20.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

              //***** USER NAME DISPLAY
              infoTile(
                icon: Icons.account_circle_outlined,
                title: 'Name',
                txt:  widget.profile_document["name"]?? "",
              ),
              Divider(height: 10.0),
              //***** USER EMAIL DISPLAY
              infoTile(
                icon: Icons.mail,
                title: 'Email',
                txt:widget.profile_document["email"]??"",
              ),
              Divider(height: 10.0),
              GestureDetector(
                onTap: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50.0,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.arrowCircleLeft,
                        color: Colors.grey,
                        size: 30.0,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      //***** LOGOUT BUTTON
                      Text(
                        'Logout',
                        style: TextStyle(
                            fontFamily: 'Poppin',
                            fontSize: 15.0,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(height: 10.0),
              SizedBox(
                height: 20.0,
              ),

              //***** EDIT PROFILE BUTTON
              Button(
                onPress: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EditProfile(widget.profile_document)));
                },
                buttonTitle: 'Edit Profile',
                colour: Color(0xFFFF3D3A3A),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class infoTile extends StatelessWidget {
  const infoTile({this.icon, this.title, this.txt});
  final IconData icon;
  final String title;
  final String txt;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(
              icon,
              color: Colors.grey,
              size: 30.0,
            ),
            SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            fontFamily: 'Poppin',
                            fontSize: 15.0,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                    ]),
                SizedBox(width: 10.0),
                Text(
                  txt,
                  style: TextStyle(
                    fontFamily: 'Poppin',
                    color: Colors.grey,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
