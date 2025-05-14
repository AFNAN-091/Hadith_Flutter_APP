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
      backgroundColor: Color(0xFF0A0E12),
      body: SafeArea(
        child: Column(
          children: [
            // Custom App Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.menu, color: Colors.white),
                  Text("আল হাদিস",
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  Icon(Icons.search, color: Colors.white),
                ],
              ),
            ),
            // Hadith Quote
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '“তিনি রাসুল (সল্লাল্লাহু ‘আলাইহি ওয়া সাল্লাম)...”\n[উপদেশ]',
                style: TextStyle(color: Colors.white70, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),

            SizedBox(height: 16),
            // Book List Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("সব হাদিসের বই",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
            SizedBox(height: 8),
            // Book List
            Expanded(
              child: Obx(() => ListView.builder(
                    itemCount: controller.books.length,
                    itemBuilder: (context, index) {
                      final book = controller.books[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 6),
                        child: Card(
                          color: Color(0xFF1E1E1E),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor:
                                  hexToColor(book.colorCode ?? "#4CAF50"),
                              child: Text(
                                book.abvrCode ?? '',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            title: Text(book.title ?? '',
                                style: TextStyle(color: Colors.white)),
                            subtitle: Text(
                              "Imam ${book.bookName != null && book.bookName!.isNotEmpty ? book.bookName![0].toUpperCase() + book.bookName!.substring(1).toLowerCase() : 'N/A'}",
                              style: TextStyle(color: Colors.white54),
                            ),
                            trailing: Text(
                              "${book.numberOfHadis ?? 0} \nহাদিস",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            onTap: () => Get.to(() => ChaptersPage(
                                  bookId: book.id,
                                  bookName: book.bookName ?? 'unknown',
                                  numberOfHadis: book.numberOfHadis ?? 0,
                                )),
                          ),
                        ),
                      );
                    },
                  )),
            ),
          ],
        ),
      ),
      // Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.greenAccent,
        unselectedItemColor: Colors.black54,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: ''),
        ],
      ),
    );
  }

  Color hexToColor(String code) {
    code = code.replaceAll('#', '');
    if (code.length == 6) {
      code = 'FF$code'; // add alpha if not provided
    }
    return Color(int.parse(code, radix: 16));
  }
}
