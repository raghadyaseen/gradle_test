import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('التنبيهات', style: TextStyle(color: Colors.black)),
        backgroundColor: const Color.fromARGB(255, 254, 249, 241),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            ListTile(
              title: Text('تنبيه 1'),
              subtitle: Text('هذا هو وصف التنبيه 1'),
              leading: Icon(Icons.notifications, color: Colors.orange),
            ),
            ListTile(
              title: Text('تنبيه 2'),
              subtitle: Text('هذا هو وصف التنبيه 2'),
              leading: Icon(Icons.notifications, color: Colors.orange),
            ),
            ListTile(
              title: Text('تنبيه 3'),
              subtitle: Text('هذا هو وصف التنبيه 3'),
              leading: Icon(Icons.notifications, color: Colors.orange),
            ),
            // أضف المزيد من التنبيهات حسب الحاجة
            ListTile(
              title: Text('تنبيه 4'),
              subtitle: Text('هذا هو وصف التنبيه 4'),
              leading: Icon(Icons.notifications, color: Colors.orange),
            ),
            ListTile(
              title: Text('تنبيه 5'),
              subtitle: Text('هذا هو وصف التنبيه 5'),
              leading: Icon(Icons.notifications, color: Colors.orange),
            ),
          ],
        ),
      ),
    );
  }
}
