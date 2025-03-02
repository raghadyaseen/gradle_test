import 'dart:convert';

import 'package:flutter/material.dart';

class HelpSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('قسم المساعدة', style: TextStyle(color: Colors.black)),
            Image.asset('assets/logo2.png', height: 30),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 254, 249, 241),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        color: const Color.fromARGB(255, 254, 249, 241),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  labelText: 'ابحث',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildListTile(
                      context, 'إدارة الحسابات', AccountManagement()),
                  _buildListTile(context, 'إدارة الإعلانات', AdManagement()),
                  _buildListTile(
                      context, 'الدفع والشراء', PaymentAndPurchasing()),
                  _buildListTile(
                      context, 'الأمان والحماية', SecurityAndSafety()),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // فتح الشات بوت عند النقر
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatBotScreen()),
          );
        },
        child: Icon(Icons.chat),
        backgroundColor: Colors.deepOrange,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildListTile(BuildContext context, String title, Widget page) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        title: Center(child: Text(title)),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
      ),
    );
  }
}

class ChatBotScreen extends StatefulWidget {
  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  bool _isLoading = false;

  static const String apiKey = "YOUR_API_KEY"; // استبدل بمفتاح API الصحيح
  static const String apiUrl =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$apiKey";

  final Map<String, String> faqAnswers = {
    // أسئلة إدارة الحسابات
    "كيف يمكنني تسجيل حساب جديد على صنعتي؟":
        "يمكنك تسجيل حساب جديد بالنقر على زر التسجيل واتباع التعليمات المطلوبة.",
    "لقد نسيت كلمة السر الخاصة بي. كيف بإمكاني الدخول لحسابي مرة أخرى؟":
        "يمكنك استعادة كلمة المرور بالنقر على 'نسيت كلمة المرور' واتباع التعليمات.",
    "ما هي الخيارات لتوثيق حسابي؟":
        "يمكنك توثيق حسابك عبر البريد الإلكتروني أو رقم الهاتف.",
    "هل بإمكاني تسجيل أكثر من حساب واحد على صنعتي؟":
        "نعم، يمكنك تسجيل أكثر من حساب باستخدام بريد إلكتروني مختلف.",
    // أسئلة إدارة الإعلانات
    "لماذا تم اشتراط إضافة سعر صحيح من قبل أي معلن قبل نشر أي إعلان؟":
        "لتسهيل عملية البيع والشراء وضمان الجدية في التعامل.",
    "هل علي تسجيل حساب حتى أعلن على صنعت؟":
        "نعم، يجب عليك تسجيل حساب لنشر الإعلانات.",
    "كيف بإمكاني زيادة عدد مشاهدات إعلاني؟":
        "يمكنك تمييز إعلانك أو تجديده لزيادة عدد المشاهدات.",
    // أسئلة الدفع والشراء
    "كيف بإمكاني إتمام عملية الدفع لصنعتي؟":
        "يمكنك الدفع باستخدام البطاقات الائتمانية أو المحافظ الإلكترونية.",
    "كيف بإمكاني شحن رصيد حسابي على صنعتي؟":
        "يمكنك شحن رصيدك عبر البطاقات الائتمانية أو عبر الوكلاء المعتمدين.",
    // أسئلة الأمان والحماية
    "ما الذي يقوم به صنعت للكشف عن وإزالة المخادعين؟":
        "نحن نستخدم تقنيات متقدمة لمراقبة وإزالة المستخدمين المخادعين.",
    "أعتقد أنني كنت عرضة لعملية خداع. ما الذي بإمكاني عمله الآن؟":
        "يرجى التواصل مع قسم الدعم على الرقم 0791522102 لتقديم شكوى.",
  };

  get http => null;

  Future<void> handleUserInput(String userInput) async {
    setState(() {
      _messages.add({"sender": "user", "text": userInput});
    });

    String? answer = faqAnswers[userInput];
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
        title: const Text('الشات بوت', style: TextStyle(color: Colors.black)),
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
                          child: SelectableText(
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
              child: Row(
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
            ),
          ],
        ),
      ),
    );
  }
}

// باقي الصفحات...

