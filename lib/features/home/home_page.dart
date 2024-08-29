import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nfc3_overload_oblivion/common/global/app_pallete.dart';
import 'package:nfc3_overload_oblivion/common/global/placemark.dart';
import 'package:nfc3_overload_oblivion/features/home/agriculture_dashboard/agriculture_dashboard_widget.dart';
import 'package:nfc3_overload_oblivion/features/home/weather_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;

  List<Widget> pages = [
    // Scaffold(
    //   body: Text('Home'),
    // ),
    AgricultureDashboardWidget(),
    Scaffold(
      body: Center(
        child: Text('Crop Reports'),
      ),
    ),
    Scaffold(
      body: Center(
        child: Text('Soil Reports'),
      ),
    ),
    WeatherScreen()
  ];

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
    positionDetermination();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentPage,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        unselectedItemColor: const Color.fromARGB(255, 223, 217, 217),
        selectedFontSize: 10,
        unselectedFontSize: 10,
        iconSize: 35,
        selectedItemColor: AppPallete.primaryColor,
        onTap: (value) {
          setState(() {
            currentPage = value;
          });
        },
        currentIndex: currentPage,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Container(child: Icon(Icons.home)), label: 'Home'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.grass), label: 'Crop Reports3'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.spa_outlined), label: 'Soil Report'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.cloud), label: 'Weather'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
