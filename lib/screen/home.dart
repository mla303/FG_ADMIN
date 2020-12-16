import 'package:fg_admin/firebase/firestore.dart';
import 'package:fg_admin/screen/signin.dart';
import 'package:fg_admin/screen/videoUpload.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fg_admin/homePageCard.dart';
import 'category.dart';
import 'profile.dart';
import 'imageUpload.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> categories_list = <String>[];
  DB db = DB();
  @override
  void initState() {
    // TODO: implement initState

    db.getCategoriesList().then((list) {
      categories_list = list;
      print("here you go $categories_list");
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              //******* VIDEO UPLOAD CARD
              HomePageCard(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => VideoUpload(categories_list)
                      )
                  );
                },
                buttonTitle: 'Video',
                icon: Icons.ondemand_video_outlined,
              ),
              SizedBox(
                height: 10.0,
              ),

              //******* IMAGE UPLOAD CARD
              HomePageCard(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ImageUpload(categories_list),
                      ));
                },
                buttonTitle: 'Slide Show',
                icon: Icons.camera_alt_rounded,
              ),
              SizedBox(
                height: 10.0,
              ),

              //***** CATEGORY CARD
              HomePageCard(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Category(),
                    ),
                  );
                },
                buttonTitle: 'Category',
                icon: Icons.article_outlined,
              ),
              SizedBox(
                height: 10.0,
              ),
              //******* PROFILE CARD
              HomePageCard(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Profile(),
                    ),
                  );
                },
                buttonTitle: 'Profile',
                icon: Icons.account_circle_outlined,
              ),
              SizedBox(
                height: 10.0,
              ),

              //******* LOGOUT CARD
              HomePageCard(
                onTap: () {

                  FirebaseAuth.instance.signOut().then((value) {

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignIn(),
                      ),
                    );
                    // Navigator.pop(context);
                  });
                },
                buttonTitle: 'Logout',
                icon: (FontAwesomeIcons.arrowCircleLeft),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
