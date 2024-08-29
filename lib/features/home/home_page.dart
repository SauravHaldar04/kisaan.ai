import 'package:flutter/material.dart';
import 'package:nfc3_overload_oblivion/common/global/app_pallete.dart';
import 'package:nfc3_overload_oblivion/features/home/agriculture_dashboard/agriculture_dashboard_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 1;

  List<Widget> pages = [
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
    Scaffold(
      body: Center(
        child: Text('Weather'),
      ),
    ),
  ];

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
              icon: Icon(Icons.grass), label: 'Crop Reports'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.spa_outlined), label: 'Soil Reports'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.cloud), label: 'Weather'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
