import 'package:deep/writingPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:flutter_page_transition/page_transition_type.dart';
import 'package:deep/pageTransitions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(55, 55, 56, 1),
        accentColor: Color.fromRGBO(235, 237, 235, 1),
        fontFamily: "MavenPro",
        textTheme: TextTheme(
          bodyText1: TextStyle(fontSize: 50, fontFamily: "MavenPro")
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).primaryColor,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Theme.of(context).primaryColor));

    return SafeArea(
        child: Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: screenHeight * 0.35),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RawMaterialButton(
                  onPressed: () {
                    HapticFeedback.selectionClick();
                    Navigator.of(context).push(FadeRoute(page: writingPage()));
                  },
                  elevation: 50.0,
                  fillColor: Theme.of(context).accentColor,
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
                            spreadRadius: 3.3,
                            blurRadius: 5,
                            offset: Offset(0,2)
                          ),
                        ]),),
                        Icon(
                      Icons.border_color,
                      size: screenWidth * 0.070,
                      color: Theme.of(context).primaryColor,
                    ),
                  ],),
                  shape: CircleBorder(),
                ),
                SizedBox(width: 45,)
                ,
                RawMaterialButton(
                  onPressed: () {
                    HapticFeedback.selectionClick();
                    Navigator.of(context).push(FadeRoute(page: writingPage()));
                  },
                  elevation: 50.0,
                  fillColor: Theme.of(context).accentColor,
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
                            spreadRadius: 3.3,
                            blurRadius: 5,
                            offset: Offset(0,2)
                          ),
                        ]),),
                        Icon(
                      Icons.library_books,
                      size: screenWidth * 0.070,
                      color: Theme.of(context).primaryColor,
                    ),
                  ],),
                  shape: CircleBorder(),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.35),
            ),
            Text(
              'deep',
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: (screenHeight+screenWidth) * 0.02
                ),
            ),
          ],
        ),
      ),
    ));
  }
}
