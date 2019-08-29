import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

// database table and column names
final String tableTask = 'tasks';
final String columnId = '_id';
final String columnSattus = 'status';
final String columnTitle = 'title';
final String columnContent = 'content';
final String columnDateD = 'dated';

// data model class
class Task {

  int id;

  int status ;
  String title;
  String content ;
  String dateD ;

  Task({int id, int status, String title,String content,String dateD}){
    this.id=id;
    this.status=status;
    this.title=title;
    this.content=content;
    this.dateD=dateD;
  }


  // convenience constructor to create a Word object
  Task.fromMap(Map<String, dynamic> map) {

    id=map[columnId];
    status=map[columnSattus];
    title=map[columnTitle];
    content=map[columnContent];
    dateD=map[columnDateD];
  }

  // convenience method to create a Map from this Word object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
    columnSattus:status,
    columnTitle:title,
    columnContent:content,
   columnDateD:dateD,


    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }
}

// singleton class to manage the database
class DatabaseHelper {

  // This is the actual database filename that is saved in the docs directory.
  static final _databaseName = "MyDatabase.db";
  // Increment this version when you need to change the schema.
  static final _databaseVersion = 1;

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only allow a single open connection to the database.
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // open the database
  _initDatabase() async {
    // The path_provider plugin gets the right directory for Android or iOS.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    print(path);
    // Open the database. Can also add an onUpdate callback parameter.
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  // SQL string to create the database
  Future _onCreate(Database db, int version) async {
    await db.execute('''
              CREATE TABLE $tableTask (
                $columnId INTEGER PRIMARY KEY,
                $columnSattus INTEGER,
                $columnTitle TEXT NOT NULL,
                $columnContent TEXT NOT NULL,
                $columnDateD TEXT NOT NULL
               
              )
              ''');
  }

  // Database helper methods:
  //-----------CRUD tasks function-----------
  Future<int> insert(Task task) async {
    Database db = await database;
    int id = await db.insert(tableTask, task.toMap());
    return id; // return id task chen
  }
  Future<Task> queryTask(int id) async {
    Database db = await database;
    List<Map> maps = await db.query(tableTask,
        columns: [columnId, columnSattus, columnTitle,columnContent,columnDateD],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Task.fromMap(maps.first); //return 1 task
    }
    return null;
  }
  Future<List<Task>> queryAllTasks() async {
  
    Database db = await database;
    List<Map> maps = await db.query(tableTask,
        columns: [columnId, columnSattus, columnTitle,columnContent,columnDateD]);
    if (maps.length > 0) {
      List<Task> res= new List();
      for (int i=0;i<maps.length;i++)
          res.add(Task.fromMap(maps.elementAt(i)));
      return res; // return list<task> all task
    }

    return null;
  }
  Future<int> deleteTask(int id) async {
    Database db = await database;
    return  await db.delete(tableTask,where: '$columnId=?',whereArgs: [id]);
   //tra ve so dong bi xoa
  }
  Future<int> updateTask(Task task) async {
    Database db = await database;
    return  await db.update(tableTask,task.toMap(),where: '$columnId= ?',whereArgs: [task.id] );
    //tra ve so dong bi xoa
  }
  Future<List<Task>> queryInCompleteTasks() async {

    Database db = await database;
    List<Map> maps = await db.query(tableTask,
        columns: [columnId, columnSattus, columnTitle,columnContent,columnDateD],
        where: '$columnSattus = 0');
    if (maps.length > 0) {
      List<Task> res= new List();
      for (int i=0;i<maps.length;i++)
        res.add(Task.fromMap(maps.elementAt(i)));
      return res; // return list<task> all task
    }

    return null;
  }
  Future<List<Task>> queryTodayTasks(String today) async {

    Database db = await database;
    List<Map> maps = await db.query(tableTask,
        columns: [columnId, columnSattus, columnTitle,columnContent,columnDateD],
        where: '$columnDateD = ?',
        whereArgs: [today]);
    if (maps.length > 0) {
      List<Task> res= new List();
      for (int i=0;i<maps.length;i++)
        res.add(Task.fromMap(maps.elementAt(i)));
      return res; // return list<task> all task
    }

    return null;
  }
}