import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Button({this.icon, @required this.onPress, this.buttonTitle, this.colour});

  final IconData icon;
  final Function onPress;
  final String buttonTitle;
  final Color colour;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: FlatButton(
        onPressed: onPress,
        child: Text(
          buttonTitle,
          style: TextStyle(
              // fontWeight: FontWeight.bold,
              fontSize: 20.0, color: Colors.white),
        ),
        minWidth: MediaQuery.of(context).size.width,
        height: 55.0,
        color: colour,
        splashColor: Colors.black,
        shape: StadiumBorder(),
      ),
    );
  }
}
