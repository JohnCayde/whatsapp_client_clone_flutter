import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/model/room.dart';

class RoomDb {
  static final RoomDb instance = RoomDb._init();

  static Database? _database;

  RoomDb._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('rooms.db');
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
    // const integerType = "INTEGER NOT NULL";

    await db.execute('''CREATE TABLE $tableName ( 
        ${FieldNames.id} $idType, 
        ${FieldNames.name} $textType, 
        ${FieldNames.profileImage} $textType, 
        ${FieldNames.description} $textType,
        ${FieldNames.lastUpdated} $textType, ''');
  }

  Future<Room> create(Room room) async {
    final db = await instance.database;

    final id = await db.insert(tableName, room.toJson());
    return room.copy(id: id);
  }

  Future<Room> findOne(int id) async {
    final db = await instance.database;

    final maps = await db.query(tableName,
        columns: FieldNames.values,
        where: '${FieldNames.id} = ?',
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Room.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
