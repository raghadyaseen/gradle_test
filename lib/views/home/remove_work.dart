import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RemoveWork extends StatefulWidget {
  const RemoveWork({super.key});

  @override
  State<RemoveWork> createState() => _RemoveWorkState();
}

class _RemoveWorkState extends State<RemoveWork> {
  List<DocumentSnapshot> doc = [];
  int docLength = 0;

  @override
  void initState() {
    super.initState();
    user_work();
  }

  // جلب الأعمال للمستخدم
  Future<void> user_work() async {
    try {
      String? currentUserUid = FirebaseAuth.instance.currentUser?.uid;

      if (currentUserUid != null) {
        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('works')
            .where('uid', isEqualTo: currentUserUid)
            .get();

        setState(() {
          docLength = snapshot.docs.length;
          doc = snapshot.docs;
        });
      } else {
        print("No user is currently signed in.");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  // حذف العمل من قاعدة البيانات
  Future<void> deleteWork(String workId) async {
    try {
      // حذف المستند باستخدام الـ ID الفريد
      await FirebaseFirestore.instance.collection('works').doc(workId).delete();
      
      // تحديث الواجهة بعد حذف العمل
      setState(() {
        doc.removeWhere((element) => element.id == workId);
        docLength = doc.length;
      });

      // إظهار رسالة تأكيد الحذف
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Work has been deleted successfully!'),
      ));
    } catch (e) {
      print("Error deleting work: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset('assets/logo2.png', height: 40),
        elevation: 0,
        centerTitle: true,
      ),
      body: docLength == 0
          ? Center(child: Text('No works found.'))
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // عدد الأعمدة
                  childAspectRatio: 1.5, // نسبة العرض إلى الارتفاع
                ),
                itemCount: docLength,
                itemBuilder: (context, index) {
                  var workDoc = doc[index]; // استخدام المستند هنا
                  return Card(
                    color: Colors.orange[800], // لون الخلفية
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'المنشور ${index + 1}',
                            style: TextStyle(
                              color: Colors.white, // لون النص
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          // زر حذف
                          IconButton(
                            onPressed: () {
                              // استخدام الـ Document ID لحذف العمل
                              deleteWork(workDoc.id); 
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
