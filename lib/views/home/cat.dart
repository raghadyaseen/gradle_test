import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gradle_test/views/home/upload_w.dart' show UploadWork;

class FetchDataPage extends StatefulWidget {
  @override
  _FetchDataPageState createState() => _FetchDataPageState();
}

class _FetchDataPageState extends State<FetchDataPage> {
  List<DocumentSnapshot> documents = [];
  List<DocumentSnapshot> filteredDocuments = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('cat').get();

      setState(() {
        documents = snapshot.docs;
        filteredDocuments = documents; // Initialize filtered documents
      });
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  void updateSearch(String query) {
    setState(() {
      searchQuery = query;
      filteredDocuments = documents.where((doc) {
        return (doc['name'] as String)
            .toLowerCase()
            .contains(searchQuery.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // نفس لون الخلفية
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: Image.asset('assets/logo2.png', height: 40),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.grey[100], // نفس لون الخلفية
        child: Column(
          children: [
            // نص "اختر القسم المناسب لإضافة الإعلان"
            Padding(
              padding:
                  const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
              child: Text(
                'اختر القسم المناسب لإضافة الإعلان',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange[900],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            // مربع البحث
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: updateSearch,
                decoration: InputDecoration(
                  hintText: 'ابحث في القسم',
                  prefixIcon: Icon(Icons.search, color: Colors.orange[800]),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.orange[800]!),
                  ),
                ),
              ),
            ),
            Expanded(
              child: filteredDocuments.isEmpty
                  ? Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.orange[800]!),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredDocuments.length,
                      itemBuilder: (context, index) {
                        var doc = filteredDocuments[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(15),
                              onTap: () {
                                String cid = doc['cid'] ?? '';
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UploadWork(cid: cid),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        doc['name'] ?? 'No data',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.orange[900],
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.orange[800],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
