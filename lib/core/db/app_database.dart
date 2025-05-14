// lib/core/db/app_database.dart
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

part 'app_database.g.dart';

// BOOKS TABLE
class Books extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().nullable()();
  TextColumn get titleAr => text().nullable()();
  IntColumn get numberOfHadis => integer().nullable()();
  TextColumn get abvrCode => text().nullable()();
  TextColumn get bookName => text().nullable()();
  TextColumn get bookDescr => text().nullable()();
  TextColumn get colorCode => text().nullable()();
}

// CHAPTER TABLE
class Chapter extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get chapterId => integer()();
  IntColumn get bookId => integer()();
  TextColumn get title => text()();
  IntColumn get number => integer()();
  TextColumn get hadisRange => text().nullable()();
  TextColumn get bookName => text()();
}

// HADITH TABLE
class Hadith extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get bookId => integer()();
  TextColumn get bookName => text().nullable()();
  IntColumn get chapterId => integer()();
  IntColumn get sectionId => integer().nullable()();
  TextColumn get hadithKey => text().nullable()();
  IntColumn get hadithId => integer().nullable()();
  TextColumn get narrator => text().nullable()();
  TextColumn get bn => text().nullable()();
  TextColumn get ar => text().nullable()();
  TextColumn get arDiacless => text().nullable()();
  TextColumn get note => text().nullable()();
  IntColumn get gradeId => integer().nullable()();
  TextColumn get grade => text().nullable()();
  TextColumn get gradeColor => text().nullable()();
}

@DriftDatabase(tables: [Books, Chapter, Hadith])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // CRUD operations will go here
  Future<List<Book>> getAllBooks() => select(books).get();

  Future<List<ChapterData>> getChaptersByBookId(int bookId) {
    return (select(chapter)..where((tbl) => tbl.bookId.equals(bookId))).get();
  }

  Future<List<HadithData>> getHadithsByChapterId(int chapterId) {
    return (select(hadith)..where((tbl) => tbl.chapterId.equals(chapterId)))
        .get();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'hadith_bn_test.db'));
    return NativeDatabase.createInBackground(file);
  });
}
