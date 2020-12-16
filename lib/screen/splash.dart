import 'dart:async';

import 'package:fg_admin/constant.dart';
import 'package:fg_admin/screen/signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'intro.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool intro=false;
  @override
  void initState() {
    super.initState();

    Timer(
        Duration(seconds: 5),
        () {
          SharedPreferences.getInstance().then((pref) {
            intro = pref.getBool(intro_done) ?? false;
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => SignIn()));
          });
        }

    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
              //Background Image
              image: AssetImage("images/fetto.jpg"),
              fit: BoxFit.cover,
              colorFilter: new ColorFilter.mode(
                  Colors.white.withOpacity(0.3), BlendMode.dstATop),
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //**** LOGO
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 120.0,
                  child: Image(
                    image: AssetImage('images/logoo.png'),
                    colorBlendMode: BlendMode.overlay,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50.0,
                  child: Image(
                    image: AssetImage('images/F G  T R C K N L G Y.png'),
                    colorBlendMode: BlendMode.overlay,
                  ),
                ),

                SizedBox(height: 20,),
                new SpinKitPouringHourglass(
                  color: Color(0xffF9FF43),
                  size: 32,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
