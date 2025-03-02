import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Notifications_Screen.dart';
import '../help_section.dart';
import '../category_details.dart';
import '../details_page.dart';

// ============== شاشة الملف الشخصي للمستخدم (UserProfileScreen) ==============
class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  String _userName = 'اسم المستخدم';
  String _language = 'العربية';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('حسابي', style: TextStyle(color: Colors.black)),
        backgroundColor: const Color.fromARGB(255, 254, 249, 241),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // صورة البروفايل
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/user_avatar.png'),
            ),
            SizedBox(height: 16),
            // زر تعديل الاسم
            TextButton(
              onPressed: () => _showEditNameDialog(),
              child: Text(
                'Edit Name',
                style: TextStyle(fontSize: 18, color: Colors.deepOrange),
              ),
            ),
            SizedBox(height: 24),

            // إعدادات الحساب
            ListTile(
              leading: Icon(Icons.settings, color: Colors.black),
              title: Text('معلومات الحساب'),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // يمكنك فتح صفحة أخرى تعرض معلومات تفصيلية
                // أو إبقاءه فارغاً حالياً
              },
            ),
            Divider(),

            // تفعيل الإشعارات
            SwitchListTile(
              title: Text('Show notifications'),
              value: _notificationsEnabled,
              onChanged: (bool value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
              activeColor: Colors.deepOrange,
            ),
            Divider(),

            // تفعيل الوضع الليلي (مثال)
            SwitchListTile(
              title: Text('الوضع الليلي'),
              value: _darkModeEnabled,
              onChanged: (bool value) {
                setState(() {
                  _darkModeEnabled = value;
                });
              },
              activeColor: Colors.deepOrange,
            ),
            Divider(),

            // تغيير اللغة
            ListTile(
              leading: Icon(Icons.language, color: Colors.black),
              title: Text('اللغة'),
              trailing: DropdownButton<String>(
                value: _language,
                items: <String>['العربية', 'English'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    if (newValue != null) {
                      _language = newValue;
                    }
                  });
                },
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

  void _showEditNameDialog() {
    final TextEditingController _nameController =
        TextEditingController(text: _userName);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('تعديل الاسم'),
          content: TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'اسم المستخدم'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('إلغاء'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _userName = _nameController.text;
                });
                Navigator.of(context).pop();
              },
              child: Text('حفظ'),
            ),
          ],
        );
      },
    );
  }
}

// ============== نقطة البداية في التطبيق ==============
void main() {
  runApp(MyApp());
}

// ============== التطبيق الرئيسي (MyApp) ==============
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Image.asset(
          'assets/logochatbot.png',
          height: 40,
        ),
      ),
    );
  }
}

