import 'dart:async';

import 'package:flutter_application_4/model/futbolcu.dart';
import 'package:flutter_application_4/model/takim.dart';
import 'package:flutter_application_4/model/teknik.dart';
import 'package:flutter_application_4/model/yonetim.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class FutbolcuDataBase {
  static final FutbolcuDataBase instance = FutbolcuDataBase._init();

  static Database? _database;
  FutbolcuDataBase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB("Takimlar.db");
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    return await openDatabase(filePath,
        version: 1, onCreate: _createDB, onConfigure: _onConfigure);
  }

  Future _createDB(Database db, int version) async {
    final idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    final textType = "TEXT NOT NULL";
    final integerType = "INTEGER NOT NULL";

    await db.execute('''
CREATE TABLE $tabloTakim(
   ${TakimFields.id} $idType,
   ${TakimFields.isim} $textType,
   ${TakimFields.kurulus} $integerType,
   ${TakimFields.kadroDegeri} $integerType,
   ${TakimFields.resim} $textType
   
   
   )
''');

    await db.execute('''
CREATE TABLE $tabloFutbolcular (
  ${FutbolcuFields.id} $idType,
  ${FutbolcuFields.isim} $textType,
  ${FutbolcuFields.pozisyon} $textType,
  ${FutbolcuFields.yas} $integerType,
  ${FutbolcuFields.uyruk} $textType,
  ${FutbolcuFields.maas} $integerType,
  ${FutbolcuFields.piyasa} $integerType,
  ${FutbolcuFields.takimId} $integerType,
  FOREIGN KEY (${FutbolcuFields.takimId}) REFERENCES $tabloTakim(${TakimFields.id})

)

    ''');

    await db.execute('''
CREATE TABLE $tabloYonetim(
  ${YonetimFields.id} $idType,
  ${YonetimFields.isim} $textType,
  ${YonetimFields.yas} $integerType,
  ${YonetimFields.maas} $integerType,
  ${YonetimFields.gorev} $textType,
  ${YonetimFields.takimId} $integerType, 
  FOREIGN KEY (${YonetimFields.takimId}) REFERENCES $tabloTakim(${TakimFields.id})
)
''');

    await db.execute('''
CREATE TABLE $tabloTeknikEkip(
  ${TeknikEkipFields.id} $idType,
  ${TeknikEkipFields.isim} $textType,
  ${TeknikEkipFields.yas} $integerType,
  ${TeknikEkipFields.maas} $integerType,
  ${TeknikEkipFields.gorev} $textType,
  ${TeknikEkipFields.takimId} $integerType, 
  FOREIGN KEY (${TeknikEkipFields.takimId}) REFERENCES $tabloTakim(${TakimFields.id})
)

''');
  }

  Future <Yonetim> createYonetimUyesi (Yonetim uye) async {
    final db = await instance.database;
    final id = await db.insert(tabloYonetim, uye.toJson());
    return uye.copy(id: id);
  }
  Future<TeknikEkip> createTeknikEkipUyesi(TeknikEkip uye) async{
    final db = await instance.database;
    final id = await db.insert(tabloTeknikEkip, uye.toJson());
    return uye.copy(id: id);
  }
  Future<Futbolcu> createFutbolcu(Futbolcu futbolcu) async {
    final db = await instance.database;
    final id = await db.insert(tabloFutbolcular, futbolcu.toJson());

    return futbolcu.copy(id: id);
  }
  
  Future createTakim(TakimModel takim) async {
    final db = await instance.database;
    final id = await db.insert(tabloTakim, takim.toJson());

    return takim.copy(id: id);
  }

  Future<Futbolcu> readFutbolcu(int id) async {
    final db = await instance.database;
    final maps = await db.query(tabloFutbolcular,
        columns: FutbolcuFields.values,
        where:
            " ${FutbolcuFields.id} = $id "); //bu kullanım şekli sql injection a maruz kalabilir
    if (maps.isNotEmpty) {
      return Futbolcu.fromJson(maps.first);
    } else {
      throw Exception("$id bulunamadı");
    }
  }
  Future <List<Yonetim>> readOneTeamsYonetim (int takimId) async {
    final db = await instance.database;
    final maps = await db.query(tabloYonetim,
    columns: YonetimFields.values,
    where : "${YonetimFields.takimId} = $takimId");

    return maps.map((e) => Yonetim.fromJson(e)).toList();
  }
  Future<List<TeknikEkip>> readOneTeamsTeknikEkip (int takimId) async{
    final db = await instance.database;
    final maps = await db.query(tabloTeknikEkip,
    columns: TeknikEkipFields.values,
    where: "${TeknikEkipFields.takimId} = $takimId"
    );

    return maps.map((e) => TeknikEkip.fromJson(e)).toList();
  }

  Future<List<Futbolcu>> readOneTeamsPlayers(int takimId) async {
    final db = await instance.database;
    final maps = await db.query(tabloFutbolcular,
        columns: FutbolcuFields.values,
        where: "${FutbolcuFields.takimId} = $takimId");

    return maps.map((e) => Futbolcu.fromJson(e)).toList();
  }

  Future<List<TakimModel>> readAllTakim() async {
    final db = await instance.database;
    final result = await db.query(tabloTakim);

    return result.map((json) => TakimModel.fromJson(json)).toList();
  }

  Future<List<Futbolcu>> readAllFutbolcu() async {
    final db = await instance.database;

    final result = await db.query(tabloFutbolcular);
    return result.map((json) => Futbolcu.fromJson(json)).toList();
  }
  
  Future updateKadroDegeri(TakimModel takim) async {
    final db = await instance.database;
    
    int toplamKadroDegeri = 0;
    final futbolcular = await FutbolcuDataBase.instance.readOneTeamsPlayers(takim.id!);
    if(futbolcular.isNotEmpty){
    futbolcular.forEach((futbolcu) { 
       toplamKadroDegeri += futbolcu.piyasa;
     });
    
  }
  return await db.rawUpdate('UPDATE $tabloTakim SET ${TakimFields.kadroDegeri} = ? WHERE ${TakimFields.id} = ?', [toplamKadroDegeri, takim.id]);
  }
  Future<int> updateFutbolcu(Futbolcu futbolcu) async {
    final db = await instance.database;
    return db.update(tabloFutbolcular, futbolcu.toJson(),
        where: "${FutbolcuFields.id} = ${futbolcu.id}");
  }

  Future<int> deleteFutbolcu(int id) async {
    final db = await instance.database;

    return db.delete(tabloFutbolcular, where: "${FutbolcuFields.id} = $id");
  }

  Future close() async {
    final db = await instance.database;
    _database = null;
    db.close();
  }

  /* Future<FutureOr<void>> _upgradeDB(
      Database db, int oldVersion, int newVersion) async {
    final idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    final textType = "TEXT NOT NULL";
    final integerType = "INTEGER NOT NULL";
    if (oldVersion == 1) {

      await db.execute('''
ALTER TABLE $tabloFutbolcular ADD COLUMN ${FutbolcuFields.takimId} $integerType,
FOREIGN KEY(${FutbolcuFields.takimId}) REFERENCES $tabloTakim(${TakimFields.id})
''');

      await db.execute('''
CREATE TABLE $tabloLig(
  ${LigFields.id} $idType,
  ${LigFields.isim} $textType,
  ${LigFields.resim} $textType 


)
''');
      await db.execute('''
CREATE TABLE $tabloYonetim(
  ${YonetimFields.id} $idType,
  ${YonetimFields.isim} $textType,
  ${YonetimFields.yas} $integerType,
  ${YonetimFields.maas} $integerType,
  ${YonetimFields.gorev} $textType,
  ${YonetimFields.takimId} $integerType,
   FOREIGN KEY(${YonetimFields.takimId}) REFERENCES $tabloTakim(${TakimFields.id})
)
''');
      await db.execute('''
CREATE TABLE $tabloTakim(
   ${TakimFields.id} $idType,
   ${TakimFields.isim} $textType,
   ${TakimFields.kurulus} $integerType,
   ${TakimFields.kadroDegeri} $integerType,
   ${TakimFields.ligId} $integerType,
  FOREIGN KEY(${TakimFields.ligId}) REFERENCES $tabloLig(${LigFields.id})
   )
''');
      await db.execute('''
CREATE TABLE $tabloTeknikEkip(
  ${TeknikEkipFields.id} $idType,
  ${TeknikEkipFields.isim} $textType,
  ${TeknikEkipFields.yas} $integerType,
  ${TeknikEkipFields.maas} $integerType,
  ${TeknikEkipFields.gorev} $textType,
  ${TeknikEkipFields.takimId} $integerType, 
  FOREIGN KEY(${TeknikEkipFields.takimId}) REFERENCES $tabloTakim(${TakimFields.id})
)

''');
    }
  } */

  Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }
}
