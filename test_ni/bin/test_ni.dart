import 'dart:io';

import 'package:sqlite3/sqlite3.dart';

void main() {
  print('Using sqlite3 ${sqlite3.version}');

  // Create a new in-memory database. To use a database backed by a file, you
  // can replace this with sqlite3.open(yourFilePath).
  final db = sqlite3.open("database.sqlite");

  // Create a table and insert some data
  db.execute('''
    CREATE TABLE "NetworkInterfaceConfig" (
  "networkinterfaceconfigId" INTEGER PRIMARY KEY AUTOINCREMENT,
  "dev" varchar NOT NULL,
  "index" None NULL,
  "fwmark" None NULL,
  "ipaddress" varchar NULL,
  "metric" None NOT NULL
);

CREATE TABLE "VtrunkdConfig" (
  "vtrunkdconfigId" INTEGER PRIMARY KEY AUTOINCREMENT,
  "onlyDefault" None NOT NULL,
  "serverIpAddress" varchar NOT NULL,
  "port" None NOT NULL,
  "configPath" varchar NOT NULL
);


CREATE TABLE "VtrunkdSession" (
  "vtrunkdsessionId" INTEGER PRIMARY KEY AUTOINCREMENT,
  "vtrunkdConfig_vtrunkdconfigId" INTEGER NOT NULL,
  "number" None NOT NULL
);


CREATE TABLE "MptcpConfig" (
  "mptcpconfigId" INTEGER PRIMARY KEY AUTOINCREMENT,
  "onlyDefault" None NOT NULL,
  "defaultConfig_networkinterfaceconfigId" INTEGER NOT NULL
);

  ''');

  // Don't forget to dispose the database to avoid memory leaks
  db.dispose();
}
