import 'package:flutter/material.dart';
import 'home/accountinfoscreen.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
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
        title: const Text('حسابي', style: TextStyle(color: Colors.black)),
        backgroundColor: const Color(0xFFFEF9F1),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/blet.png'),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: _showEditNameDialog,
              child: const Text(
                'تعديل الاسم',
                style: TextStyle(fontSize: 18, color: Colors.deepOrange),
              ),
            ),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.black),
              title: const Text('معلومات الحساب'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const AccountInfoScreen()),
                );
              },
            ),
            const Divider(),
            SwitchListTile(
              title: const Text('إشعارات'),
              value: _notificationsEnabled,
              onChanged: (bool value) {
                setState(() => _notificationsEnabled = value);
              },
              activeColor: Colors.deepOrange,
            ),
            const Divider(),
            SwitchListTile(
              title: const Text('الوضع الليلي'),
              value: _darkModeEnabled,
              onChanged: (bool value) {
                setState(() => _darkModeEnabled = value);
              },
              activeColor: Colors.deepOrange,
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.language, color: Colors.black),
              title: const Text('اللغة'),
              trailing: DropdownButton<String>(
                value: _language,
                items: ['العربية', 'English'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() => _language = newValue);
                  }
                },
              ),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }

  void _showEditNameDialog() {
    // ignore: no_leading_underscores_for_local_identifiers
    final TextEditingController _nameController =
        TextEditingController(text: _userName);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('تعديل الاسم'),
          content: TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'اسم المستخدم'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('إلغاء'),
            ),
            TextButton(
              onPressed: () {
                setState(() => _userName = _nameController.text);
                Navigator.of(context).pop();
              },
              child: const Text('حفظ'),
            ),
          ],
        );
      },
    );
  }
}
