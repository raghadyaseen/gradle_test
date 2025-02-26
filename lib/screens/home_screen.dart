import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sanaaty Bot',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
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
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.call_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        color: backgroundColor,
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                decoration: InputDecoration(
                  hintText: '...ابحث في صنعيتي',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            // Expanded content with scrolling
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Banner Section with Carousel
                    BannerCarousel(banners: banners),
                    // Categories Section
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // 3 containers per row
                        childAspectRatio: 1, // Square shape
                      ),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
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
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, color: Colors.grey.shade600),
            activeIcon: Icon(Icons.home_filled, color: Colors.orange),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline, color: Colors.grey.shade600),
            activeIcon: Icon(Icons.chat_bubble, color: Color(0xFF0084FF)),
            label: 'الدردشة',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.4),
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child:
                  const Icon(Icons.add_rounded, color: Colors.white, size: 30),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined, color: Colors.grey.shade600),
            activeIcon: Stack(
              children: [
                const Icon(Icons.dashboard_rounded, color: Colors.orange),
                Positioned(
                  top: 0,
                  left: 0,
                  child: Icon(Icons.square, color: Colors.blue, size: 10),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child:
                      const Icon(Icons.square, color: Colors.orange, size: 10),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child:
                      const Icon(Icons.square, color: Colors.purple, size: 10),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Icon(Icons.square, color: Colors.red, size: 10),
                ),
              ],
            ),
            label: 'إعلاناتي',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline, color: Colors.grey.shade600),
            activeIcon: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Icon(Icons.person_rounded, color: Colors.grey.shade300),
            ),
            label: 'حسابي',
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
          itemCount: 20, // 20 عنصر في الشبكة
          itemBuilder: (context, index) {
            return ShopCard();
          },
        ),
      ),
    );
  }
}

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
    const url = "https://wa.me/"; // ضع هنا رقم الهاتف إن أردت مباشرة
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
                  onPressed:
                      openWhatsApp, // استبدل هذا بالدالة التي ترغب بتنفيذها
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
