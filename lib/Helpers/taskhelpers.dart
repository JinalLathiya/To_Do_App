import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/Models/taskmodel.dart';

class DBHelper {
  static Database? _db;
  static const int _version = 1;
  static const String _tablename = "Tasks";

  static Future<void> initDB() async {
    if (_db != null) {
      return;
    }
    try {
      String _path = await getDatabasesPath() + 'tasks.db';
      _db =
          await openDatabase(_path, version: _version, onCreate: (db, version) {
        print("Creating a new table");
        return db.execute('''
              CREATE TABLE $_tablename(
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                title TEXT,note TEXT,date TEXT,
                Stime TEXT,Etime TEXT,
                color INTEGER,repeat TEXT,remind TEXT,
                isCompleted INTEGER )
           ''');
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  static Future<int> insert(Task? task) async {
    print("Insert Function Called");
    return await _db!.insert(_tablename, task!.toJson()) ?? 1;
  }

  static Future<List<Map<String, dynamic>>> query() async {
    print("Query Function Called");
    return await _db!.query(_tablename);
  }

  static Delete(Task task) async{
  return await _db!.delete(
      _tablename,
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  static update(int id)async {
    return await _db!.rawUpdate('''
       UPDATE Tasks 
       SET isCompleted = ?
       WHERE id = ?
    ''',[1,id]);
  }
}
