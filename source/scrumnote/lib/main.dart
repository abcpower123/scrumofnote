import 'package:flutter/material.dart';
import 'package:scrumnote/InsertDeleteEx.dart';
import 'note.dart';
import 'TaskLib.dart';
import 'InsertDeleteEx.dart';
import 'grid.dart';

void main() => runApp(MaterialApp(
  title: "Flutter tutorial",
  home: MyTestInsertDeleteW(),
));

class ShowAllTaskWidget extends StatelessWidget {
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
              icon: Icon(Icons.grid_on), tooltip: "Search",
              onPressed: (){
                Navigator.push(
                context,
               MaterialPageRoute(
                builder: (context) =>homeGrid(),
               ),
            );
          }),
          IconButton(
              icon: Icon(Icons.do_not_disturb_alt), tooltip: "Search", onPressed: null)
        ],
      ),
      body: Center(
        child: ListNote(),
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

class ListNote extends StatefulWidget{
  final title = 'Grid List';
  @override
  State<StatefulWidget> createState() {

    return ListNoteState();
  }
}
class ListNoteState extends State<ListNote> {
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
    if(ds==null) ds=new List();
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
                builder: (context) => TutorialHome(todo: ds[index]),
              ),
            );
          },
        );
      },
    );
  }

}



