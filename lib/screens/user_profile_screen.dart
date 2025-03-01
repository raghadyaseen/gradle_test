import 'package:flutter/material.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  String _userName = 'اسم المستخدم';
  String _language = 'العربية';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('حسابي', style: TextStyle(color: Colors.black)),
        backgroundColor: const Color.fromARGB(255, 254, 249, 241),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // صورة البروفايل
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/user_avatar.png'),
              // ضع أي صورة لديك أو صورة افتراضية
            ),
            SizedBox(height: 16),
            // زر تعديل الاسم
            TextButton(
              onPressed: () => _showEditNameDialog(),
              child: Text(
                'Edit Name',
                style: TextStyle(fontSize: 18, color: Colors.deepOrange),
              ),
            ),
            SizedBox(height: 24),

            // إعدادات الحساب
            ListTile(
              leading: Icon(Icons.settings, color: Colors.black),
              title: Text('معلومات الحساب'),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // يمكنك فتح صفحة أخرى تعرض معلومات تفصيلية
              },
            ),
            Divider(),

            // تفعيل الإشعارات
            SwitchListTile(
              title: Text('Show notifications'),
              value: _notificationsEnabled,
              onChanged: (bool value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
              activeColor: Colors.deepOrange,
            ),
            Divider(),

            // تفعيل الوضع الليلي (مثال)
            SwitchListTile(
              title: Text('الوضع الليلي'),
              value: _darkModeEnabled,
              onChanged: (bool value) {
                setState(() {
                  _darkModeEnabled = value;
                });
              },
              activeColor: Colors.deepOrange,
            ),
            Divider(),

            // تغيير اللغة
            ListTile(
              leading: Icon(Icons.language, color: Colors.black),
              title: Text('اللغة'),
              trailing: DropdownButton<String>(
                value: _language,
                items: <String>['العربية', 'English'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    if (newValue != null) {
                      _language = newValue;
                    }
                  });
                },
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

  void _showEditNameDialog() {
    final TextEditingController _nameController =
        TextEditingController(text: _userName);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('تعديل الاسم'),
          content: TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'اسم المستخدم'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('إلغاء'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _userName = _nameController.text;
                });
                Navigator.of(context).pop();
              },
              child: Text('حفظ'),
            ),
          ],
        );
      },
    );
  }
}
