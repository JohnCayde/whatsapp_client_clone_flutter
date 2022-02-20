import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/model/member.dart';

class MemberDb {
  static final MemberDb instance = MemberDb._init();

  static Database? _database;

  MemberDb._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('members.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    // const textType = "TEXT NOT NULL";
    // const boolType = "BOOLEAN NOT NULL";
    const integerType = "INTEGER NOT NULL";

    await db.execute('''CREATE TABLE $tableName ( 
        ${FieldNames.id} $idType, 
        ${FieldNames.roomId} $integerType, 
        ${FieldNames.memberId} $integerType, 
        ${FieldNames.status} $integerType )''');
  }

  Future<Member> create(Member member) async {
    final db = await instance.database;

    final id = await db.insert(tableName, member.toJson());
    return member.copy(id: id);
  }

  Future<Member> findOne(int id) async {
    final db = await instance.database;

    final maps = await db.query(tableName,
        columns: FieldNames.values,
        where: '${FieldNames.id} = ?',
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Member.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Member>> findAll() async {
    final db = await instance.database;

    final maps = await db.query(tableName, columns: FieldNames.values);

    return maps.map((e) => Member.fromJson(e)).toList();
  }

  Future<bool> isExist(int memberId) async {
    final db = await instance.database;
    final maps = await db.query(tableName,
        columns: FieldNames.values,
        where: '${FieldNames.memberId} = ? AND ${FieldNames.status} = ?',
        whereArgs: [memberId, 2]);

    return maps.isNotEmpty;
  }

  Future<List<Member>> getRoomMember(int roomId) async {
    final db = await instance.database;
    final maps = await db.query(tableName,
        columns: FieldNames.values,
        where: '${FieldNames.roomId} = ?',
        whereArgs: [roomId]);

    return maps.map((e) => Member.fromJson(e)).toList();
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
