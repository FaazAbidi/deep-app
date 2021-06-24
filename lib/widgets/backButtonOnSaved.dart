import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../main.dart';
import '../pageTransitions.dart';

Widget backButtonOnSaved (context, ) {
  double screenHeight = MediaQuery.of(context).size.height;
  double screenWidth = MediaQuery.of(context).size.width;

  return InkWell(
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    onTap: () {
      HapticFeedback.selectionClick();
      Navigator.of(context).pop(FadeRoute(page: MyApp()));
    },
    child: Padding(
      padding: EdgeInsets.only(left: 20, right: 12),
      child: Icon(
        Icons.arrow_back_ios,
        size: screenWidth * 0.06,
        color: Theme.of(context).accentColor,
      ),
    ),
  );
}