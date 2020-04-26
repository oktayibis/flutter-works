//bu sinif database ile ilgili herseyi yapmamzi saglayan siniftir.import
//veritabina ulasmak cagirmak silme ya da ekleme gibi tum vertabani islemler icin metodlari yazariz
//bir standart olarak her zaman kullanabiliriz
//main.dart tarafindan her zaman ulasilmasini istemeyiz. bu nedenle veritabini olustur vs gibi konular private olarak burada yapilir.
//boylece database degisse bile kodda degisiklik yapmamiza gerek kalmaz.

//muhakkak singleton yapilmalidir. birden fazla nesne olusturulmasina izin verilmez

import 'dart:io';

import 'package:flutter/services.dart';
import 'package:not_sepeti/models/kategori.dart';
import 'package:not_sepeti/models/notlar.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  //database helper daha onceden olusturuldu mu
  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._internal();
      return _databaseHelper;
    } else
      return _databaseHelper;
  }

  DatabaseHelper._internal();

  Future<Database> _getDatabase() async {
    if (_database == null) {
      _database = await _initializeDatabase();
      return _database;
    } else
      return _database;
  }

  _initializeDatabase() async {
    var lock = Lock();
    Database _db;

    if (_db == null) {
      await lock.synchronized(() async {
        if (_db == null) {
          var databasesPath = await getDatabasesPath();
          var path = join(databasesPath, 'appDB.db');
          var file = new File(path);

          //check if file exits
          if (!await file.exists()) {
            //copy from assests
            ByteData data = await rootBundle.load(join("assets", "notlar.db"));
            List<int> bytes =
                data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
            await new File(path).writeAsBytes(bytes);
          }
          //open database
          _db = await openDatabase(path);
        }
      });
    }
    return _db;
  }

  //kategoriIslemleri CRUD

  kategoriGetir() async {
    var db = await _getDatabase();
    var sonuc = await db.query("kategori");
    return sonuc;
  }

  kategoriEkle(Kategori kategori) async {
    var db = await _getDatabase();
    var sonuc = await db.insert('kategori', kategori.toMap());

    return sonuc;
  }

  kategoriGuncelle(Kategori kategori) async {
    var db = await _getDatabase();
    var sonuc = await db.update('kategori', kategori.toMap(),
        where: 'kategoriID=?', whereArgs: [kategori.kategoriID]);

    return sonuc;
  }

  kategoriSil(int kategoriID) async {
    var db = await _getDatabase();
    var sonuc = await db
        .delete('kategori', where: 'kategoriID=?', whereArgs: [kategoriID]);

    return sonuc;
  }

  //NotIslemleri CRUD

  notlariGetir() async {
    var db = await _getDatabase();
    var sonuc = await db.query('not', orderBy: 'notID DESC');
    return sonuc;
  }

  Future<int> notEkle(Not not) async {
    var db = await _getDatabase();
    var sonuc = await db.insert("not", not.toMap());
    return sonuc;
  }

  notGuncelle(Not not) async {
    var db = await _getDatabase();
    var sonuc = await db
        .update('not', not.toMap(), where: 'notID=?', whereArgs: [not.notID]);

    return sonuc;
  }

  notSil(int notID) async {
    var db = await _getDatabase();
    var sonuc = await db.delete('not', where: 'notID=?', whereArgs: [notID]);

    return sonuc;
  }

  String dateFormat(DateTime tm) {
    DateTime today = new DateTime.now();
    Duration oneDay = new Duration(days: 1);
    Duration twoDay = new Duration(days: 2);
    Duration oneWeek = new Duration(days: 7);
    String month;
    switch (tm.month) {
      case 1:
        month = "Ocak";
        break;
      case 2:
        month = "Şubat";
        break;
      case 3:
        month = "Mart";
        break;
      case 4:
        month = "Nisan";
        break;
      case 5:
        month = "Mayıs";
        break;
      case 6:
        month = "Haziran";
        break;
      case 7:
        month = "Temmuz";
        break;
      case 8:
        month = "Ağustos";
        break;
      case 9:
        month = "Eylük";
        break;
      case 10:
        month = "Ekim";
        break;
      case 11:
        month = "Kasım";
        break;
      case 12:
        month = "Aralık";
        break;
    }

    Duration difference = today.difference(tm);

    if (difference.compareTo(oneDay) < 1) {
      return "Bugün";
    } else if (difference.compareTo(twoDay) < 1) {
      return "Dün";
    } else if (difference.compareTo(oneWeek) < 1) {
      switch (tm.weekday) {
        case 1:
          return "Pazartesi";
        case 2:
          return "Salı";
        case 3:
          return "Çarşamba";
        case 4:
          return "Perşembe";
        case 5:
          return "Cuma";
        case 6:
          return "Cumartesi";
        case 7:
          return "Pazar";
      }
    } else if (tm.year == today.year) {
      return '${tm.day} $month';
    } else {
      return '${tm.day} $month ${tm.year}';
    }
    return "";
  }
}
