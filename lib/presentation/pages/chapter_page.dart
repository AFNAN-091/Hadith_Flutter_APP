import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hadith/presentation/pages/hadith_detail_page.dart';
import '../controllers/chapter_controller.dart';
import 'home_page.dart';

class ChaptersPage extends StatelessWidget {
  final int bookId;
  ChaptersPage({required this.bookId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChapterController(repo, bookId));
    return Scaffold(
      appBar: AppBar(title: Text('Chapters')),
      body: Obx(() => ListView.builder(
            itemCount: controller.chapters.length,
            itemBuilder: (context, index) {
              final chapter = controller.chapters[index];
              return ListTile(
                title: Text(chapter.title ?? ''),
                onTap: () =>
                    Get.to(() => HadithDetailsPage(chapterId: chapter.id)),
              );
            },
          )),
    );
  }
}
