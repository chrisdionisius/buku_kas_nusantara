import 'dart:io';
import 'package:buku_kas_nusantara/models/cash_flow.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DataHelper {
  late Database db;

  Future<Database> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}buku_kas.db';
    var itemDatabase = openDatabase(path, version: 1, onCreate: _createDb);
    return itemDatabase;
  }

  void _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE cashflow (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      type INTEGER,
      amount INTEGER,
      description TEXT,
      date TEXT
      )
    ''');
    await db.execute('''
      INSERT INTO cashflow (type,amount, description, date) VALUES (0,100000, 'Penghasilan', '2021-01-01')''');
  }

  //Select Cashflow
  Future<List<CashFlow>> selectCashFlow() async {
    Database db = await initDb();
    final List<Map<String, dynamic>> maps =
        await db.query('cashflow', orderBy: 'date');
    return List.generate(maps.length, (i) {
      return CashFlow(
        id: maps[i]['id'],
        type: maps[i]['type'],
        amount: maps[i]['amount'],
        description: maps[i]['description'],
        date: maps[i]['date'],
      );
    });
  }

  Future close() async {
    Database db = await initDb();
    db.close();
  }
}
