import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../pageTransitions.dart';
import '../writingPage.dart';

Widget mainButton (context, IconData icons, Widget next) {
  // double screenHeight = MediaQuery.of(context).size.height;
  double screenWidth = MediaQuery.of(context).size.width;

  return RawMaterialButton(
    onPressed: () {
      HapticFeedback.selectionClick();
      Navigator.of(context).push(FadeRoute(page: next));
    },
    elevation: 2.0,
    fillColor: Theme.of(context).accentColor,
    focusColor: Colors.transparent,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    child: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          height: 60,
          width: 60,
          alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black,
                      spreadRadius: 3,
                      blurRadius: 2,)
                  ,
                ]),
        ),
        Icon(
          icons,
          size: screenWidth * 0.070,
          color: Theme.of(context).primaryColor,
        ),
      ],
    ),
    shape: CircleBorder(),
  );
}