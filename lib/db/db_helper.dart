import 'package:flutter/cupertino.dart';
import 'package:getxtodo/models/task.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? db;
  static final int version = 1;
  static final String dbTableName = 'tasks';

  static Future<void> initDb() async {
    if (db != null) {
      debugPrint("not null");
    } else {
      try {
        String _path = await getDatabasesPath() + 'task.db';
        db = await openDatabase(_path, version: 1,
            onCreate: (Database db, int version) async {
          await db.execute('CREATE TABLE $dbTableName ('
              'id INTEGER PRIMARY KEY AUTOINCREMENT, '
              'title STRING, note TEXT, date STRING, '
              'startTime STRING, endTime STRING, '
              'remind INTEGER, repeat STRING, '
              'color INTEGER, '
              'isCompleted INTEGER)');
        });
      } catch (e) {
        print(e);
      }
    }
  }

  static Future<int> insert(Task? task) async {
    print('insert');
    return await db!.insert(dbTableName, task!.tojson());
  }

  static Future<int> delete(Task? task) async {
    print('delete');
    return await db!.delete(dbTableName, where: 'id=?', whereArgs: [task!.id]);
  }

  static Future<List<Map<String, Object?>>> query() async {
    print('query');
    return await db!.query(dbTableName);
  }

  static Future<int> update(int id) async {
    print('update');
    return await db!.rawUpdate(
      '''
    UPDATE $dbTableName
    SET iscompleted=?
    WHERE id=?
    ''',
      [1, id],
    );
  }
}