// ============== الشاشة الرئيسية (HomeScreen) ==============
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1;

  final List<Map<String, String>> categories = [
    {'title': 'حداد', 'image': 'assets/hdad.png'},
    {'title': 'سباك', 'image': 'assets/spak.png'},
    {'title': 'ميكانيكي', 'image': 'assets/mek.png'},
    {'title': 'نجار', 'image': 'assets/najar.png'},
    {'title': 'بليط', 'image': 'assets/blet.png'},
    {'title': 'عامِلات منزلية', 'image': 'assets/clean.png'},
    {'title': 'دهّين', 'image': 'assets/dhen.png'},
    {'title': 'كهربائي', 'image': 'assets/kk.png'},
    {'title': 'عمال نقل', 'image': 'assets/nakel.png'},
    {'title': 'عمال صيانة', 'image': 'assets/siana.png'},
    {'title': 'عمال بناء', 'image': 'assets/banaa.png'},
  ];

  final Color backgroundColor =
      const Color.fromARGB(255, 254, 249, 241).withOpacity(0.8);

  final List<String> banners = [
    'assets/banner1.jpg',
    'assets/banner2.jpg',
    'assets/banner3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/logo2.png', height: 40),
        backgroundColor: const Color.fromARGB(255, 254, 249, 241),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationsScreen()),
              );
            },
          ),
        ],
      ),
      body: Container(
        color: backgroundColor,
        child: Column(
          children: [
            // Banner Section with Carousel
            BannerCarousel(banners: banners),
            // Expanded content with scrolling
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Categories Section
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1,
                      ),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            // فتح صفحة تفاصيل الفئة عند النقر
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CategoryDetails(
                                  title: categories[index]['title']!,
                                  imagePath: categories[index]['image']!,
                                ),
                              ),
                            );
                          },
                          child: buildContainer(
                            categories[index]['title']!,
                            categories[index]['image']!,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromARGB(255, 254, 249, 241),
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.black54,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          // التعديل هنا: الانتقال لصفحة الحساب الشخصي
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserProfileScreen()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HelpSection()),
            );
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'حسابي',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help_outline),
            label: 'المساعدة',
          ),
        ],
      ),
      floatingActionButton: AnimatedBotIcon(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget buildContainer(String title, String imagePath) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 254, 249, 241),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath, width: 60, height: 60),
          SizedBox(height: 8),
          Text(title, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

// ============== BannerCarousel ==============
class BannerCarousel extends StatefulWidget {
  final List<String> banners;

  BannerCarousel({required this.banners});

  @override
  _BannerCarouselState createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < widget.banners.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: SizedBox(
        height: 150,
        child: PageView.builder(
          controller: _pageController,
          itemCount: widget.banners.length,
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                widget.banners[index],
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            );
          },
        ),
      ),
    );
  }
}

// ============== أيقونة الـ ChatBot العائمة ==============
class AnimatedBotIcon extends StatefulWidget {
  const AnimatedBotIcon({super.key});

  @override
  _AnimatedBotIconState createState() => _AnimatedBotIconState();
}

class _AnimatedBotIconState extends State<AnimatedBotIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.0, end: 10.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SanaatyBotScreen()),
              );
            },
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: Image.asset(
              'assets/chatbot.png',
              fit: BoxFit.cover,
              height: 40,
              width: 40,
            ),
          ),
        );
      },
    );
  }
}

// ============== شاشة الـ ChatBot ==============
class SanaatyBotScreen extends StatefulWidget {
  @override
  State<SanaatyBotScreen> createState() => _SanaatyBotScreenState();
}

