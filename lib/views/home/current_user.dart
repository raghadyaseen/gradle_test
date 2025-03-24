import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gradle_test/views/home/remove_work.dart' show RemoveWork;
import 'package:gradle_test/views/home/works_detialies.dart' show WorksDetails;

class UserPagee extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPagee> {
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
      String? currentUserUid = FirebaseAuth.instance.currentUser?.uid;

      if (currentUserUid != null) {
        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('uid', isEqualTo: currentUserUid)
            .get();

        if (snapshot.docs.isNotEmpty) {
          setState(() {
            documentt = snapshot.docs.first;
          });
        } else {
          print("Document does not exist.");
        }
      } else {
        print("No user is currently signed in.");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

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

        if (snapshot.docs.isNotEmpty) {
          print("Works found: ${snapshot.docs.length}");
        } else {
          print("No works found.");
        }
      } else {
        print("No user is currently signed in.");
      }
    } catch (e) {
      print("Error fetching data: $e");
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
      body: documentt == null
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.orange,
                                width: 4,
                              ),
                            ),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                "https://www.i2clipart.com/cliparts/6/b/7/c/clipart-male-user-icon-512x512-6b7c.png",
                              ),
                              radius: 80,
                            ),
                          ),

                          //----------------------------------------------------------------------
                          
                          //----------------------------------------------------------------------
                          
                          //----------------------------------------------------------------------
                          
                          //----------------------------------------------------------------------
                          
                          //----------------------------------------------------------------------
                          Container(
                            padding: EdgeInsets.only(right: 10, bottom: 20), 
                            alignment: Alignment.topRight, // Move the button to the top right
                            child: FloatingActionButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        RemoveWork(),
                                  ),
                                );
                              },
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                              backgroundColor: Colors.orange[800], // لون خلفية الزر
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.orange[800],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              "المنشورات: $docLength",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        documentt!['name'] ?? 'No Name',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange[800],
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        documentt!['email'] ?? 'No Email',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.orange[700],
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "منشوراتي",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                          color: Colors.orange[800],
                        ),
                      ),
                      SizedBox(height: 20),
                      docLength == 0
                          ? Center(child: Text('No works found.'))
                          : GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // عدد الأعمدة
                                childAspectRatio:
                                    1.5, // نسبة العرض إلى الارتفاع
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
                                    color: Colors.orange[800], // لون الخلفية
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'المنشور ${index + 1}',
                                            style: TextStyle(
                                              color: Colors.white, // لون النص
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          // يمكنك إضافة صورة هنا إذا كانت متاحة
                                          // Image.network(workDoc['imageURL']), // مثال على صورة
                                        ],
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
            ),
    );
  }
}
