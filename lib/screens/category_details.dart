import 'package:flutter/material.dart';

class CategoryDetailsPage extends StatelessWidget {
  final String title;
  final String image;
  final String description;

  CategoryDetailsPage(
      {required this.title, required this.image, required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color.fromARGB(255, 254, 249, 241),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Image.asset(image, width: 150, height: 150),
          SizedBox(height: 20),
          Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              description,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepOrange,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            ),
            onPressed: () {
              // تنفيذ أي أكشن إضافي هنا
            },
            child: Text("طلب خدمة"),
          ),
        ],
      ),
    );
  }
}
