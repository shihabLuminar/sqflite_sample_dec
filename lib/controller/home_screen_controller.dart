import 'package:sqflite/sqflite.dart';

class HomeScreenController {
  static late Database database;
  static List<Map<String, Object?>> data = [];
  static Future initDb() async {
    // open the database
    database = await openDatabase("sampledb.db", version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Empolyees (id INTEGER PRIMARY KEY, name TEXT, des TEXT)');
    });
  }

  //funtion to add data to db

  static Future addDataToDb({required String name, required String des}) async {
    await database.rawInsert(
        'INSERT INTO Empolyees(name, des) VALUES(?, ?)', [name, des]);
  }

  // function to get all data form db
  static Future getAllDataFromDb() async {
    data = await database.rawQuery('SELECT * FROM Empolyees');
    print(data);
  }

  // function to edit data in db
  static Future editData(var id) async {
    await database.rawUpdate(
        'UPDATE Empolyees SET name = ?, des = ? WHERE id = ?',
        ['editted', '9876', id]);
    await getAllDataFromDb();
  }

  // function to delete data in db

  static Future deleteData(var id) async {
    await database.rawDelete('DELETE FROM Empolyees WHERE id = ?', [id]);
    await getAllDataFromDb();
  }
}
