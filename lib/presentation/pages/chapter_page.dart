import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hadith/presentation/pages/hadith_detail_page.dart';
import '../controllers/chapter_controller.dart';
import '../../core/db/app_database.dart';
import '../../data/repositories.dart';

final db = AppDatabase();
final repo = HadithRepository(db);

class ChaptersPage extends StatelessWidget {
  final int bookId;
  final String bookName;
  final int numberOfHadis;

  ChaptersPage(
      {Key? key,
      required this.bookId,
      required this.bookName,
      required this.numberOfHadis})
      : super(key: key);

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChapterController(repo, bookId));

    return Scaffold(
      backgroundColor: Color(0xFF0D111C),
      appBar: AppBar(
        backgroundColor: Color(0xFF0D111C),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Imam ${bookName[0].toUpperCase() + bookName.substring(1).toLowerCase()}  ',
                style: TextStyle(fontSize: 20, color: Colors.white)),
            Text('$numberOfHadis টি হাদিস',
                style: TextStyle(fontSize: 14, color: Colors.white70)),
          ],
        ),
      ),
      body: Obx(() => Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Color(0xFF1C2230),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: searchController,
                    style: TextStyle(color: Colors.white),
                    onChanged: (value) => controller.searchQuery.value = value,
                    decoration: InputDecoration(
                      hintText: 'অধ্যায় সার্চ করুন',
                      hintStyle: TextStyle(color: Colors.white70),
                      border: InputBorder.none,
                      icon: Icon(Icons.search, color: Colors.white70),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.filteredChapters.length,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  itemBuilder: (context, index) {
                    final chapter = controller.filteredChapters[index];
                    return GestureDetector(
                      onTap: () => Get.to(() => HadithDetailsPage(
                          bookId: bookId,
                          chapterId: chapter.id,
                          bookName: bookName ?? '',
                          chapterTitle: chapter.title ?? '')),
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 6),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Color(0xFF1C2230),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Color(0xFF2ECC71),
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '${chapter.number ?? index + 1}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    chapter.title ?? '',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if (chapter.hadisRange != null)
                                    Text(
                                      'হাদিসের রেঞ্জঃ ${chapter.hadisRange}',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 13,
                                      ),
                                    ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }
}
