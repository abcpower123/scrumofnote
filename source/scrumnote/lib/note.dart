import 'package:flutter/material.dart';
class TutorialHome extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios), tooltip: "Navi",
            onPressed: (){
              Navigator.pop(context);
            }),
        title: Center(
          child: Text("New Note"),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.cancel),
              tooltip: "cancel",
              onPressed: null)
        ],
      ),
      body: Center(
        child: Note(),
      ),
      persistentFooterButtons: <Widget>[
        FlatButton.icon(
          color: Colors.lightGreenAccent,
          icon: Icon(Icons.add_to_photos), //`Icon` to display
          label: Text('Add'), //`Text` to display
          onPressed: () {
            //Code to execute when Floating Action Button is clicked
            //...
          },
        ),
      ],
//      floatingActionButton: FloatingActionButton(
//        tooltip: "Ađd",
//        child: Icon(Icons.add),
//        onPressed: null,
//      ),
    );
  }
}

class Note extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(8.0),
        // hack textfield height
        padding: EdgeInsets.only(bottom: 40.0),
        child: TextField(
          maxLines: 99,
          decoration: InputDecoration(
            hintText: "Input content note...",
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}