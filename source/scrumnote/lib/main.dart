import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'note.dart';

void main() => runApp(MaterialApp(
  title: "Flutter tutorial",
  home: home(),
));

class home extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.menu), tooltip: "Navi", onPressed: null),
        title: Center(
          child: Text("Note"),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search), tooltip: "Search", onPressed: null)
        ],
      ),
      body: Center(
        child: Text("Home"),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Ađd",
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TutorialHome()),
          );
        },
      ),
    );
  }
}
