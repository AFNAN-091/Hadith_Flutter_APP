import '../core/db/app_database.dart';

class HadithRepository {
  final AppDatabase db;

  HadithRepository(this.db);

  Future<List<Book>> fetchAllBooks() async {
    return await db.getAllBooks();
  }

  Future<List<ChapterData>> fetchChaptersByBook(int bookId) async {
    return await db.getChaptersByBookId(bookId);
  }

  Future<List<HadithData>> fetchHadithsByChapter(int chapterId) async {
    return await db.getHadithsByChapterId(chapterId);
  }
}
