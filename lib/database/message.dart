import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/model/message.dart';

class MessageDb {
  static final MessageDb instance = MessageDb._init();

  static Database? _database;

  MessageDb._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('message.db');
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
        ${FieldNames.message} $textType, 
        ${FieldNames.sequence} $integerType, 
        ${FieldNames.sender} $integerType,
        ${FieldNames.status} $integerType, 
        ${FieldNames.sentDate} $textType, ''');
  }

  Future<Message> create(Message message) async {
    final db = await instance.database;

    final id = await db.insert(tableName, message.toJson());
    return message.copy(id: id);
  }

  Future<Message> findOne(int id) async {
    final db = await instance.database;

    final maps = await db.query(tableName,
        columns: FieldNames.values,
        where: '${FieldNames.id} = ?',
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Message.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
