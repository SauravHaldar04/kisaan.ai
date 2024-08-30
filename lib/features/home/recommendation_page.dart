import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nfc3_overload_oblivion/common/global/app_pallete.dart';
import 'package:http/http.dart' as http;
import 'package:nfc3_overload_oblivion/common/global/flask_string.dart';
import 'package:nfc3_overload_oblivion/secrets/secrets.dart';

class RecommendationPage extends StatefulWidget {
  const RecommendationPage({super.key});

  @override
  State<RecommendationPage> createState() => _RecommendationPageState();
}

class _RecommendationPageState extends State<RecommendationPage> {
  List recommendations = [];
  var responseData = {};
  String landArea = "Unkown";
  String irrigationMethod = 'Unknown';
  String reportDisease = 'Unknown';
  String soilType = 'Unknown';
  String nitrogenRange = 'Unknown';
  String phosphorusRange = 'Unknown';
  String pHRange = 'Unknown';
  String potassiumRange = 'Unknown';
  bool isLoading = false;

  Future<void> fetchData(String userId) async {
    // Get data from users collection
    final usersSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    final userData = usersSnapshot.data();

    // Get data from current user's crops collection
    final cropsSnapshot = await FirebaseFirestore.instance
        .collection('crops')
        .where('userId', isEqualTo: userId)
        .get();

    final cropsData = cropsSnapshot.docs.map((doc) => doc.data()).toList();

    // Get data from soil_reports collection where userId is equal to current user id
    final soilReportsSnapshot = await FirebaseFirestore.instance
        .collection('soil_reports')
        .where('userId', isEqualTo: userId)
        .get();
    final soilReportsData =
        soilReportsSnapshot.docs.map((doc) => doc.data()).toList();

    // Handle null values in cropsData and soilReportsData
    final cropData = cropsData.isNotEmpty ? cropsData[0] : null;
    final soilReportData =
        soilReportsData.isNotEmpty ? soilReportsData[0] : null;

    // Assign values using null-aware operator and null coalescing operator
    setState(() {
      landArea = cropData?['landArea'] ?? "";
      irrigationMethod = userData?['irrigationMethod'] ?? 'Unknown';
      reportDisease = cropData?['reportDisease'] ?? 'Unknown';
      soilType = soilReportData?['soilType'] ?? 'Unknown';
      nitrogenRange = soilReportData?['nitrogenRange'] ?? 'Unknown';
      phosphorusRange = soilReportData?['phosphorusRange'] ?? 'Unknown';
      pHRange = soilReportData?['pHRange'] ?? 'Unknown';
      potassiumRange = soilReportData?['potassiumRange'] ?? 'Unknown';
    });

    // Do something with the fetched data
    // ...

    // Example: Print the fetched data
    print('User Data: $userData');
    print('Crops Data: $cropsData');
    print('Soil Reports Data: $soilReportsData');
    print('Land Area: $landArea');
    print('Irrigation Method: $irrigationMethod');
    print('Report Disease: $reportDisease');
    print('Soil Type: $soilType');
    print('Nitrogen Range: $nitrogenRange');
    print('Phosphorus Range: $phosphorusRange');
    print('pH Range: $pHRange');
    print('Potassium Range: $potassiumRange');
  }

  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      final res = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/forecast?q=${placemarks[0].administrativeArea}&APPID=$OpenWeatherApiKey'),
      );
      final data = jsonDecode(res.body);
      if (data['cod'] != '200') {
        throw 'An unexpected error occurred';
      }
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  List<Map<String, dynamic>> extractDailyForecasts(Map<String, dynamic> data) {
    List<dynamic> forecastList = data['list'];
    Map<String, Map<String, dynamic>> dailyForecasts = {};

    for (var forecast in forecastList) {
      DateTime date = DateTime.parse(forecast['dt_txt']);
      String formattedDate = DateFormat('yyyy-MM-dd').format(date);

      if (!dailyForecasts.containsKey(formattedDate)) {
        dailyForecasts[formattedDate] = forecast;
      }
    }

    return dailyForecasts.values.toList();
  }

  void getRecommendations() async {
    try {
      setState(() {
        isLoading = true;
      });
      final response = await http.post(
        Uri.parse('$url/answer_query'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(<String, dynamic>{
          'soil_type': soilType,
          'soil_info': {
            '- Nitrogen (N)': nitrogenRange,
            '- Phosphorous (P)': phosphorusRange,
            '- Potassium (K)': potassiumRange,
            '- pH': pHRange,
          },
          'land_size': landArea,
          'irrigation_methods': irrigationMethod,
          'climate': extractDailyForecasts(await getCurrentWeather()),
        }),
      );
setState(() {
  responseData = json.decode(response.body);
});
      
      final answer = responseData['answer'];
      final irrigationSteps = json.decode(answer)['Irrigation Steps'];
      final fertilizers = json.decode(answer)['fertilizers'];
      final waterNeeded = json.decode(answer)['Water needed'];
      final otherSuggestions = json.decode(answer)['Other suggestions'];

      print('Irrigation Steps: $irrigationSteps');
      print('Fertilizers: $fertilizers');
      print('Water Needed: $waterNeeded');
      print('Other Suggestions: $otherSuggestions');

      setState(() {
        recommendations = [
          'Irrigation Steps: $irrigationSteps',
          'Fertilizers: $fertilizers',
          'Water Needed: $waterNeeded',
          'Other Suggestions: $otherSuggestions',
        ];
        print(recommendations.length);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e);
    }
  }

  Position? position;
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      showAboutDialog(
          context: context,
          applicationName: 'Location services are disabled.',
          applicationVersion: 'Please enable location services to continue.',
          children: [Text('Please enable location services to continue.')]);
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  List<Placemark> placemarks = [];

  void positionDetermination() async {
    position = await _determinePosition();
    print(position);

    placemarks =
        await placemarkFromCoordinates(position!.latitude, position!.longitude);
    print(placemarks);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      positionDetermination();
    });
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (recommendations.isEmpty)
              const Text(
                'Get Personalized Recommendations',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: AppPallete.primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
            if (recommendations.isEmpty) const SizedBox(height: 20.0),
            if (recommendations.isEmpty)
              const Text(
                'Based on your crop and soil data, click the button below to receive tailored recommendations to boost your yield and improve soil health.',
                style: TextStyle(fontSize: 18.0, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
            if (recommendations.isEmpty) const SizedBox(height: 40.0),
            if (recommendations.isEmpty)
              ElevatedButton(
                onPressed: () async {
                  await fetchData(FirebaseAuth.instance.currentUser!.uid)
                      .then((val) {
                    getRecommendations();
                  });
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
            const SizedBox(height: 20.0),
            if (isLoading && recommendations.isEmpty)
              Center(child: CircularProgressIndicator()),
            if(responseData.isNotEmpty)
              Text(responseData.toString(),
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
              )
          ],
        ),
      ),
    );
  }
}
