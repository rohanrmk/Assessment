import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'app_data.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE form_data(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, email TEXT, mobileNo TEXT, pan TEXT, address1 TEXT, address2 TEXT, postcode TEXT, state TEXT, city TEXT)',
        );
      },
    );
  }

  Future<int> insertData(Map<String, dynamic> row) async {
    final db = await database;
    return await db.insert('form_data', row);
  }

  Future<List<Map<String, dynamic>>> queryAllData() async {
    final db = await database;
    return await db.query('form_data');
  }

  Future<int> updateData(int id, Map<String, dynamic> row) async {
    final db = await database;
    return await db.update(
      'form_data',
      row,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteData(int id) async {
    final db = await database;
    return await db.delete(
      'form_data',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
