import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hadith/presentation/pages/home_page.dart';

import '../controllers/hadith_controller.dart';

class HadithDetailsPage extends StatelessWidget {
  final int chapterId;
  final int bookId;
  final String bookName;
  final String chapterTitle;
  HadithDetailsPage(
      {required this.bookId,
      required this.chapterId,
      required this.bookName,
      required this.chapterTitle});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HadithController(repo, bookId, chapterId));
    return Scaffold(
      backgroundColor: Color(0xFF0D111C),
      appBar: AppBar(
        backgroundColor: Color(0xFF0D111C),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(bookName[0].toUpperCase() + bookName.substring(1),
                style: TextStyle(fontSize: 20, color: Colors.white)),
            Text(chapterTitle,
                style: TextStyle(fontSize: 14, color: Colors.white70)),
          ],
        ),
      ),
      body: Obx(() => ListView.builder(
            itemCount: controller.hadiths.length,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemBuilder: (context, index) {
              final hadith = controller.hadiths[index];

              return Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFF1C2230),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${chapterId}/${hadith.hadithId}. অধ্যায়ঃ ",
                          style: TextStyle(
                              color: Color(0xFF34D399),
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Color(0xFF10B981),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "সহিহ হাদিস",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: IconButton(
                                icon: Icon(Icons.more_vert,
                                    color: Colors.white54),
                                onPressed: () => showModalBottomSheet(
                                  context: context,
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(16)),
                                  ),
                                  builder: (_) => HadithBottomSheet(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    // Arabic text
                    Text(
                      hadith.ar ?? '',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        height: 1.6,
                        // fontFamily: 'Amiri', // Optional: Arabic font
                      ),
                    ),

                    // Tag

                    SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: hadith.narrator ?? '',
                            style: TextStyle(
                                color: Color(0xFF10B981), fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),
                    // Bangla translation
                    Text(
                      hadith.bn ?? '',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                        height: 1.6,
                        // fontFamily: 'NotoSansBengali', // Optional: Bangla font
                      ),
                    ),

                    SizedBox(height: 10),

                    // More options
                  ],
                ),
              );
            },
          )),
    );
  }
}

class HadithBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      height: 310,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("More Options",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(
                Icons.bookmark,
                color: Color(0xFF10B981),
              ),
              SizedBox(width: 10),
              Text("Add to Collection")
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(
                Icons.copy_rounded,
                color: Color(0xFF10B981),
              ),
              SizedBox(width: 10),
              Text("Bangla Copy")
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(
                Icons.copy_rounded,
                color: Color(0xFF10B981),
              ),
              SizedBox(width: 10),
              Text("English Copy")
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(
                Icons.copy_rounded,
                color: Color(0xFF10B981),
              ),
              SizedBox(width: 10),
              Text("Arabic Copy")
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(
                Icons.add,
                color: Color(0xFF10B981),
              ),
              SizedBox(width: 10),
              Text("Add Note")
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(
                Icons.share_outlined,
                color: Color(0xFF10B981),
              ),
              SizedBox(width: 10),
              Text("Share")
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(
                Icons.report_gmailerrorred,
                color: Color(0xFF10B981),
              ),
              SizedBox(width: 10),
              Text("Share")
            ],
          ),
        ],
      ),
    );
  }
}
