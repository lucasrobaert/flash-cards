import 'dart:io';

import 'package:flashcardsmobile/modal_class/flash_card.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static late Database _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  String flashTable = 'cards_table';
  String colId = 'id';
  String colFront = 'front';
  String colBack = 'back';
  String colType = 'type';
  String colKnown = 'known';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/restaurant-favorite.db',
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $flashTable 
          (
            $colId INTEGER PRIMARY KEY AUTOINCREMENT, 
            $colFront TEXT, 
            $colBack TEXT, 
            $colType TEXT, 
            $colKnown BOOLEAN)
        ''');
      },
      version: 1,
    );
    return db;
  }

  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }

  Future<List<Map<String, dynamic>>> getCardsMapList() async {
    Database db = await database;

    var result = await db.query(flashTable, where: '$colKnown = 0');

    return result;
  }

  Future<int> insertFlashCard(FlashCard card) async {
    Database db = await database;

    var result = await db.insert(flashTable, card.toMap());
    print("============= Insert data ================");
    return result;
  }

  Future<int?> getCount() async {
    Database db = await database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT(*) FROM $flashTable');

    int? result = Sqflite.firstIntValue(x);

    return result;
  }

  Future<List<FlashCard>> getCardsList() async {
    var cardsMapList = await getCardsMapList();
    int count = cardsMapList.length;

    List<FlashCard> cardList = [];

    for (int i = 0; i < count; i++) {
      cardList.add(FlashCard.fromMapObject(cardsMapList[i]));
    }

    return cardList;
  }
}
