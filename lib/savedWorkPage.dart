import 'package:deep/core/note.dart';
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
  MyBehavior(this.context);

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

  @override
  void initState() {
    super.initState();
    print("working on back");
  }

  setData() async {
    Map<String, String> allKeyNValue;
    allKeyNValue = await Note.getAll();
    return allKeyNValue;
  }

  Widget deleteSnackBar(String dateTimeKey) {
    return SnackBar(
      backgroundColor: Theme.of(context).accentColor,
      content: Text(
        "Delete this note?",
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
      action: SnackBarAction(
        label: 'Yes',
        textColor: Theme.of(context).primaryColor,
        onPressed: () async {
          SharedPreferences deleteInstance = await SharedPreferences.getInstance();
          deleteInstance.remove(dateTimeKey);
          setState(() {
          });
        },
      ),
    );
  }

  Widget listContainer(String key, String dateTime, String noteMessage) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
        child: InkWell(
          onTap: () {
            print("pressed");
            Navigator.of(context).pushReplacement(FadeRoute(page: writingPage(note: noteMessage, isEditing: true, noteKey: key)));
          },
          onLongPress: () {
            ScaffoldMessenger.of(context).showSnackBar(deleteSnackBar(key));
          },
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    noteMessage.length > 13 ? noteMessage.substring(0, 13) + '...' : noteMessage,
                    style: TextStyle(
                        color: Theme.of(context).accentColor, fontSize: 22),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    dateTime,
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

  emptyOrnot(context) {
    return FutureBuilder(
      builder: (context, noteMap) {
        if (noteMap.hasData) {
          List <String> keys = noteMap.data.keys.toList().where((k) => !k.contains("datetime")).toList();
          if (keys.length <= 0) {
            return Center(
                child: Text("empty",
                    style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.6),
                        fontSize: 20)));
          } else {
            return ListView.builder(
              itemCount: keys.length,
              itemBuilder: (context, index) {
                return listContainer(
                  keys[index],
                  noteMap.data[keys[index]+"datetime"],
                  noteMap.data[keys[index]],
                );
              },
            );
          }
        } else {
          return CupertinoActivityIndicator(
            animating: true,
            radius: 20,
          );
        }
      },
      future: setData(),
    );
  }
  //TODO fix navigation issue

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
                  behavior: MyBehavior(context), child: emptyOrnot(context)),
            )
          ]),
    ));
  }
}
