import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController(); // إضافة متحكم النص للاسم
  final _phonenumber =TextEditingController();
  // إعدادات Firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    // تهيئة Firebase عند بداية التطبيق
    Firebase.initializeApp();
  }

  // دالة لتسجيل المستخدم باستخدام البريد الإلكتروني وكلمة المرور
  Future<void> _signUp() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();
    String name = _nameController.text.trim(); // الحصول على الاسم
    String phone=_phonenumber.text.trim();
    if (password != confirmPassword) {
      _showMessage("Passwords do not match!");
      return;
    }

    try {
      // إنشاء المستخدم باستخدام البريد الإلكتروني وكلمة المرور
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // بعد إنشاء الحساب بنجاح، نقوم بإضافة المستند إلى Firestore
      if (userCredential.user != null) {
        // الحصول على مرجع إلى مجموعة المستخدمين
        CollectionReference users = FirebaseFirestore.instance.collection('users');

        // إضافة مستند جديد للمستخدم مع بياناته (الاسم و uid)
        await users.doc(userCredential.user!.uid).set({
          'name': name, // إضافة الاسم
          'email': email,
          'uid': userCredential.user!.uid, // إضافة uid الخاص بالمستخدم
          'createdAt': Timestamp.now(), 
          'user_phone':phone
          
        });

        _showMessage("Account created successfully!");
        
      }
    } on FirebaseAuthException catch (e) {
      _showMessage(e.message ?? "An error occurred.");
    }
  }

  // دالة لعرض رسائل للمستخدم
  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 254, 249, 241),
        elevation: 0,
        title: const Text(
          "",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 232, 143, 60),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Image.asset(
              "assets/logo2.png",
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 30),
            _buildTextField("Name", Icons.person, TextInputType.text, controller: _nameController), // خانة الاسم
            const SizedBox(height: 30),
            _buildTextField("phone_num", Icons.phone, TextInputType.text, controller: _phonenumber), // خانة الاسم
          
            const SizedBox(height: 20),
            _buildTextField("Email", Icons.email, TextInputType.emailAddress, controller: _emailController),
            const SizedBox(height: 20),
            _buildTextField("Password", Icons.lock, TextInputType.text, obscureText: true, controller: _passwordController),
            const SizedBox(height: 20),
            _buildTextField("Confirm Password", Icons.lock, TextInputType.text, obscureText: true, controller: _confirmPasswordController),
            const SizedBox(height: 100),
            ElevatedButton(
              onPressed: _signUp, // عند الضغط على الزر نقوم بتنفيذ دالة التسجيل
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 232, 143, 60),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Sign Up",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 254, 249, 241),
    );
  }

  // دالة لإنشاء حقل النص (TextField) بشكل مخصص
  Widget _buildTextField(String label, IconData icon, TextInputType inputType, {bool obscureText = false, TextEditingController? controller}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey, fontSize: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 232, 143, 60),
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 232, 143, 60),
            width: 10,
          ),
        ),
        prefixIcon: Icon(icon, color: const Color.fromARGB(255, 232, 143, 60)),
      ),
      keyboardType: inputType,
      obscureText: obscureText,
    );
  }
}
