import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الإشعارات',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 2,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            _buildNotificationCard(
              title: 'تنبيه 1',
              description: 'هذا هو وصف التنبيه 1',
              icon: Icons.notifications_active,
            ),
            _buildNotificationCard(
              title: 'تنبيه 2',
              description: 'هذا هو وصف التنبيه 2',
              icon: Icons.warning_amber_rounded,
            ),
            _buildNotificationCard(
              title: 'تنبيه 3',
              description: 'هذا هو وصف التنبيه 3',
              icon: Icons.info_outline,
            ),
            _buildNotificationCard(
              title: 'تنبيه 4',
              description: 'هذا هو وصف التنبيه 4',
              icon: Icons.message,
            ),
            _buildNotificationCard(
              title: 'تنبيه 5',
              description: 'هذا هو وصف التنبيه 5',
              icon: Icons.event_available,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationCard({
    required String title,
    required String description,
    required IconData icon,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, color: Colors.orange, size: 30),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 18),
        onTap: () {
          // تنفيذ أي عملية عند الضغط على الإشعار
        },
      ),
    );
  }
}
