import 'package:get/get.dart';
import '../../core/db/app_database.dart';
import '../../data/repositories.dart';

class HomeController extends GetxController {
  final HadithRepository repository;
  var books = <Book>[].obs;

  HomeController(this.repository);

  @override
  void onInit() {
    fetchBooks();
    super.onInit();
  }

  void fetchBooks() async {
    books.value = await repository.fetchAllBooks();
  }
}
