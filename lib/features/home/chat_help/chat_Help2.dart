import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:http/http.dart' as http;
import 'package:nfc3_overload_oblivion/secrets/secrets.dart';

class ChatHelp2 extends StatefulWidget {
  const ChatHelp2({super.key});

  @override
  State<ChatHelp2> createState() => _ChatHelp2State();
}

class _ChatHelp2State extends State<ChatHelp2> {
  ChatUser myself = ChatUser(id: '1', firstName: 'Shlok');
  ChatUser bot = ChatUser(id: '2', firstName: 'Chanakya');

  List<ChatMessage> allMessages = [];
  List<ChatUser> typing = [];
  final cohereUrl = 'https://api.cohere.ai/v1/generate';
  final header = {
    "Content-Type": "application/json",
    "Authorization": "Bearer $cohereApiKey2"
  };

  // Keywords related to agriculture
  List<String> agricultureKeywords = [
    'agriculture',
    'farming',
    'crops',
    'irrigation',
    'pesticides',
    'soil',
    'fertilizer',
    'harvest',
    'seeds',
    'livestock',
    'horticulture',
    'agronomy',
    'agro',
    'agri',
    'tractor',
    'farm',
    'planting',
    'yield',
    'plant'
  ];

  bool isAgricultureRelated(String message) {
    // Check if any agriculture-related keywords are in the message
    for (var keyword in agricultureKeywords) {
      if (message.toLowerCase().contains(keyword)) {
        return true;
      }
    }
    return false;
  }

  getdata(ChatMessage m) async {
    typing.add(bot);
    allMessages.insert(0, m);

    setState(() {});

    if (isAgricultureRelated(m.text)) {
      // Build the conversation context
      String conversationContext = '';
      for (var message in allMessages.reversed) {
        conversationContext += '${message.user.firstName}: ${message.text}\n';
      }

      var data = {
        "model": "command-xlarge-nightly",
        "prompt": conversationContext,
        "max_tokens": 200,
        "temperature": 0.7,
      };

      await http
          .post(Uri.parse(cohereUrl), headers: header, body: jsonEncode(data))
          .then((value) {
        if (value.statusCode == 200) {
          var result = jsonDecode(value.body);
          print(result['generations'][0]['text']);

          ChatMessage m1 = ChatMessage(
              text: result['generations'][0]['text'].trim(),
              user: bot,
              createdAt: DateTime.now());
          allMessages.insert(0, m1);
          setState(() {});
        } else {
          print("error occurred: ${value.body}");
        }
      }).catchError((e) {
        print("Exception: $e");
      });
    } else {
      // Respond with a predefined message if the prompt is not agriculture-related
      ChatMessage m1 = ChatMessage(
          text: "Sorry, I can only assist with agriculture-related queries.",
          user: bot,
          createdAt: DateTime.now());
      allMessages.insert(0, m1);
      setState(() {});
    }

    typing.remove(bot);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chanakya Krushi Sahay',
          style: TextStyle(
            fontFamily: 'Outfit',
            fontWeight: FontWeight.bold,
          ),
        ),
        // Uncomment this if you want a back button
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back_ios),
        //   onPressed: () {
        //     Navigator.pushReplacement(
        //       context,
        //       MaterialPageRoute(builder: (context) => const HomePage()),
        //     );
        //   },
        // ),
      ),
      body: Stack(
        children: [
          DashChat(
            typingUsers: typing,
            currentUser: myself,
            onSend: (ChatMessage m) {
              getdata(m);
            },
            messages: allMessages,
          ),
        ],
      ),
    );
  }
}
