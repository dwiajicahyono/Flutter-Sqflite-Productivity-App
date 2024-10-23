import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:productivity_app/models/db_activity.dart';

class DbActivityHelper {
  static final DbActivityHelper _instance = DbActivityHelper._internal();
  static Database? _database;

  factory DbActivityHelper() {
    return _instance;
  }

  DbActivityHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // inisialisasi database
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'activity_database.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  //  create database
  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE IF NOT EXISTS activities (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT)',
    );
  }

  // create new data from tabel
  Future<void> insertDataActivity(Activity activity) async {
    final db = await database;
    //  await db.rawInsert(
    //   'INSERT INTO todos (title, description) VALUES (?, ?)',
    //   [activity.title, activity.description],
    // );
    await db.insert('activities', activity.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // read semua data dari database
  Future<List<Activity>> getAllDataActivity() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('activities');

    return List.generate(maps.length, (i) {
      return Activity(
        id: maps[i]['id'],
        title: maps[i]['title'],
        description: maps[i]['description'],
      );
    });
  }

  // update data activity
  Future<void> updateDataActivity(Activity activity) async {
    final db = await database;

    await db.update('activites', activity.toMap(),
        where: 'id = ?', whereArgs: [activity.id]);
  }

  // delete data activity

  Future<void> deleteDataActivity(int id) async {
    final db = await database;
    await db.execute('DELETE FROM activities WHERE id =?', [id]);
    // await db.delete('activites', where: 'id=?', whereArgs: [id]);
  }
}
