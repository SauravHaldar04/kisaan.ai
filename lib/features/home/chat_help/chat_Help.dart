import 'package:flutter/material.dart';
import 'package:nfc3_overload_oblivion/features/home/chat_help/chat_Help2.dart';
// Import the ChatHelp2 screen

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay for 3 seconds and then navigate to ChatHelp2 screen
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const chatHelp2()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // You can customize your splash screen UI here
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Help'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              child: Icon(
                Icons.chat,
                size: 50,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Chat Help',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(), // Add circular progress indicator
          ],
        ),
      ),
    );
  }
}
