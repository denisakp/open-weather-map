import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static const _databaseName = 'weather.db';
  static const _databaseVersion = 1;

  static const forecastTable = 'forecasts';
  static const forecastTableQuery = 'CREATE TABLE forecasts (id INTEGER PRIMARY KEY AUTOINCREMENT, count INTEGER NOT NULL, items TEXT NOT NULL)';

  static const currentTable = 'currents';
  static const currentTableQuery = 'CREATE TABLE currents (id INTEGER PRIMARY KEY AUTOINCREMENT, weather TEXT NOT NULL, ) ';


  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'weather.db'),
      onCreate: (database, version) async {
        await database.execute(
          'CREATE TABLE weather'
        );
      }
    );
  }
}