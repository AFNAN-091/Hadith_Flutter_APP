import 'package:get/get.dart';
import '../../core/db/app_database.dart';
import '../../data/repositories.dart';

class HadithController extends GetxController {
  final HadithRepository repository;
  final int bookId;
  final int chapterId;
  var hadiths = <HadithData>[].obs;

  HadithController(this.repository, this.bookId, this.chapterId);
  @override
  void onInit() {
    fetchHadiths(bookId, chapterId);
    super.onInit();
  }

  void fetchHadiths(int bookId, int chapterId) async {
    hadiths.value = await repository.fetchHadithsByChapter(bookId, chapterId);
  }
}
