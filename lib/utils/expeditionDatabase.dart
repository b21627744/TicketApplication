import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ticket_application/models/expedition.dart';
import 'package:ticket_application/models/ticketInfo.dart';

class ExpeditionDatabase {
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      //print(_db);
      return _db!;
    }
    _db = await _initDB('Expeditions_database2.db');
    return _db!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''CREATE TABLE expeditions_table2(
        id INTEGER,
        name TEXT, 
        date TEXT,
        hour TEXT,
        departure TEXT,
        destination TEXT,
        seatsNumber INTEGER,
        seatsList TEXT,
        seatsStyle TEXT,
        price INTEGER)''');
    await db.execute('''CREATE TABLE ticket_table3(
        id INTEGER,
        expeditionID INTEGER, 
        totalPrice INTEGER,
        selectedSeatsNumbers TEXT,
        selectedSeatsPayment TEXT,
        passengerName TEXT,
        passengerSurname TEXT,
        passengerTC TEXT,
        telNo TEXT,
        mailAdreess TEXT,
        cardNo TEXT,
        cardSKT TEXT,
        cardCVC TEXT)''');
  }

  Future<int> insertExpeditions(Expedition expedition) async {
    final db1 = await db;
    if (await controlExpedition(expedition.id)) {
      //return await updateExpeditions(expedition);
      return 0;
    } else {
      return await db1.insert(
        'expeditions_table2',
        expedition.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<int> insertTicket(TicketInfo ticket) async {
    final db1 = await db;
    //print(db.insert("Expeditions", expedition.toMap()));
    return await db1.insert(
      'ticket_table3',
      ticket.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> updateExpeditions(Expedition expedition) async {
    final db1 = await db;
    return await db1.update(
      'expeditions_table2',
      expedition.toMap(),
      where: 'id = ?',
      whereArgs: [expedition.id],
    );
  }

  Future<void> deleteExpeditions(int id) async {
    final db1 = await db;

    await db1.delete(
      'expeditions_table2',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Expedition>> expeditionsList() async {
    final db1 = await db;

    final List<Map<String, dynamic>> maps =
        await db1.query('expeditions_table2');

    return List.generate(maps.length, (i) {
      return Expedition(
        id: maps[i]['id'],
        name: maps[i]['name'],
        date: maps[i]['date'],
        hour: maps[i]['hour'],
        departure: maps[i]['departure'],
        destination: maps[i]['destination'],
        seatsNumber: maps[i]['seatsNumber'],
        seatsList: maps[i]['seatsList'],
        seatsStyle: maps[i]['seatsStyle'],
        price: maps[i]['price'],
      );
    });
  }

  Future<List<TicketInfo>> ticketList() async {
    final db1 = await db;

    final List<Map<String, dynamic>> maps = await db1.query('ticket_table3');

    return List.generate(maps.length, (i) {
      return TicketInfo(
        id: maps[i]['id'],
        expeditionID: maps[i]['expeditionID'],
        totalPrice: maps[i]['totalPrice'],
        selectedSeatsNumbers: maps[i]['selectedSeatsNumbers'],
        selectedSeatsPayment: maps[i]['selectedSeatsPayment'],
        passengerName: maps[i]['passengerName'],
        passengerSurname: maps[i]['passengerSurname'],
        passengerTC: maps[i]['passengerTC'],
        telNo: maps[i]['telNo'],
        mailAdreess: maps[i]['mailAdreess'],
        cardNo: maps[i]['cardNo'],
        cardSKT: maps[i]['cardSKT'],
        cardCVC: maps[i]['cardCVC'],
      );
    });
  }

  Future<bool> controlExpedition(int id) async {
    final db1 = await db;

    final maps = await db1.query(
      'expeditions_table2',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return true;
      //return Expedition.fromMap(maps.first);
    } else {
      return false;
    }
  }
}
