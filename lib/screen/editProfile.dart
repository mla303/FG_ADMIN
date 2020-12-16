import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fg_admin/screen/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fg_admin/button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  DocumentSnapshot profile ;
  EditProfile(this.profile);
   bool password_is_correct = false;

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController name_controller =TextEditingController();
  TextEditingController password_controller =TextEditingController();
  TextEditingController new_password_controller =TextEditingController();
  TextEditingController confirm_password_controller =TextEditingController();
  var image_file;
   bool name_changed=false;
 // bool password_changed=false;

 @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              Image.asset('images/F G  T R C K N L G Y.png', fit: BoxFit.cover),
          backgroundColor: Color(0xFFFF3D3A3A),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              //***** PROFILE PICTURE
              Stack(alignment: Alignment.center, children: <Widget>[
                Container(
                  child: CircleAvatar(
                    backgroundImage:image_file==null? NetworkImage(widget.profile["photo url"]):
                    FileImage(File(image_file.path),),
                    radius: 60.0,
                  ),
                ),
                //**** CAMERA ICON FOR UPLOAD PROFILE PIC
                Positioned(
                  top: 78.0,
                  left: 75.0,
                  child: IconButton(
                    icon: Icon(Icons.camera_alt_rounded,color: Colors.grey[800],),
                    onPressed: () {
                      ImagePicker().getImage(source: ImageSource.gallery).then((img) {
                        setState(() {
                          image_file=img;
                        });
                      });
                    },
                    iconSize: 40.0,
                  ),
                )
              ]),
              SizedBox(height: 25.0),
              Divider(height: 10.0),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 5.0),
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

              //***** NAME TEXT FIELD
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Icon(
                      Icons.account_circle_outlined,
                      color: Colors.grey,
                      size: 25.0,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name',
                          style: TextStyle(
                              fontFamily: 'Poppin',
                              fontSize: 15.0,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          width: 240.0,
                          height: 30,
                          // color: Colors.red,

                          child: TextFormField(
                            onChanged: (txt){
                              name_changed=true;
                            },
                            controller: name_controller,
                            //**********
                            decoration: InputDecoration(
                              hintText: widget.profile["name"],
                              border: InputBorder.none,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                height: 10.0,
              ),
              //***** CURRENT PASSWORD TEXT FIELD
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Icon(
                      Icons.lock,
                      color: Colors.grey,
                      size: 25.0,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    // Divider(
                    //   height: 10.0,
                    // ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Current Password',
                          style: TextStyle(
                              fontFamily: 'Poppin',
                              fontSize: 15.0,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          width: 240.0,
                          height: 20,
                          child: TextFormField(
                            controller: password_controller,
                            obscureText: true,

                            //**********
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                height: 10.0,
              ),
              //***** NEW PASSWORD TEXT FIELD
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Icon(
                      Icons.lock,
                      color: Colors.grey,
                      size: 25.0,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'New Password',
                          style: TextStyle(
                              fontFamily: 'Poppin',
                              fontSize: 15.0,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          width: 240.0,
                          height: 20,
                          child: TextFormField(
                            controller: new_password_controller,
                            //**********
                            obscureText: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                height: 10.0,
              ),

              //***** RE-ENTER NEW PASSWORD TEXT FIELD
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Icon(
                      Icons.lock,
                      color: Colors.grey,
                      size: 25.0,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Re-enter New Password',
                          style: TextStyle(
                              fontFamily: 'Poppin',
                              fontSize: 15.0,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          width: 240.0,
                          height: 20,
                          child: TextFormField(
                            controller: confirm_password_controller,
                            //**********
                            obscureText: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                height: 10.0,
              ),
              SizedBox(
                height: 10.0,
              ),
              Button(
                onPress: ()
                async{
                  bool name_updated=false;
                  if(image_file!=null)
                    {
                      Fluttertoast.showToast(msg: "Updating profile pic");
                      Reference reference = FirebaseStorage.instance.ref().child("Profile/profilepic");
                      UploadTask uploadTask = reference.putFile(File(image_file.path));
                      uploadTask.then((val) {
                        reference.getDownloadURL().then((url) {
                          name_controller.text.trim()!=""?
                          FirebaseFirestore.instance.collection("Profile").doc(FirebaseAuth.instance.currentUser.uid).update({
                            "photo url":url
                          }).then((value) {
                            Fluttertoast.showToast(msg: "Profile pic updated");
                          }):
                          FirebaseFirestore.instance.collection("Profile").doc(FirebaseAuth.instance.currentUser.uid).update({
                            "photo url":url,
                            "name":name_controller.text.trim()
                          }).then((value) {
                            name_updated=true;
                            Fluttertoast.showToast(msg: "Profile pic and name updated");
                          });
                        });
                      });
                    }
               if(name_controller.text.trim()!=""&&!name_updated)
                 {
                   Fluttertoast.showToast(msg: "Name password");
                   FirebaseFirestore.instance.collection("Profile").doc(FirebaseAuth.instance.currentUser.uid).update({"name":name_controller.text.trim()}).then((value) {
                     Fluttertoast.showToast(msg: "Name updated");
                   });
                 }

                  if(new_password_controller.text.trim()!="")
                    {

                      FirebaseAuth.instance.signInWithEmailAndPassword(email: FirebaseAuth.instance.currentUser.email, password: password_controller.text.trim()).then((user) {
                        print(user);
                        widget.password_is_correct=true;
                        if(new_password_controller.text.trim()==confirm_password_controller.text.trim())
                        {
                          Fluttertoast.showToast(msg: "Updating password");
                          FirebaseAuth.instance.currentUser.updatePassword(new_password_controller.text.trim()).then((value) {

                            Fluttertoast.showToast(msg: "Password updated");
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => Profile()));
                          });
                        }
                        else
                        {
                          Fluttertoast.showToast(msg: "Please enter same password in confirm password field",textColor: Colors.white,timeInSecForIosWeb: 3,backgroundColor: Colors.red[400]);
                        }

                      }).catchError((e){
                        if(e.message=="The password is invalid or the user does not have a password.")
                          {
                            Fluttertoast.showToast(msg: "Incorrect password",backgroundColor: Colors.red[400]);
                          }
                        else
                        Fluttertoast.showToast(msg: e.message);
                      });




                      //
                      // bool is_correct= await checkPassword();
                      // if(is_correct)
                      //   {
                      //     //update password
                      //     if(new_password_controller.text.trim()==confirm_password_controller.text.trim())
                      //       {
                      //         Fluttertoast.showToast(msg: "Updating password");
                      //         FirebaseAuth.instance.currentUser.updatePassword(new_password_controller.text.trim()).then((value) {
                      //
                      //           Fluttertoast.showToast(msg: "Password updated");
                      //         });
                      //       }
                      //     else
                      //       {
                      //         Fluttertoast.showToast(msg: "Please confirm your password carefully",textColor: Colors.red[400],timeInSecForIosWeb: 3);
                      //       }
                      //   }
                      // else{
                      //   Fluttertoast.showToast(msg: "Incorrect password",textColor: Colors.red[400]);
                      // }
                    }
                  if(name_controller.text.trim()==""&&image_file==null&&new_password_controller.text.trim()=="")
                    {
                      // print("Hello world meta data: ${FirebaseAuth.instance.currentUser.refreshToken}");
                      // print("Hello world providor data: ${FirebaseAuth.instance.currentUser.providerData}");
                      Fluttertoast.showToast(msg: "Nothing to update");

                    }
                  /////////////////////////////////////////////////////////

                },
                buttonTitle: 'Update Profile',
                colour: Color(0xFFFF3D3A3A),
              )
            ]),
          ),
        ));
  }
}
