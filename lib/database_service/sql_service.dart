import 'package:remind_me/models/task_model.dart';
import 'package:sqflite/sqflite.dart';

class SqlServices{
  static Database? _database;
  static int _version = 1;
  static String _tableName = 'tasks';
  static Future<void> initDatabase()async{
    if(_database != null){
      return ;
    }
    try{
        String path =  await getDatabasesPath()+'tasks.db';
        _database = await openDatabase(path,
        version: _version,
        onCreate: (db , version){
          print('db created');
          return db.execute(
              "CREATE TABLE $_tableName ("
                  "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                  "title STRING, content TEXT, date STRING, "
                  "startTime STRING, "
                  "remind INTEGER, repeat STRING, "
                  "color INTEGER, "
                  "isCompleted INTEGER)");
        }
        );
    }catch(e){

    }
  }
 static Future<int> insert(Task? task)async{
      print('inserting');
    return await _database?.insert(_tableName,
        task!.toJson())??1;
 }
 static Future<List<Map<String, dynamic>>> query()async{
    print('query called');
    var list = await _database!.query(_tableName);
    print(list);
    return list;
 }
  static Future deleteTask(Task task)async{
    print('deleting');
    await _database?.delete(_tableName, where: 'id=?', whereArgs: [task.id]);
  }
 static Future<Task> getTask(int id)async{
    final data = await _database!.query(
     _tableName,
     where: 'id=?',
     whereArgs: [id],
   );
    print(data);
   return Task.fromJson(data.first);
  }
 static Future updateTaskStatus(int id)async{
    return await _database!.rawUpdate('''
   UPDATE tasks
   SET isCompleted = ?
   WHERE id =? 
    ''', [1,id]);
 }
 static Future<int> updateTask(Task? task)async{
    return await _database!.update(_tableName, task!.toJson(),where:'id=?', whereArgs:[task.id]);
  }
}