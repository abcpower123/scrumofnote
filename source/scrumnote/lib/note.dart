import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'TaskLib.dart';
import 'InsertDeleteEx.dart';
import 'TaskLib.dart';

class TutorialHome extends StatelessWidget {
  final Task todo;

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

          },
          textColor: Colors.white,
          color: Colors.red,
          padding: const EdgeInsets.all(8.0),
          child: new Text(
            "Delete",
          ),
        ),
      ],
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
  _State({Key key, @required this.todo});
  final _formKey = GlobalKey<FormState>();
  bool monVal = false;
  Task ts = new Task();

  //Select date
  DateTime selectedDate = new DateTime.now();
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2019),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
  final _title = TextEditingController();
  final _content = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _title,
              maxLines: 1,
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.lightGreenAccent),
              initialValue: todo.title,
              decoration: InputDecoration(
                hintText: "Nhap tieu de!",
                border: OutlineInputBorder(),
              ),
            ),
            TextFormField(
              controller: _content,
              maxLines: 5,
              initialValue: todo.content,
              decoration: InputDecoration(
                hintText: "Nhap ke hoach!",
                border: OutlineInputBorder(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text("Thong Bao: ", style: TextStyle(fontWeight: FontWeight.bold),),
                Checkbox(
                  value: monVal,
                  onChanged: (bool value) {
                    setState(() {
                      monVal = value;
                    });
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
                  onPressed: () => _selectDate(context),
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
