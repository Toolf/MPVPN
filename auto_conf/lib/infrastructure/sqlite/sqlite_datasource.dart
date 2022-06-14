import 'dart:io' as io;

import 'package:sqlite3/sqlite3.dart';

class SqliteDatasource {
  late final _db;

  SqliteDatasource() {
    if (!io.File("database.db").existsSync()) {
      _db = sqlite3.open("database.db");

      _db.execute('''
        CREATE TABLE mptcp_config (
          id INTEGER NOT NULL PRIMARY KEY,
          onlyDefault BOOLEAN NOT NULL,
          defauktConfigId 
        );
      ''');
    } else {
      _db = sqlite3.open("database.db");
    }
  }
}
