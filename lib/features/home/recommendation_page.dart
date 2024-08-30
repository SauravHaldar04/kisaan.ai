import 'package:flutter/material.dart';
import 'package:nfc3_overload_oblivion/common/global/app_pallete.dart';

class RecommendationPage extends StatelessWidget {
  const RecommendationPage({super.key});

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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Get Personalized Recommendations',
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: AppPallete.primaryColor,
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
                // Perform POST request to ML model
                // TODO: Implement logic to fetch personalized recommendations
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    horizontal: 40.0, vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                backgroundColor: AppPallete.primaryColor,
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
          ],
        ),
      ),
    );
  }
}
