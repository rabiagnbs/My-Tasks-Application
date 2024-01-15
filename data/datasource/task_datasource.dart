
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../utils/db_keys.dart';
import '../models/task.dart';

class TaskDatasource {
  static final TaskDatasource _instance = TaskDatasource._();

  factory TaskDatasource() => _instance;

  TaskDatasource._() {
    _initDb();
  }

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, DBKeys.dbName);

    return await openDatabase(
      path,
      version: 2, // Güncellenmiş sürüm numarası
      onCreate: _onCreate,
      onUpgrade: _onUpgrade, // Yeni eklenen metod
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${DBKeys.dbTable}(
        ${DBKeys.idColumn} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${DBKeys.titleColumn} TEXT,
        ${DBKeys.noteColumn} TEXT,
        ${DBKeys.dateColumn} TEXT,
        ${DBKeys.timeColumn} TEXT,
        ${DBKeys.categoryColumn} TEXT,
        ${DBKeys.isCompletedColumn} INTEGER,
        ${DBKeys.katilimci_sayisiColumn} INTEGER
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Eğer sürüm 1 ise ve yeni sürüm 2 ise, sütun eklemeyi yap
      await db.execute('ALTER TABLE ${DBKeys.dbTable} ADD COLUMN ${DBKeys.katilimci_sayisiColumn} INTEGER');
    }
    // Diğer sürümler için gerekirse burada başka güncelleme işlemleri yapılabilir
  }

  Future<int> addTask(Task task) async {
    final db = await database;
    return db.transaction((txn) async {
      return await txn.insert(
        DBKeys.dbTable,
        task.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  Future<int> updateTask(Task task) async {
    final db = await database;
    return db.transaction((txn) async {
      return await txn.update(
        DBKeys.dbTable,
        task.toJson(),
        where: 'id = ?',
        whereArgs: [task.id],
      );
    });
  }

  Future<int> deleteTask(Task task) async {
    final db = await database;
    return db.transaction((txn) async {
      return await txn.delete(
        DBKeys.dbTable,
        where: 'id = ?',
        whereArgs: [task.id],
      );
    });
  }

  Future<List<Task>> getAllTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      DBKeys.dbTable,
      orderBy: "id DESC",
    );
    return List.generate(
      maps.length,
          (index) {
        return Task.fromJson(maps[index]);
      },
    );
  }
}
