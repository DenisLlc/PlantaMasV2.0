import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:plantamas/models/base_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database? _db;

  Future<Database> get db async {
    _db ??= await init();
    return _db!;
  }

  DatabaseHelper.internal();

  Future<Database> init() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "main2.db");
    print(path);
    return openDatabase(path, version: 1, onCreate: onCreate);
  }

  void onCreate(Database db, int version) async => await db.execute(
      'CREATE TABLE plants (id INTEGER PRIMARY KEY NOT NULL, name STRING, age STRING, genre STRING, irrigation STRING, sun STRING, size STRING, temperature STRING)');

  Future<List<Map<String, dynamic>>> query(String table) async =>
      (await db).query(table);

  Future<int> insert(String table, BaseModel model) async =>
      (await db).insert(table, model.toMap());

  Future<int> update(String table, BaseModel model) async => (await db)
      .update(table, model.toMap(), where: 'id = ?', whereArgs: [model.id]);

  Future<int> delete(String table, BaseModel model) async =>
      (await db).delete(table, where: 'id = ?', whereArgs: [model.id]);
}
