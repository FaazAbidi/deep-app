import 'package:deep/savedWorkPage.dart';
import 'package:deep/widgets/mainDeepText.dart';
import 'package:deep/writingPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:deep/widgets/main_buttons.dart';


class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    // double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).primaryColor,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Theme.of(context).primaryColor));

    return SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: Stack(
            children: [
              Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    mainButton(context, Icons.border_color, writingPage(note: "",)),
                    SizedBox(width: screenWidth * 0.03),
                    mainButton(context, Icons.library_books, savedNotes())
                  ],
                ),
              ],
            ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [mainDeepText(context),],)
          ]
          ),
        ));
  }
}