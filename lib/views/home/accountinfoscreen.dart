import 'package:flutter/material.dart';

class AccountInfoScreen extends StatelessWidget {
  const AccountInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('معلومات الحساب', style: TextStyle(color: Colors.black)),
        backgroundColor: const Color(0xFFFEF9F1),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                // وظيفة تعديل رقم الهاتف
              },
              child: const Text('تعديل رقم الهاتف',
                  style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                // وظيفة تعديل كلمة المرور
              },
              child: const Text('تعديل كلمة المرور',
                  style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
