import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // استيراد حزمة firebase_core
import 'package:gradle_test/views/home/home_screen.dart';
import 'onboarding/splash_screen.dart'; // شاشة البداية الخاصة بك

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // تأكيد تهيئة الفلاتر قبل التشغيل
  await Firebase.initializeApp(); // تهيئة Firebase

  runApp(const MyApp()); // تشغيل التطبيق بعد التهيئة
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sanaaty',
      debugShowCheckedModeBanner: false, // إخفاء الشريط العلوي
      theme: ThemeData(fontFamily: 'Aljazeera.ttf' //لخط العربي

          ),
      home: SplashScreen(), // شاشة البداية التي قمت بإنشائها
    );
  }
}
