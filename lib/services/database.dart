import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DbHelper {
  static late DbHelper _dbHelper = DbHelper();
  static late Database _database;
  DbHelper._createObject();

  Future<Database> initDb() async {
    //untuk menentukan nama database dan lokasi yg dibuat
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}buku_kas.db';

    //create, read databases
    var itemDatabase = openDatabase(path, version: 4, onCreate: _createDb);
    //mengembalikan nilai object sebagai hasil dari fungsinya
    return itemDatabase;
  }

  //buat tabel baru dengan nama item
  void _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE income (
      income_id INTEGER PRIMARY KEY AUTOINCREMENT,
      amount INTEGER,
      description TEXT,
      date TEXT
      )
    ''');
    await db.execute('''
      INSERT INTO income (amount, description, date) VALUES (100000, 'Penghasilan', '2021-01-01')''');
  }

  // //create databases
  // Future<int> insert(Item object) async {
  //   Database db = await initDb();
  //   int count = await db.insert('item', object.toMap());
  //   return count;
  // }

  // //update databases
  // Future<int> update(Item object) async {
  //   Database db = await initDb();
  //   int count = await db
  //       .update('item', object.toMap(), where: 'id=?', whereArgs: [object.id]);
  //   return count;
  // }

  // //delete databases
  // Future<int> delete(int id) async {
  //   Database db = await initDb();
  //   int count = await db.delete('item', where: 'id=?', whereArgs: [id]);
  //   return count;
  // }

  // Future<List<Item>> getItemList() async {
  //   var itemMapList = await select();
  //   int count = itemMapList.length;
  //   List<Item> itemList = List<Item>();
  //   for (int i = 0; i < count; i++) {
  //     itemList.add(Item.fromMap(itemMapList[i]));
  //   }
  //   return itemList;
  // }

  factory DbHelper() {
    _dbHelper;
    return _dbHelper;
  }
  // Future<Database> get database async {
  //   if (_database == null) {
  //     _database = await initDb();
  //   }
  //   return _database;
  // }
}
