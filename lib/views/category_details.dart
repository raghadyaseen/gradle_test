import 'package:flutter/material.dart';
import 'details_page.dart'; // تأكد من استيراد تفاصيل الصفحة هنا
import 'shop_card.dart'; // تأكد من استيراد ShopCard هنا

class CategoryDetails extends StatelessWidget {
  final String title;
  final String imagePath;

  CategoryDetails({required this.title, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: TextStyle(color: Colors.black)),
        backgroundColor: const Color.fromARGB(255, 254, 249, 241),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
          ),
          itemCount: 20, // عدد العناصر في الشبكة
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsPage(
                      title: '$title - عنصر $index', // يمكنك تخصيص العنوان
                      imagePath: 'assets/shop1_1.png', // استخدم مسار الصورة
                    ),
                  ),
                );
              },
              child: ShopCard(
                title: 'عنوان العنصر $index', // تمرير عنوان لكل عنصر
                imagePath: 'assets/shop1_1.png', // استخدم مسار الصورة
              ),
            );
          },
        ),
      ),
    );
  }
}
