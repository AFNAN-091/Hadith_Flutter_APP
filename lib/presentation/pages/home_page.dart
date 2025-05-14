import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hadith/presentation/pages/chapter_page.dart';

import '../../core/db/app_database.dart';
import '../../data/repositories.dart';
import '../controllers/home_controller.dart';

final db = AppDatabase();
final repo = HadithRepository(db);

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController(repo));
    return Scaffold(
      appBar: AppBar(title: Text('Hadith Books')),
      body: Obx(() => ListView.builder(
            itemCount: controller.books.length,
            itemBuilder: (context, index) {
              final book = controller.books[index];
              return ListTile(
                title: Text(book.title ?? ''),
                subtitle: Text('Book ID: ${book.id}'),
                onTap: () => Get.to(() => ChaptersPage(bookId: book.id)),
              );
            },
          )),
    );
  }
}
