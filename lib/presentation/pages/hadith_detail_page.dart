import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hadith/presentation/pages/home_page.dart';

import '../controllers/hadith_controller.dart';

class HadithDetailsPage extends StatelessWidget {
  final int chapterId;
  HadithDetailsPage({required this.chapterId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HadithController(repo, chapterId));
    return Scaffold(
      appBar: AppBar(title: Text('Hadiths')),
      body: Obx(() => ListView.builder(
            itemCount: controller.hadiths.length,
            itemBuilder: (context, index) {
              final hadith = controller.hadiths[index];
              return Card(
                margin: EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Hadith ${index + 1}",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          IconButton(
                            icon: Icon(Icons.more_vert),
                            onPressed: () => showModalBottomSheet(
                              context: context,
                              builder: (_) => HadithBottomSheet(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(hadith.ar ?? '', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 10),
                      Text(hadith.bn ?? '',
                          style:
                              TextStyle(fontSize: 14, color: Colors.grey[700])),
                    ],
                  ),
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
      height: 180,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Options",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 10),
          Row(
            children: [Icon(Icons.copy), SizedBox(width: 10), Text("Copy")],
          ),
          SizedBox(height: 10),
          Row(
            children: [Icon(Icons.share), SizedBox(width: 10), Text("Share")],
          ),
        ],
      ),
    );
  }
}
