import 'package:moor_flutter/moor_flutter.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart' as p;
// import 'dart:io';

part 'db_helper.g.dart';

class Days extends Table {
  TextColumn get id => text()();
  TextColumn get date => text()();
  TextColumn get achievementsString => text().nullable()();
  TextColumn get betterString => text()();
  IntColumn get rating => integer()();
  TextColumn get highlightString => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@UseMoor(tables: [Days])
class AppDatabase extends _$AppDatabase {
  // AppDatabase() : super(_openConnection());
  AppDatabase()
      // Specify the location of the database file
      : super((FlutterQueryExecutor.inDatabaseFolder(
          path: 'db.sqlite',
          // Good for debugging - prints SQL in the console
          // logStatements: true,
        )));

  @override
  int get schemaVersion => 1;

  Future<List<Day>> getAllDays() => (select(days)..orderBy([(d) => OrderingTerm.desc(d.date)])).get();
  Stream<List<Day>> watchAllDays() => (select(days)..orderBy([(d) => OrderingTerm.desc(d.date)])).watch();
  Stream<Day> watchDay(String id) => (select(days)..where((day) => day.id.equals(id))).watchSingle();
  Future<Day> getDay(String id) => (select(days)..where((day) => day.id.equals(id))).getSingle();
  Future<Day> getLatestDay() => (select(days)..orderBy([(d) => OrderingTerm.desc(d.date)])..limit(1)).getSingle();
  Future upsertDay(Day day) => into(days).insertOnConflictUpdate(day);
  Future deleteDay(Day day) => delete(days).delete(day);

}






// LazyDatabase _openConnection() {
//   // the LazyDatabase util lets us find the right location for the file async.
//   return LazyDatabase(() async {
//     // put the database file, called db.sqlite here, into the documents folder
//     // for your app.
//     final dbFolder = await getApplicationDocumentsDirectory();
//     final file = File(p.join(dbFolder.path, 'db.sqlite'));
//     return VmDatabase(file);
//   });
// }