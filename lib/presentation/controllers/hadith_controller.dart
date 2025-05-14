import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../core/db/app_database.dart';
import '../../data/repositories.dart';

class HadithController extends GetxController {
  final HadithRepository repository;
  final int chapterId;
  var hadiths = <HadithData>[].obs;

  HadithController(this.repository, this.chapterId);

  @override
  void onInit() {
    fetchHadiths();
    super.onInit();
  }

  void fetchHadiths() async {
    hadiths.value = await repository.fetchHadithsByChapter(chapterId);
  }
}
