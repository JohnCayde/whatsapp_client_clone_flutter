import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/model/friend.dart';

class FriendDb {
  static final FriendDb instance = FriendDb._init();

  static Database? _database;

  FriendDb._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('friends.db');
    // await _database?.execute("DROP TABLE IF EXISTS $tableName");
    // const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    // const textType = "TEXT NOT NULL";
    // const integerType = "INTEGER NOT NULL";
    // await _database?.execute('''CREATE TABLE $tableName (
    //     ${FieldNames.id} $idType,
    //     ${FieldNames.phoneId} $integerType,
    //     ${FieldNames.name} $textType,
    //     ${FieldNames.phone} $textType,
    //     ${FieldNames.description} $textType )''');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const textType = "TEXT NOT NULL";
    // const boolType = "BOOLEAN NOT NULL";
    const integerType = "INTEGER NOT NULL";

    await db.execute('''CREATE TABLE $tableName ( 
        ${FieldNames.id} $idType, 
        ${FieldNames.phoneId} $integerType, 
        ${FieldNames.name} $textType, 
        ${FieldNames.phone} $textType, 
        ${FieldNames.description} $textType )''');
  }

  Future<Friend> create(Friend friend) async {
    final db = await instance.database;

    final id = await db.insert(tableName, friend.toJson());
    return friend.copy(id: id);
  }

  Future<Friend> findOne(int id) async {
    final db = await instance.database;

    final maps = await db.query(tableName,
        columns: FieldNames.values,
        where: '${FieldNames.id} = ?',
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Friend.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Friend>> findAll() async {
    final db = await instance.database;

    final maps = await db.query(tableName, columns: FieldNames.values);

    return maps.map((e) => Friend.fromJson(e)).toList();
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
