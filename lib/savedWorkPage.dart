import 'package:deep/main.dart';
import 'package:deep/widgets/appBarText.dart';
import 'package:deep/widgets/backButtonOnSaved.dart';
import 'package:deep/writingPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:deep/pageTransitions.dart';

class MyBehavior extends ScrollBehavior {
  BuildContext context;
  MyBehavior(
      this.context
      );

  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class savedNotes extends StatefulWidget {
  savedNotes({Key key}) : super(key: key);

  @override
  _savedNotesState createState() => _savedNotesState();
}

class _savedNotesState extends State<savedNotes> {
  String data = "empty";
  static DateTime now = DateTime.now();
  static String formattedDate = DateFormat('hh:mm a EEE d MMM yy').format(now);
  static List<List> allNotes = [];
  static Map allKeys = {};
  static List<String> notePreviews = [];

  @override
  void initState() {
    super.initState();
    setData();
  }

  notesItem(Map notes) {
    if (notes.keys.length < 1) {
      return [];
    }
    List<Widget> widgets = [];
    notes.forEach((k, v) {
      widgets.add(Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
          child: InkWell(
            onTap: () {
              print("pressed");
              Navigator.of(context).push(FadeRoute(page: writingPage(note: v)));
            },
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      v.length > 20 ? v.substring(0, 20) + '...' : v,
                      style: TextStyle(
                          color: Theme.of(context).accentColor, fontSize: 22),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      k,
                      style: TextStyle(
                          color: Theme.of(context).accentColor, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ));
    });
    return widgets;
  }

  static Future<String> getSavedNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Set name = prefs.getKeys();
    name.forEach((element) {
      String value = prefs.getString(element);
      if (allKeys.keys.contains(element) == false) {
        // allKeys.add([element, value]);
        allKeys[element] = value;
        // allNotes.add(prefs.getString(element));
      }
    });
  }

  setData() {
    getSavedNotes().then((value) {
      setState(() {
        if (value != null) {
          data = value;
        }
      });
    });
  }

  emptyOrnot() {
    List listView_list = notesItem(allKeys);
    if (listView_list.length > 0) {
      return ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 10),
        children: listView_list,
      );
    } else {
      return Center(
        child: Text(
          "empty",
          style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.6), fontSize: 20),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.02),
              child: Row(
                children: <Widget>[
                  backButtonOnSaved(context),
                  appBarText(context, "Notes")
                ],
              ),
            ),
            Expanded(
              child: ScrollConfiguration(
                  behavior: MyBehavior(context), child: emptyOrnot()),
            )
          ]),
    ));
  }
}
