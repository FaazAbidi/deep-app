import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../pageTransitions.dart';

Widget mainButton (context, IconData icons, Widget next) {
  double screenHeight = MediaQuery.of(context).size.height;
  double screenWidth = MediaQuery.of(context).size.width;

  return InkWell(
    onTap: () {
      HapticFeedback.selectionClick();
      Navigator.of(context).push(FadeRoute(page: next));
    },
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,

    child: Neumorphic(
        style: NeumorphicStyle(
            shape: NeumorphicShape.flat,
            boxShape: NeumorphicBoxShape.circle(),
            depth: 4,
            lightSource: LightSource.topLeft,
            color: Theme.of(context).primaryColor,
            intensity: 0.8,
            shadowDarkColor: Colors.black,
            shadowLightColor: Theme.of(context).primaryColor
        ),
        child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            height: (screenHeight+screenWidth) * 0.08,
            width: (screenWidth+screenWidth) * 0.08,
            alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
              )
          ),
          Icon(
            icons,
            size: screenWidth * 0.070,
            color: Theme.of(context).accentColor,
          ),
        ],
      ),
    ),
  );
}