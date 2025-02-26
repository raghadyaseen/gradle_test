import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 254, 249, 241),
        elevation: 0,
        title: const Text(
          "Forgot Password",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 232, 143, 60),
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 254, 249, 241),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/password.png",
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                labelText: "Phone Number",
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 232, 143, 60), width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 232, 143, 60), width: 2),
                ),
                prefixIcon: Icon(Icons.phone),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // send sms to the user
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 254, 249, 241),
                backgroundColor: const Color.fromARGB(255, 232, 143, 60),
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                "Send SMS",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
