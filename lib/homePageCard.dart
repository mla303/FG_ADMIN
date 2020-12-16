import 'package:flutter/material.dart';

class HomePageCard extends StatelessWidget {
  const HomePageCard({this.onTap, this.buttonTitle, this.icon});
  final Function onTap;
  final String buttonTitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 180.0,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          color: Color(0xFFFFEFEEEE),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                color: Colors.black,
                size: 60.0,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                buttonTitle,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
