import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
              "assets/signup.png",
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 30),
            _buildTextField("Full Name", Icons.person, TextInputType.text),
            const SizedBox(height: 20),
            _buildTextField("Phone Number", Icons.phone, TextInputType.phone),
            const SizedBox(height: 20),
            _buildTextField("Password", Icons.lock, TextInputType.text,
                obscureText: true),
            const SizedBox(height: 20),
            _buildTextField("Confirm Password", Icons.lock, TextInputType.text,
                obscureText: true),
            const SizedBox(height: 100),
            ElevatedButton(
              onPressed: () {},
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

  Widget _buildTextField(String label, IconData icon, TextInputType inputType,
      {bool obscureText = false}) {
    return TextField(
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
