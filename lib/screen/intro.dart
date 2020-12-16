import 'package:dots_indicator/dots_indicator.dart';
import 'package:fg_admin/button.dart';
import 'package:fg_admin/constant.dart';
import 'package:fg_admin/screen/walkthrough.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'signin.dart';

class IntroScreen extends StatefulWidget {
  @override
  IntroScreenState createState() {
    return IntroScreenState();
  }
}

class IntroScreenState extends State<IntroScreen> {
  final PageController controller = PageController();
  int currentPage = 0;
  bool lastPage = false;

  void _onPageChanged(int page) {
    setState(() {
      currentPage = page;
      // if (currentPage == 2) {
      //   lastPage = true;
      // } else {
      //   lastPage = false;
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Expanded(
            flex: 3,
            child: PageView(
              children: <Widget>[
                myWalkthrough(
                  title: "Plan Your Trip",
                  content:
                      "Book one of our unique hotel to escape the ordinary",
                  image: "images/scooter2.png",
                ),
                myWalkthrough(
                  title: "Find Best Deal",
                  content:
                      "Find deals for any season from cosy country home to city flats",
                  image: "images/scooter1.png",
                ),
              ],
              controller: controller,
              onPageChanged: _onPageChanged,
            ),
          ),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.center,
              child: DotsIndicator(
                position: currentPage.toDouble(),
                dotsCount: 2,
                decorator: DotsDecorator(
                  // activeColor: basicColor,
                  color: Colors.grey,
                  activeSize: Size(14, 14),
                  activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
//                      numberOfDot: pageLength,
//                      position: currentIndexPage,
//                      dotColor: Colors.black87,
//                      dotActiveColor: Colors.amber
//
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            height: 50.0,
            width: 300.0,
            child: Button(
              onPress: () {
                SharedPreferences.getInstance().then((pref) {
                  pref.setBool(intro_done, true);
                });
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignIn(),
                    ));
              },
              buttonTitle: 'GET STARTED',
              colour: Color(0xFFFF3D3A3A),
            ),

            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     crossAxisAlignment: CrossAxisAlignment.end,
            //     children: <Widget>[
            //       FlatButton(
            //         child: Text(lastPage ? "" : "SKIP",
            //             style: TextStyle(
            //                 color: Colors.black,
            //                 fontWeight: FontWeight.bold,
            //                 fontSize: 16.0)),
            //         onPressed: () => lastPage
            //             ? null
            //             : Navigator.push(
            //                 context,
            //                 MaterialPageRoute(
            //                   builder: (context) => SignIn(),
            //                 ),
            //               ),
            //
            //         // SignIn(context),
            //       ),
            //       FlatButton(
            //         child: Text(lastPage ? "GOT IT" : "NEXT",
            //             style: TextStyle(
            //                 color: Colors.black,
            //                 fontWeight: FontWeight.bold,
            //                 fontSize: 16.0)),
            //         onPressed: () => lastPage
            //             ? Navigator.push(
            //                 context,
            //                 MaterialPageRoute(
            //                   builder: (context) => SignIn(),
            //                 ),
            //               )
            //             : controller.nextPage(
            //                 duration: Duration(milliseconds: 300),
            //                 curve: Curves.easeIn),
            //       ),
            //     ],
            //   ),
          ),
          Container(
            height: 190.0,
          )
        ],
      ),
    );
  }
}
