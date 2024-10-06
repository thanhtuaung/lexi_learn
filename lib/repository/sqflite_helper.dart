import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../constant/constant_strings.dart';

class SqfliteHelper {
  static SqfliteHelper? _instance;
  static const String _dbName = "lexicon.db";
  static Database? _db;
  final int _version = 1;

  SqfliteHelper._();

  factory SqfliteHelper() {
    return _instance ??= SqfliteHelper._();
  }

  Future<Database> initializeDatabase() async {
    String dbPath = await _getDatabasePath();

    _db = await openDatabase(dbPath,
        version: _version, onCreate: _dbCreate, onUpgrade: _onUpgrade);
    return _db!;
  }

  _dbCreate(Database db, int version) async {
    await _createContactTable(db);
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    /*if (oldVersion < 4) {
      db.execute(
          'CREATE TABLE Product (id INTEGER PRIMARY KEY, name TEXT, price DOUBLE)');
    }*/
  }

  Future<Database> get _database async => _db ?? await initializeDatabase();

  Future<bool> insertData(
      {required String table, required Map<String, dynamic> data}) async {
    final db = await _database;
    int id = await db.insert(table, data);
    return id > 0;
  }

  Future<List<Map<String, dynamic>>> readData({
    required String table,
    List<String>? columns,
    String? where,
    List<Object?>? whereArgs,
    String? groupBy,
    String? orderBy,
  }) async {
    final db = await _database;
    return await db.query(table,
        columns: columns,
        where: where,
        whereArgs: whereArgs,
        groupBy: groupBy,
        orderBy: orderBy);
  }

  Future<bool> updateData({
    required String table,
    required Map<String, dynamic> data,
    String? where,
    List<Object?>? whereArgs,
  }) async {
    final db = await _database;
    int value =
    await db.update(table, data, where: where, whereArgs: whereArgs);
    return value > 0;
  }

  Future<bool> deleteData({
    required String table,
    String? where,
    List<Object?>? whereArgs
  }) async {
    final db = await _database;
    int count = await db.delete(table, where: where, whereArgs: whereArgs);
    return count > 0;
  }

  _createContactTable(Database db) async {
    await db.execute('CREATE TABLE ${ConstantStrings.vocabTable} ('
        '${ConstantStrings.id} INTEGER PRIMARY KEY,'
        '${ConstantStrings.burmese} TEXT,'
        '${ConstantStrings.japanese} TEXT,'
        '${ConstantStrings.note} TEXT,'
        '${ConstantStrings.isActive} BOOLEAN,'
        '${ConstantStrings.isFavourite} BOOLEAN'
        ')');
  }

  Future<String> _getDatabasePath() async {
    String dirPath = await getDatabasesPath();
    String dbPath = join(dirPath, _dbName);
    return dbPath;
  }
}
