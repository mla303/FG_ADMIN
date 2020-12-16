import 'package:flutter/material.dart';
import 'package:fg_admin/button.dart';
import 'signin.dart';

class myWalkthrough extends StatefulWidget {
  String title;
  String content;
  String image;

  myWalkthrough({
    this.title,
    this.content,
    this.image,
  });

  @override
  WalkthroughState createState() {
    return WalkthroughState();
  }
}

class WalkthroughState extends State<myWalkthrough>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;

  @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   animationController =
  //       AnimationController(vsync: this, duration: Duration(milliseconds: 800));
  //   animation = Tween(begin: -250.0, end: 0.0).animate(
  //       CurvedAnimation(parent: animationController, curve: Curves.easeInOut));
  //
  //   animation.addListener(() => setState(() {}));
  //
  //   animationController.forward();
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20.0),
        child: Material(
          color: Colors.white,
          animationDuration: Duration(milliseconds: 800),
          elevation: 0.0,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Transform(
                transform: Matrix4.translationValues(0, 2.0, 6.0),
                child: Container(
                  height: 190.0,
                  width: MediaQuery.of(context).size.width,
                  child: Image(
                    image: AssetImage(widget.image),
                  ),
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              Transform(
                transform: Matrix4.translationValues(animation.value, 0.0, 0.0),
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    //color: basicColor
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Transform(
                transform: Matrix4.translationValues(animation.value, 0.0, 0.0),
                child: Text(widget.content,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 15.0,
                        color: Colors.grey)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
