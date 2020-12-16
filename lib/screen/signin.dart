import 'package:fg_admin/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fg_admin/constant.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'forgot_Password.dart';
import 'home.dart';
import 'package:fg_admin/constant.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController email_controller = TextEditingController();
  TextEditingController passwrord_controller = TextEditingController();
  bool saving=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ModalProgressHUD(
        inAsyncCall: saving,
        child: SingleChildScrollView(
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
                        autoPlayInterval: Duration(seconds: 6),
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
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 20.0, left: 20.0, bottom: 20.0),
                    child: Center(
                      child: Form(
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 100.0,
                                //****** LOGO
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
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20.0),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      'Login in to ',
                                      style: TextStyle(
                                          fontSize: 22.0,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'FG',
                                      style: TextStyle(
                                          fontSize: 22.0,
                                          color: Colors.yellow,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      ' TRCANLGY',
                                      style: TextStyle(
                                          fontSize: 22.0,
                                          color: Color(0xFFFF80C9E4),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 30.0),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20.0),
                                child: Row(
                                  children: [
                                    Text('Email', style: kTextStyle),
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

                                  //***** ENTER EMAIL TEXT FIELD
                                  child: TextFormField(
                                    controller: email_controller,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: kTxtField.copyWith(
                                        contentPadding: EdgeInsets.only(left: 12),
                                        hintText: 'Enter your Email'),
                                  )),
                              SizedBox(
                                height: 10.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20.0),
                                child: Row(
                                  children: [
                                    Text(
                                      'Password',
                                      style: kTextStyle,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                                width: 330.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: Colors.white,
                                  boxShadow: kElevationToShadow[6],
                                ),

                                //***** ENTER PASSWORD TEXT FIELD

                                child: TextFormField(
                                  controller: passwrord_controller,
                                  obscureText: true,
                                  decoration: kTxtField.copyWith(
                                    contentPadding: EdgeInsets.only(left: 12),
                                      hintText: 'Enter Your Password'),
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  //******* FORGOT PASSWORD
                                  FlatButton(
                                    splashColor: Colors.grey,
                                    minWidth: 10.0,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Password(),
                                        ),
                                      );
                                    },
                                    child: Text("Forgot Password ?",
                                        style: kTextStyle),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                //******* LOGIN BUTTON**
                                child: Button(
                                  onPress: () {
                                   if(passwrord_controller.text.trim()==""||email_controller.text.trim()==""){
                                     Fluttertoast.showToast( msg: "Please fill all fields",
                                         toastLength: Toast.LENGTH_LONG,
                                         gravity: ToastGravity.BOTTOM,
                                         timeInSecForIosWeb: 2,
                                         backgroundColor: Colors.red[400],
                                         textColor: Colors.white,
                                         fontSize: 16.0);
                                   }
                                   else
                                     {
                                       setState(() {
                                         saving =true;
                                       });


//                                        EmailAuthCredential credential = EmailAuthProvider.credential(email: FirebaseAuth.instance.currentUser.email, password: passwrord_controller.text.trim());
//
// // Reauthenticate
//                                        FirebaseAuth.instance.currentUser.reauthenticateWithCredential(credential)

                                       FirebaseAuth.instance.signInWithEmailAndPassword(email: email_controller.text, password: passwrord_controller.text)
                                           .then((value) {

                                         Navigator.pushReplacement(
                                             context,
                                             MaterialPageRoute(
                                                 builder: (context) => HomeScreen()));

                                       }).catchError((error){
                                         setState(() {
                                           saving=false;
                                         });
                                         Fluttertoast.showToast( msg: error.message.toString(),
                                             toastLength: Toast.LENGTH_LONG,
                                             gravity: ToastGravity.BOTTOM,
                                             timeInSecForIosWeb: 3,
                                             backgroundColor: Colors.red[400],
                                             textColor: Colors.white,
                                             fontSize: 16.0);

                                       });
                                     }

                                  },
                                  colour: Color(0xFFFF3D3A3A),
                                  buttonTitle: 'Login',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
