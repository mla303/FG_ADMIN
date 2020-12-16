import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fg_admin/constant.dart';
import 'package:fg_admin/button.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Password extends StatefulWidget {
  @override
  _PasswordState createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  TextEditingController email_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: <Widget>[
                  Container(
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: MediaQuery.of(context).size.height,
                        aspectRatio: 16 / 9,
                        viewportFraction: 1.0,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.linearToEaseOut,
                        enlargeCenterPage: true,
                        //onPageChanged: callbackFunction,
                        scrollDirection: Axis.horizontal,
                      ),
                      items: [
                        Container(
                            margin: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                image: AssetImage('images/fetto.jpg'),
                                fit: BoxFit.cover,
                                colorFilter: new ColorFilter.mode(
                                    Colors.white.withOpacity(0.3),
                                    BlendMode.dstATop),
                              ),
                            ),
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width),
                      ],
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 20.0, left: 20.0, bottom: 20.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Form(
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 160.0,
                              ),
                              //***** LOGO IMAGE
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 100.0,
                                child: Image(
                                  image: AssetImage('images/logoo.png'),
                                  colorBlendMode: BlendMode.overlay,
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 40.0,
                                child: Image(
                                  image: AssetImage(
                                      'images/F G  T R C K N L G Y.png'),
                                  colorBlendMode: BlendMode.overlay,
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Reset Password',
                                    style: kTextStyle,
                                  ),
                                ],
                              ),
                              SizedBox(height: 30.0),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20.0),
                                child: Row(
                                  children: [
                                    Text(
                                      'Email',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Container(
                                  padding:
                                      EdgeInsets.only(left: 10.0, right: 10.0),
                                  width: 330.0,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    color: Colors.white,
                                    boxShadow: kElevationToShadow[6],
                                  ),

                                  // ****** EMAIL TEXT FIELD RESET PASSWORD
                                  child: TextFormField(
                                    controller: email_controller,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: kTxtField.copyWith(
                                        hintText: '  Enter your Email'),
                                  )),
                              SizedBox(
                                height: 30.0,
                              ),
                              //***** LOGIN BUTTON
                              Button(
                                onPress: () {
                                  FirebaseAuth.instance.sendPasswordResetEmail(email: email_controller.text.trim()).then((value) => {
                                    Fluttertoast.showToast(msg: "Password reset email has been sent successfully,\nCheck your email",
                                    timeInSecForIosWeb: 5)

                                  }).catchError((e){
                                    Fluttertoast.showToast(msg:e.message);
                                  });

                                },
                                colour: Color(0xFFFF3D3A3A),
                                buttonTitle: 'Send',
                              ),
                              Container(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
