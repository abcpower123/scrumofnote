import 'TaskLib.dart';
import 'package:flutter/material.dart';
class MyTestInsertDeleteW extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saving data'),
      ),
      body: Row(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              child: Text('Read'),
              onPressed: () {
                _read();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              child: Text('Save'),
              onPressed: () {
                _save();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              child: Text('Delete'),
              onPressed: () {
                _delete();
              },
            ),
          ),
        ],
      ),
    );
  }

  // Replace these two methods in the examples that follow

  _read() async {


    DatabaseHelper helper = DatabaseHelper.instance;
    int rowId = 1;
//
//    Task task = await helper.queryWord(3);
//    if (task == null) {
//      print('read row $rowId: empty');
//    } else {
//      print('read row $rowId: tieu de ${task.title} noi dung ${task.content}');
//    }
    List<Task> ds= await helper.queryAllTasks();
    for(int i=0;i<ds.length;i++)
      print("Id:  ${ds[i].id}, Title ${ds[i].title},Content ${ds[i].content}");
  }

  _save() async {
    Task t=new Task(status: 0,title: "cong viec1",content: "khong lam gi ca",dateD: "2019/8/9");
    print(t.title+" "+t.content);

    DatabaseHelper helper = DatabaseHelper.instance;
    int id = await helper.insert(t);
    print('inserted row: $id');
  }
  _delete() async {
    DatabaseHelper helper = DatabaseHelper.instance;
    Task t= await helper.queryTask(4);
    t.content="da lam dc r";
    helper.updateTask(t);
    print('updated');
  }
}