class _SanaatyBotScreenState extends State<SanaatyBotScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  bool _isLoading = false;

  static const String apiKey =
      "AIzaSyApVfeRvr75btO6rEy0XoJ6OYA7IM6_vd0"; // استبدل بمفتاح API الصحيح
  static const String apiUrl =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$apiKey";

  final Map<String, List<String>> faqKeywords = {
    "تطبيق صنايعي هو منصة إلكترونية تجمع بين أصحاب الأعمال في مجال البناء والمقاولات والباحثين عن معدات ومواد بناء.":
        ["فكرة تطبيق صنايعي"],
    "أصحاب ورش البناء، الصنايعية، مزودو المعدات الثقيلة، والمشترين المهتمين بالتجديد والبناء.":
        ["الفئة المستهدفة"],
    "التسجيل وإدارة الحسابات، الإعلانات والقوائم، البحث والتصفية، نظام التواصل الداخلي، التقييم والمراجعات، أنظمة الدفع، ولوحة تحكم للإدارة.":
        ["ميزات التطبيق"],
    "لوجود أي مشكلة، يرجى الاتصال على 0791522102.": ["مشكلة"],
  };

  String? getAnswer(String userInput) {
    for (var entry in faqKeywords.entries) {
      for (var keyword in entry.value) {
        if (userInput.contains(keyword)) {
          return entry.key;
        }
      }
    }
    return null;
  }

  Future<void> handleUserInput(String userInput) async {
    setState(() {
      _messages.add({"sender": "user", "text": userInput});
    });

    String? answer = getAnswer(userInput);
    if (answer != null) {
      setState(() {
        _messages.add({"sender": "bot", "text": answer});
      });
    } else {
      await callGeminiApi(userInput);
    }
  }

  Future<void> callGeminiApi(String userInput) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {"text": userInput}
              ]
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        String responseText = data['candidates']?[0]['content']['parts']?[0]
                ['text'] ??
            "لم يتم العثور على إجابة.";

        setState(() {
          _messages.add({"sender": "bot", "text": responseText});
        });
      } else {
        setState(() {
          _messages.add({
            "sender": "bot",
            "text":
                "فشل في تحميل البيانات: ${response.statusCode} - ${response.reasonPhrase}"
          });
        });
      }
    } catch (e) {
      setState(() {
        _messages.add({"sender": "bot", "text": "خطأ: $e"});
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sanaaty Bot', style: TextStyle(color: Colors.black)),
        backgroundColor: const Color.fromARGB(255, 254, 249, 241),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        color: const Color.fromARGB(255, 254, 249, 241),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  final isUser = message['sender'] == 'user';
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 8.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: isUser
                          ? Colors.lightBlueAccent.withOpacity(0.2)
                          : Colors.greenAccent.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      children: [
                        if (isUser)
                          const Icon(Icons.person, color: Colors.blue)
                        else
                          Image.asset(
                            'assets/chatbot.png',
                            height: 60,
                            width: 60,
                          ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: Text(
                            message['text'] ?? '',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            if (_isLoading) const CircularProgressIndicator(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          decoration: const InputDecoration(
                            labelText: 'اكتب رسالتك...',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send, color: Colors.deepOrange),
                        onPressed: () {
                          final userInput = _controller.text;
                          if (userInput.isNotEmpty) {
                            handleUserInput(userInput);
                            _controller.clear();
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: faqKeywords.entries.expand((entry) {
                      return entry.value.map((question) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepOrange,
                            foregroundColor:
                                const Color.fromARGB(255, 254, 249, 241),
                          ),
                          onPressed: () {
                            _controller.text = question;
                          },
                          child: Text(question),
                        );
                      });
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============== صفحة تفاصيل الفئة (CategoryDetails) ==============
class CategoryDetails extends StatelessWidget {
  final String title;
  final String imagePath;

  CategoryDetails({required this.title, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: TextStyle(color: Colors.black)),
        backgroundColor: const Color.fromARGB(255, 254, 249, 241),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
          ),
          itemCount: 20,
          itemBuilder: (context, index) {
            return ShopCard();
          },
        ),
      ),
    );
  }
}

// ============== بطاقة متجر (ShopCard) ==============
class ShopCard extends StatefulWidget {
  @override
  _ShopCardState createState() => _ShopCardState();
}

class _ShopCardState extends State<ShopCard> {
  bool isFavorite = false;
  int favoriteCount = 0;

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
      if (isFavorite) {
        favoriteCount++;
      } else {
        favoriteCount--;
      }
    });
  }

  void openWhatsApp() async {
    const phoneNumber = "+962790615563";
    final url = "https://wa.me/$phoneNumber";

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw "لا يمكن فتح WhatsApp";
    }
  }

  void showDescription(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("الوصف"),
          content: Text("هذا هو وصف العنصر."),
          actions: [
            TextButton(
              child: Text("إغلاق"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDescription(context),
      child: Card(
        elevation: 4,
        child: Column(
          children: [
            Expanded(
              child: Image.asset(
                'assets/shop1_1.png',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.black,
                  ),
                  onPressed: toggleFavorite,
                ),
                Text("$favoriteCount"),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.whatsapp, color: Colors.green),
                  onPressed: openWhatsApp,
                ),
                IconButton(
                  icon: Icon(Icons.call),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('اتصال'),
                        content: Text('0791523759'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('إغلاق'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
