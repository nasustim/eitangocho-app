import 'package:eitangocho_app/repository/sqlite/config.dart' as c;
import 'package:eitangocho_app/repository/sqlite/queries.dart' as q;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQLite {
  Database? _db;

  Future<Database> _init() async {
    final dbFile = join(await getDatabasesPath(), c.dbName);
    return await openDatabase(
      dbFile,
      version: c.dbVersion,
      onCreate: (db, version) async {
        for (final query in q.migrationQueries[0]) {
          await db.execute(query);
        }
      },
      onUpgrade: (Database db, int prevVersion, int currentVersion) async {
        for (var i = prevVersion; i < currentVersion; i++) {
          for (final query in q.migrationQueries[i]) {
            await db.execute(query);
          }
        }
      },
    );
  }

  Future<void> connect() async {
    if (_db != null) return;
    _db = await _init();
  }
}