class AccountManagement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildPage(context, 'إدارة الحسابات', '''
التسجيل والدخول:
- كيف يمكنني تسجيل حساب جديد على صنعتي؟
- لقد نسيت كلمة السر الخاصة بي. كيف بإمكاني الدخول لحسابي مرة أخرى؟
- ما هي الخيارات لتوثيق حسابي؟
- ماذا علي أن أعمل إذا لم استلم كلمة السر لمرة واحدة (OTP) عن طريق الرسالة النصية أو على الواتساب أو على فايبر عند تسجيل الحساب؟
- هل بإمكاني تسجيل أكثر من حساب واحد على صنعتي؟
- ما هي خطوات اللازمة لحل مشكلة توثيق رقم الهاتف بصنعتي؟

حسابي:
- كيف يمكنني تغيير اسم الحساب على صنعتي؟
- كيف يمكنني تغيير رقم الموبايل الخاص بحسابي على صنعتي؟
- كيف يمكنني تغيير عنوان البريد الالكتروني الخاص بحسابي على صنعتي؟
- هل بإمكاني إخفاء رقم الموبايل الخاص بحسابي حتى لا يتمكن المستخدمون الآخرون من رؤيته؟
- كيف بإمكاني تغيير إعدادات التنبيهات؟
- كيف بإمكاني تسجيل الخروج من حسابي؟
    ''');
  }
}

class AdManagement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildPage(context, 'إدارة الإعلانات', '''
إدارة الإعلانات:
- إنشاء وإدارة وتمييز الإعلانات، بما في ذلك السعر و شروط المحتوى

الإعلانات والبيع:
- لماذا تم اشتراط إضافة سعر صحيح من قبل أي معلن قبل نشر أي إعلان؟
- هل علي تسجيل حساب حتى أعلن على صنعت؟
- ما هي شروط الإعلان التي يجب علي الالتزام بها؟
- لماذا تم حذف إعلاني؟
- كيف بإمكاني زيادة عدد مشاهدات إعلاني؟
- كم عدد الإعلانات المجانية التي يحق لي نشرها؟
    ''');
  }
}

class PaymentAndPurchasing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildPage(context, 'الدفع والشراء', '''
الدفع والشراء:
- الحركات، الدفعات، الأرصدة والقسائم

الدفع لصنعتي:
- كيف بإمكاني إتمام عملية الدفع لصنعتي لتمييز أو إعادة نشر أي إعلان أو لنشر إعلانات إضافية غير مجانية؟
- كيف بإمكاني شحن رصيد حسابي على صنعتي؟
- كيف بإمكاني شحن رصيد الإعلانات، أو رصيد التمييز أو رصيد إعادة النشر على حسابي على صنعتي؟
- حاولت إتمام عملية الدفع لصنعت لتمييز أو إعادة نشر أي إعلان أو لنشر إعلانات إضافية غير مجانية، لكن العملية لم تنجح. ما السبب؟
- اشتريت قسيمة من بائع معتمد لصنعتي. كيف يمكنني استخدامها؟
- عندي قسيمة خصم. كيف يمكنني استخدامها؟
    ''');
  }
}

class SecurityAndSafety extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildPage(context, 'الأمان والحماية', '''
الأمان والحماية:
- حماية الحساب، تجنب الاحتيال، والإبلاغ عن المشاكل

الأمن والأمان:
- ما الذي يقوم به صنعت للكشف عن وإزالة المخادعين والمحتالين من على المنصة؟
- أعتقد أنني كنت عرضة لعملية خداع أو احتيال. ما الذي بإمكاني عمله الآن؟
- ماذا لو أنا مستخدم خارج دول صنعت؟
- بصفتي معلناً، كيف بإمكاني استخدام صنعت بشكل آمن ومضمون؟
- بصفتي مشترياً، كيف بإمكاني استخدام صنعت بشكل آمن ومضمون؟
- كيف يمكنني تقييم تجربتي مع البائعين لكي يستفيد منها المستخدمون الآخرون على صنعت؟
    ''');
  }
}

Widget _buildPage(BuildContext context, String title, String content) {
  return Scaffold(
    backgroundColor: const Color.fromARGB(255, 254, 249, 241),
    appBar: AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(color: Colors.black)),
          Image.asset('assets/logo2.png', height: 30),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 254, 249, 241),
      elevation: 0,
      centerTitle: true,
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: SelectableText(
          content,
          textAlign: TextAlign.right,
          style: TextStyle(fontSize: 16),
        ),
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChatBotScreen()),
        );
      },
      child: Icon(Icons.chat),
      backgroundColor: Colors.deepOrange,
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
  );
}
