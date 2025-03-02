import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsPage extends StatelessWidget {
  final String title;
  final String imagePath;

  DetailsPage({required this.title, required this.imagePath});

  void openWhatsApp() async {
    const phoneNumber = "+962790615563";
    final url = "https://wa.me/$phoneNumber";

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "لا يمكن فتح WhatsApp";
    }
  }

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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(imagePath, height: 200, fit: BoxFit.cover),
            ),
            SizedBox(height: 16),
            Text(
              'الوصف:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'هذا هو وصف العنصر. يمكنك إضافة المزيد من التفاصيل هنا.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.whatsapp, color: Colors.green),
                  onPressed: openWhatsApp,
                ),
                IconButton(
                  icon: Icon(Icons.call),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('اتصال'),
                        content: Text('0791523759'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('إغلاق'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
            // قسم التقييمات (يمكنك تخصيصه حسب الحاجة)
            SizedBox(height: 16),
            Text('التقييم:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(5, (index) {
                return Icon(Icons.star, color: Colors.orange);
              }),
            ),
          ],
        ),
      ),
    );
  }
}
