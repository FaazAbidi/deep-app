import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:flutter/src/rendering/box.dart';

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
    List<Widget> widgets = [];
    notes.forEach((k, v) {
      widgets.add(Container(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
          child: InkWell(
            highlightColor: Colors.transparent,
            onTap: () {
    
  },
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      v.length > 10 ? v.substring(0, 10) + ' ...' : v,
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
        print(allKeys);
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              RawMaterialButton(
                      onPressed: () {
                        HapticFeedback.selectionClick();
                      },
                      elevation: 50.0,
                      child: Icon(
                            Icons.arrow_back_ios,
                            size: 30,
                            color: Theme.of(context).accentColor,
                          ),
                      
                    ),
                    Text(
                      "Notes",
                      style: TextStyle(
                          color: Theme.of(context).accentColor, fontSize: 30),
                    ),
            ],
          ),
          
          Expanded(
            child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 10),
                children: notesItem(allKeys),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
