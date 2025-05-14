import 'package:get/get.dart';
import '../../core/db/app_database.dart';
import '../../data/repositories.dart';

class ChapterController extends GetxController {
  final HadithRepository repository;
  final int bookId;
  var chapters = <ChapterData>[].obs;
  var filteredChapters = <ChapterData>[].obs;
  var searchQuery = ''.obs;

  ChapterController(this.repository, this.bookId);

  @override
  void onInit() {
    fetchChapters();
    super.onInit();
    debounce(searchQuery, (_) => applySearch(),
        time: Duration(milliseconds: 300));
  }

  void fetchChapters() async {
    final result = await repository.fetchChaptersByBook(bookId);
    chapters.assignAll(result);
    filteredChapters.assignAll(result);
  }

  void applySearch() {
    if (searchQuery.value.isEmpty) {
      filteredChapters.assignAll(chapters);
    } else {
      final query = searchQuery.value.toLowerCase();
      filteredChapters.assignAll(
        chapters.where((c) =>
            (c.title?.toLowerCase().contains(query) ?? false) ||
            (c.hadisRange?.contains(query) ?? false)),
      );
    }
  }
}
