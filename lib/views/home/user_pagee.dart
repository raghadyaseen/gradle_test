import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gradle_test/views/home/works_detialies.dart' show WorksDetails;

class UserPage extends StatefulWidget {
  final String uid;

  UserPage({required this.uid});

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  DocumentSnapshot? documentt;
  List<DocumentSnapshot> doc = [];
  var docLength = 0;

  @override
  void initState() {
    super.initState();
    userdd();
    user_work();
  }

  Future<void> userdd() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: widget.uid)
          .get();

      if (snapshot.docs.isNotEmpty) {
        setState(() {
          documentt = snapshot.docs.first;
        });
      } else {
        print("Document does not exist.");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  Future<void> user_work() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('works')
          .where('uid', isEqualTo: widget.uid)
          .get();

      setState(() {
        docLength = snapshot.docs.length;
        doc = snapshot.docs;
      });

      if (snapshot.docs.isNotEmpty) {
        print("Works found: ${snapshot.docs.length}");
      } else {
        print("No works found.");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50],
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Image.asset('assets/logo2.png', height: 40),
        elevation: 2,
        centerTitle: true,
      ),
      body: documentt == null
          ? Center(
              child: CircularProgressIndicator(color: Colors.orange),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// صورة المستخدم
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.orange[800]!,
                          width: 3,
                        ),
                      ),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          "https://www.i2clipart.com/cliparts/6/b/7/c/clipart-male-user-icon-512x512-6b7c.png",
                        ),
                        radius: 50,
                        backgroundColor: Colors.orange[100],
                      ),
                    ),
                    SizedBox(height: 20),

                    /// اسم المستخدم
                    Text(
                      documentt!['name'] ?? 'No Name',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange[900],
                      ),
                    ),
                    SizedBox(height: 8),

                    /// البريد الإلكتروني
                    Text(
                      documentt!['email'] ?? 'No Email',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.orange[700],
                      ),
                    ),
                    SizedBox(height: 20),

                    /// عنوان الأعمال
                    Text(
                      "الأعمال",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: Colors.orange[800],
                      ),
                    ),
                    SizedBox(height: 20),

                    /// عرض الأعمال
                    docLength == 0
                        ? Center(
                            child: Text(
                              'لم يتم العثور على أعمال.',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                          )
                        : GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.8,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: docLength,
                            itemBuilder: (context, index) {
                              var workDoc = doc[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          WorksDetails(uiddd: workDoc.id),
                                    ),
                                  );
                                },
                                child: Card(
                                  elevation: 6,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  color: Colors.white,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.work,
                                              size: 50,
                                              color: Colors.orange[900]),
                                          SizedBox(height: 10),
                                          Text(
                                            'العمل ${index + 1}',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.orange[900],
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            workDoc['title'] ?? 'No Title',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.orange[700],
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ],
                ),
              ),
            ),
    );
  }
}
