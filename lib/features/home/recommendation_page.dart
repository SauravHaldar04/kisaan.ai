import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RecommendationPage extends StatefulWidget {
  const RecommendationPage({super.key});

  @override
  State<RecommendationPage> createState() => _RecommendationPageState();
}

class _RecommendationPageState extends State<RecommendationPage> {
  String result = '';
  bool loading = false;

  Future<void> getDataAndSendRequest() async {
    setState(() {
      loading = true;
    });

    try {
      // Fetching data from Firestore collections
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      // final cropsDoc = await FirebaseFirestore.instance
      //     .collection('crops')
      //     .where(field)
      //     .get();
      final soilDoc = await FirebaseFirestore.instance
          .collection('soil_reports')
          .doc('SOIL_REPORT_ID')
          .get();

      // Extract data
      final irrigationMethods = userDoc['irrigation_methods'];
      final landSize = userDoc['land_size'];
      // final cropDisease = cropsDoc['crop_disease'];
      // final cropName = cropsDoc['crop_name'];
      final soilType = soilDoc['soil_type'];
      final soilInfo = soilDoc['soil_info'];
      final climate = soilDoc['climate'];

      // Create the payload
      final requestBody = jsonEncode({
        'irrigation_methods': irrigationMethods,
        'land_size': landSize,
        // 'crop_disease': cropDisease,
        // 'crop_name': cropName,
        'soil_type': soilType,
        'soil_info': soilInfo,
        'climate': climate,
      });

      // Send POST request
      final response = await http.post(
        Uri.parse('https://your-api-url.com/answer_query'),
        headers: {'Content-Type': 'application/json'},
        body: requestBody,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        setState(() {
          result = data['answer'];
        });
      } else {
        setState(() {
          result = 'Failed to get recommendations.';
        });
      }
    } catch (e) {
      setState(() {
        result = 'Error: $e';
      });
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  List<Widget> parseRecommendations(String recommendations) {
    final List<Widget> widgets = [];
    final parsedData = jsonDecode(recommendations);

    parsedData.forEach((heading, description) {
      widgets.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          heading,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
      ));
      widgets.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Text(
          description.join(', '), // Join the list of descriptions with commas
          style: const TextStyle(fontSize: 16, color: Colors.black),
        ),
      ));
    });

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personalized Recommendations'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Get Personalized Recommendations',
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Based on your crop and soil data, click the button below to receive tailored recommendations to boost your yield and improve soil health.',
              style: TextStyle(fontSize: 18.0, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40.0),
            ElevatedButton(
              onPressed: () {
                getDataAndSendRequest();
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    horizontal: 40.0, vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                backgroundColor: Colors.green,
              ),
              child: const Text(
                'Get Recommendations',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 40.0),
            loading
                ? const CircularProgressIndicator()
                : result.isNotEmpty
                    ? Expanded(
                        child: ListView(
                          children: parseRecommendations(result),
                        ),
                      )
                    : Container(),
          ],
        ),
      ),
    );
  }
}
