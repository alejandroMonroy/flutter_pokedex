import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteService {
  static late Database database;
  SqfliteService._();

  static Future initDatabase() async {
    final database = await openDatabase(
      join(await getDatabasesPath(), 'pokedex.db'),
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE pokemons(id INTEGER PRIMARY KEY, pokemonId INTEGER, name TEXT, imageUrl TEXT, height INTEGER, weight INTEGER, types TEXT)',
        );
        db.execute(
          'CREATE TABLE pokedex(id INTEGER PRIMARY KEY, pokemonId INTEGER, FOREIGN KEY (pokemonId) REFERENCES pokemons (id) ON DELETE NO ACTION ON UPDATE NO ACTION)',
        );
      },
      version: 1,
    );

    SqfliteService.database = database;
  }

  static Future insert(String table, Map<String, Object?> map) async {
    await database.insert(
      table,
      map,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future remove(String table, Map<String, Object?> map) async {
    await database.delete(table,
        where: 'pokemonId = ?', whereArgs: ['%${map['pokemonId']}%']);
  }

  static Future<List<Map<String, Object?>>> retrieve(
    String table,
    String query,
  ) async {
    final data = await SqfliteService.database.query(
      table,
      where: 'name LIKE ?',
      whereArgs: ['%$query%'],
    );

    return data;
  }

  static Future<List<Map<String, Object?>>> retrieveFromPokedex() async {
    return await SqfliteService.database.rawQuery("""
    SELECT p.* 
    FROM pokedex pd 
    INNER JOIN pokemons p ON pd.pokemonId = p.id
  """);
  }

  static Future clearTable(String table) async {
    await SqfliteService.database.delete(table);
  }
}
