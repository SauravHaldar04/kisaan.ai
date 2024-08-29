import 'dart:convert';
import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:nfc3_overload_oblivion/Api_keys/secret.dart';
import 'package:nfc3_overload_oblivion/common/global/placemark.dart';
import 'package:nfc3_overload_oblivion/features/home/widgets/additional_info_item.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather Forecast',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: "Outfit",
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final data = snapshot.data!;
          final dailyForecasts = extractDailyForecasts(data);

          final currentTemp = dailyForecasts[0]["main"]["temp"];
          final currentsky = dailyForecasts[0]["weather"][0]["main"];
          final currentHumidity = dailyForecasts[0]['main']['humidity'];
          final currentWindSpeed = dailyForecasts[0]['wind']['speed'];
          final currentWindPressure = dailyForecasts[0]['main']['pressure'];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // main card
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: 8,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  '$currentTemp K',
                                  style: const TextStyle(
                                    fontFamily: 'Outfit',
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Icon(
                                  currentsky == 'Clouds' || currentsky == 'Rain'
                                      ? Icons.cloud
                                      : Icons.sunny,
                                  size: 66,
                                ),
                                const SizedBox(height: 16),
                                Text('$currentsky'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Daily Forecast',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 170, // Adjust height to fit cards
                    child: ListView.builder(
                      itemCount: dailyForecasts.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final forecast = dailyForecasts[index];
                        final date = DateTime.parse(forecast['dt_txt']);
                        final temp = forecast['main']['temp'];
                        final skyCondition = forecast['weather'][0]['main'];

                        return Column(
                          children: [
                            Card(
                              elevation: 5,
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(7.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      DateFormat('EEEE, MMM d').format(date),
                                      style: const TextStyle(
                                        fontFamily: 'Outfit',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Icon(
                                      skyCondition == 'Clouds' ||
                                              skyCondition == 'Rain'
                                          ? Icons.cloud
                                          : Icons.sunny,
                                      size: 48,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      '$temp K',
                                      style: const TextStyle(
                                        fontFamily: 'Outfit',
                                        fontSize: 20,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(skyCondition),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Additional Information',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AdditionalInfoItem(
                        icon: Icons.water_drop,
                        label: 'Humidity',
                        Value: currentHumidity.toString(),
                      ),
                      AdditionalInfoItem(
                        icon: Icons.air,
                        label: 'Wind Speed',
                        Value: currentWindSpeed.toString(),
                      ),
                      AdditionalInfoItem(
                        icon: Icons.beach_access,
                        label: 'Pressure',
                        Value: currentWindPressure.toString(),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
