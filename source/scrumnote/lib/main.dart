import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'note.dart';
import 'TaskLib.dart';

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
        child: listnote(),
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

class listnote extends StatefulWidget{
  final title = 'Grid List';
  @override
  State<StatefulWidget> createState() {

    return ListNoteState();
  }
}

class ListNoteState extends State<listnote> {
  //varible
  List<Task> ds=new List();
  ListTile _tile(String title, String subtitle, IconData icon) => ListTile(
    title: Text(title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20,
        )),
    subtitle: Text(subtitle),
    leading: Icon(
      icon,
      color: Colors.blue[500],
    ),
    trailing: Icon(Icons.keyboard_arrow_right),
  );

  //method
  _readAllTasks() async {


    DatabaseHelper helper = DatabaseHelper.instance;

    ds= await helper.queryAllTasks();


  }

  @override
  Widget build(BuildContext context) {
    _readAllTasks();
    return ListView.builder(
      itemCount: ds.length,
      itemBuilder: (context, index) {
        _readAllTasks();
        return ListTile(
          title: _tile(ds[index].title, ds[index].content, Icons.theaters),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TutorialHome(todo: "Le van tri"),
              ),
            );
          },
        );
      },
    );
  }

}


