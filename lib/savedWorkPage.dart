import 'package:deep/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:deep/pageTransitions.dart';

class MyBehavior extends ScrollBehavior {
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
            onTap: () {},
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      v.length > 20 ? v.substring(0, 20) + ' ...' : v,
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
          "No saved notes",
          style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.6), fontSize: 20),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: <Widget>[
                  RawMaterialButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: EdgeInsets.only(top: 5),
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onPressed: () {
                      HapticFeedback.selectionClick();
                      Navigator.of(context).pop(FadeRoute(page: MyApp()));
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 22,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  Text(
                    "Notes",
                    style: TextStyle(
                        color: Theme.of(context).accentColor, fontSize: 28),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ScrollConfiguration(
                  behavior: MyBehavior(), child: emptyOrnot()),
            )
          ]),
    ));
  }
}
