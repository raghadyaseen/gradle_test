import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UploadWork extends StatefulWidget {
  final String cid;

  const UploadWork({super.key, required this.cid});

  @override
  _UploadWorkState createState() => _UploadWorkState();
}

class _UploadWorkState extends State<UploadWork> {
  final TextEditingController p_num = TextEditingController();
  final TextEditingController w_name = TextEditingController();
  final TextEditingController w_disc = TextEditingController();
  File? _image;

  String getCurrentUserUID() {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.uid ?? "No user logged in";
  }

  Future<void> addDocumentToCollection() async {
    try {
      String uidd = getCurrentUserUID();
      CollectionReference collectionRef =
          FirebaseFirestore.instance.collection('works');

      await collectionRef.add({
        'p_num': p_num.text.trim(),
        'w_name': w_name.text.trim(),
        'w_disc': w_disc.text.trim(),
        'uid': uidd,
        'cid': widget.cid,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("تم رفع العمل بنجاح!"),
            backgroundColor: const Color.fromARGB(255, 242, 134, 57)),
      );
    } catch (e) {
      print("Error adding document: $e");
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset('assets/logo2.png', height: 40),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// إدخال رقم العمل
              TextField(
                controller: p_num,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'رقم العمل ',
                  prefixIcon: Icon(Icons.numbers,
                      color: const Color.fromARGB(255, 242, 134, 57)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              SizedBox(height: 16),

              /// إدخال وصف العمل
              TextField(
                controller: w_disc,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'وصف العمل',
                  prefixIcon: Icon(Icons.description,
                      color: const Color.fromARGB(255, 242, 134, 57)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              SizedBox(height: 16),

              /// إدخال اسم العمل
              TextField(
                controller: w_name,
                decoration: InputDecoration(
                  labelText: 'اسم العمل',
                  prefixIcon: Icon(Icons.work,
                      color: const Color.fromARGB(255, 242, 134, 57)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              SizedBox(height: 16),

              /// زر اختيار صورة
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 242, 134, 57),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      "اختيار صورة",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),

              /// عرض الصورة المختارة
              _image != null
                  ? Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                            image: FileImage(_image!), fit: BoxFit.cover),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              blurRadius: 6,
                              spreadRadius: 2),
                        ],
                      ),
                    )
                  : Center(
                      child: Text(
                        "لم يتم اختيار صورة",
                        style: TextStyle(color: Colors.redAccent, fontSize: 16),
                      ),
                    ),
              SizedBox(height: 20),

              /// زر رفع العمل
              GestureDetector(
                onTap: addDocumentToCollection,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          spreadRadius: 1),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "رفع العمل",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
