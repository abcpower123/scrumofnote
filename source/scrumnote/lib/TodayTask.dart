import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'note.dart';
import 'TaskLib.dart';
import 'main.dart';
class ShowTodayTaskWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.list), tooltip: "Navi", onPressed: (){

        }),
        title: Center(
          child: Text("Note"),
        ),
        actions: <Widget>[

          IconButton(
              icon: Icon(Icons.do_not_disturb_alt), tooltip: "Search", onPressed: null)
        ],
      ),
      body: Center(
        child: ListNoteToday(),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Ađd",
        child: Icon(Icons.add),
        onPressed: (){
          Task t=new Task();
          t.id=-1;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TutorialHome(todo: t)),
          );
        },
      ),
    );
  }
}
class ListNoteToday extends StatefulWidget{
  final title = 'Grid List';
  @override
  State<StatefulWidget> createState() {

    return ListNoteTodayState();
  }
}
class ListNoteTodayState extends State<ListNoteToday> {
  //varible
  static List<Task> ds=new List();
  ListTile _tile(String title, String subtitle, int status, IconData icon) => ListTile(
    title: Text(title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20,
        )),
    subtitle: Text(subtitle),
    leading: Icon(
      icon,
      color: status==0? Colors.red[500]:Colors.blue[500] ,
    ),
    trailing: Icon(Icons.keyboard_arrow_right),
  );

  //method

  static readAllTasks() async {
    print("Chayj ham read");
    DatabaseHelper helper = DatabaseHelper.instance;
    ds= await helper.queryTodayTasks("${new DateFormat('yyyy-MM-dd').format(DateTime.now())}");
    if(ds==null) ds=new List();
  }

  @override
  Widget build(BuildContext context) {
    if(ds==null) ds=new List();


    return ListView.builder(
      itemCount: ds.length,
      itemBuilder: (context, index) {

        return ListTile(
          title: _tile(ds[index].title, ds[index].content, ds[index].status, Icons.theaters),
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
  @override
  initState()  {
    loading();
    super.initState();
  }
  loading() async {
    await readAllTasks();
    print("load ok");
  }
}

class LoadingScreenToday extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {

    return LoaddingStateToday();
  }

}

class LoaddingStateToday extends State<LoadingScreenToday> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.list), tooltip: "Navi", onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>LoadingScreen(),
            ),
          );
        }),
        title: Center(
          child: Text("Note"),
        ),
        actions: <Widget>[
//          IconButton(
//              icon: Icon(Icons.grid_on), tooltip: "Search",
//              ),
          IconButton(
              icon: Icon(Icons.do_not_disturb_alt), tooltip: "Search", onPressed: null)
        ],
      ),
      body: Center(
        child: Text("Loading"),
      ),
    );
  }
  @override
  void initState() {
    onStart(context);
    super.initState();
  }

  Future onStart(BuildContext context) async {
    await ListNoteTodayState.readAllTasks();
    Navigator.push(context, MaterialPageRoute(builder: (context) => ShowTodayTaskWidget()),);
  }
}