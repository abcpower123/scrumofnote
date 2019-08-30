import 'package:flutter/material.dart';
import 'note.dart';
import 'TaskLib.dart';
import 'main.dart';
class homeGrid extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.list), tooltip: "Navi", onPressed: null),
        title: Center(
          child: Text("Note"),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.list), tooltip: "Search",
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => home(),
                  ),
                );
              }),
          IconButton(
              icon: Icon(Icons.do_not_disturb_alt), tooltip: "Search", onPressed: null)
        ],
      ),
      body: Center(
        child: gridnote(),
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

class gridnote extends StatefulWidget{
  final title = 'Grid List';
  @override
  State<StatefulWidget> createState() {

    return GridNoteState();
  }
}

class GridNoteState extends State<gridnote> {
  //varible
  List<Task> ds = new List();

  ListTile _tile(String title, String subtitle, IconData icon) =>
      ListTile(
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

    ds = await helper.queryAllTasks();
  }

  @override
  Widget build(BuildContext context) {
    _readAllTasks();
    return new GridView.count(
      crossAxisCount: 3,
      children: new List<Widget>.generate(ds.length, (index) {
        return new GridTile(

          child:  new InkResponse(
            child: new Card(
              color: Colors.black12,
              child: new Center(
                child: new Text('${ds[index].title}',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Colors.white70
                    )),
              ),
          ),
            onTap: (){
              Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TutorialHome(todo: ds[index]),
              ),
            );
            },
          ),
        );
      }),
    );
  }

}