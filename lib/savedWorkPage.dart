import 'package:deep/widgets/appBarText.dart';
import 'package:deep/widgets/backButtonOnSaved.dart';
import 'package:deep/writingPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  List listViewList;

  @override
  void initState() {
    super.initState();
    setData();
  }

  Widget deleteSnackBar (String dateTimeKey) {
    return SnackBar(
      backgroundColor: Theme.of(context).accentColor,
      content: Text("Delete this note?", style: TextStyle(color: Theme.of(context).primaryColor),),
      action: SnackBarAction(
        label: 'Yes',
        textColor: Theme.of(context).primaryColor,
        onPressed: () async {
          SharedPreferences deleteInstance = await SharedPreferences.getInstance();
          print(dateTimeKey);
          deleteInstance.remove(dateTimeKey);
        },
      ),
    );
  }

  
  Widget listContainer(String k, String v) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
        child: InkWell(
          onTap: () {
            print("pressed");
            Navigator.of(context).push(FadeRoute(page: writingPage(note: v)));
          },
          onLongPress: () {
            ScaffoldMessenger.of(context).showSnackBar(deleteSnackBar(k));
          },
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    v.length > 13 ? v.substring(0, 13) + '...' : v,
                    style: TextStyle(
                        color: Theme.of(context).accentColor, fontSize: 22),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    k,
                    style: TextStyle(
                        color: Theme.of(context).accentColor, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  notesItem(Map notes) {
    if (notes.keys.length < 1) {
      return [];
    }
    List<Widget> widgets = [];
    notes.forEach((k, v) {
      widgets.add(listContainer(k,v));
    return widgets;
  });
  }

  static Future<String> getSavedNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Set name = prefs.getKeys();
    name.forEach((element) {
      String value = prefs.getString(element);
      if (allKeys.keys.contains(element) == false) {
        // allKeys.add([element, value]);
        allKeys[element] = value;
        print(element);
        print(value);
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

  emptyOrnot(context) {
    listViewList = notesItem(allKeys);
    if (listViewList.length > 0) {
      return ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 10),
        children: listViewList,
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
                  behavior: MyBehavior(context),
                  child: emptyOrnot(context)),
            )
          ]),
    ));
  }
}
