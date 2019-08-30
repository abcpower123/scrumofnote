import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'TaskLib.dart';
import 'InsertDeleteEx.dart';
import 'TaskLib.dart';
import 'main.dart';

class TutorialHome extends StatelessWidget {
   Task todo;

  // In the constructor, require a Todo.
  TutorialHome({Key key, @required this.todo}) : super(key: key);
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            tooltip: "Navi",
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Center(
          child: Text("New Note"),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.cancel), tooltip: "cancel", onPressed: null)
        ],
      ),
      body: Center(
        child: Note(todo: todo),
      ),
      persistentFooterButtons: <Widget>[
        new RaisedButton(
          onPressed: (){
              if(todo.id==-1){
                insertTask( context);
              }
              else{
                updateTask(context);
              }
          },
          padding: const EdgeInsets.all(8.0),
          textColor: Colors.white,
          color: Colors.blue,
          child: new Text(
            "Finish",
          ),
        ),
        new RaisedButton(
          onPressed: (){
            if(todo.id!=-1){
              deleteTask(context);
            }
          },
          textColor: Colors.white,
          color: todo.id==-1?Colors.black26: Colors.red,
          padding: const EdgeInsets.all(8.0),
          child: new Text(
            "Delete",
          ),
        ),
      ],
    );
  }

  Future insertTask(BuildContext context) async {
    DatabaseHelper helper = DatabaseHelper.instance;
    int id = await helper.insert(todo);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoadingScreen()),
    );
  }
   Future updateTask(BuildContext context) async {
     DatabaseHelper helper = DatabaseHelper.instance;
     int id = await helper.updateTask(todo);
     Navigator.push(
       context,
       MaterialPageRoute(builder: (context) => LoadingScreen()),
     );
   }
   Future deleteTask(BuildContext context) async {
     DatabaseHelper helper = DatabaseHelper.instance;
     int id = await helper.deleteTask(todo.id);
     Navigator.push(
       context,
       MaterialPageRoute(builder: (context) => LoadingScreen()),
     );
   }
}

class Note extends StatefulWidget {
  final Task todo;
  Note({Key key, @required this.todo}) : super(key: key);
  @override
  _State createState() => new _State(todo: todo);
}

class _State extends State<Note> {
  final Task todo;
  DateTime selectedDate = DateTime.now();
  _State({Key key, @required this.todo}){
    try {
      selectedDate = DateTime.parse(todo.dateD); //sua csdl r doo
    }
    catch (Exception){
      selectedDate=DateTime.now();
    }
    todo.dateD="${new DateFormat('yyyy-MM-dd hh:mm:ss').format(selectedDate)}";
  }
  final _formKey = GlobalKey<FormState>();
  bool monVal = false;
  Task ts = new Task();

  //Select date

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        todo.dateD="${new DateFormat('yyyy-MM-dd hh:mm:ss').format(selectedDate)}";

      });
  }
//  final _title = TextEditingController();
//  final _content = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print(todo.title);
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextField(
              controller: TextEditingController(text: todo.title),
              onChanged: (value){
                todo.title = value;
//                print(todo.title);
              },
              maxLines: 1,
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
//              initialValue: todo.title,
              decoration: InputDecoration(
                hintText: "Nhap tieu de!",
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
//              controller: _content,
              maxLines: 5,
             // initialValue: todo.content,
    controller: TextEditingController(text: todo.content),
    onChanged: (value){
    todo.content = value;
    //print(todo.content);
    },
              decoration: InputDecoration(
                hintText: "Nhap ke hoach!",
                border: OutlineInputBorder(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text("Da hoan thanh: ", style: TextStyle(fontWeight: FontWeight.bold),),
                Checkbox(

                  value: todo.status==0||todo.status==null?false:true,
                  onChanged: (bool value) {
                    setState(() {
                      monVal = value;
                    });
                    todo.status=value?1:0;
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                RaisedButton(
                 onPressed: () {
                   _selectDate(context);

                 },

                  child: Text('Date',  style: TextStyle(fontWeight: FontWeight.bold),),
                ),
//                Text("${selectedDate.toString()}"),
                Text("${new DateFormat('dd-MM-yyyy').format(selectedDate)}",),
              ],
            ),
          ],
        ));
  }
}
