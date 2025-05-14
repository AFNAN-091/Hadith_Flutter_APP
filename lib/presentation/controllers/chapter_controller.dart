import 'package:get/get.dart';
import '../../core/db/app_database.dart';
import '../../data/repositories.dart';

class ChapterController extends GetxController {
  final HadithRepository repository;
  final int bookId;
  var chapters = <ChapterData>[].obs;

  ChapterController(this.repository, this.bookId);

  @override
  void onInit() {
    fetchChapters();
    super.onInit();
  }

  void fetchChapters() async {
    chapters.value = await repository.fetchChaptersByBook(bookId);
  }
}
