import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Assuming you're using Firestore for storing reports
import 'package:nfc3_overload_oblivion/features/home/widgets/detailed_report_widget.dart';
import 'package:nfc3_overload_oblivion/features/home/widgets/soil_report_page.dart';

// Import the SoilReportCard widget
import 'detailed_report_page.dart'; // Import the DetailedReportPage widget

class SoilReportHistory extends StatelessWidget {
  const SoilReportHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Soil Report History'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('soil_reports').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No reports found.'));
          }

          final reports = snapshot.data!.docs;
          return ListView.builder(
            itemCount: reports.length,
            itemBuilder: (context, index) {
              final report = reports[index].data() as Map<String, dynamic>;
              return SoilReportCard(
                soilType: report['soilType'],
                cropImageUrl: report['cropImageUrl'],
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailedReportPage(
                        soilType: report['soilType'],
                        nitrogenRange: report['nitrogenRange'],
                        phosphorusRange: report['phosphorusRange'],
                        potassiumRange: report['potassiumRange'],
                        pHRange: report['pHRange'],
                        cropImageUrl: report['cropImageUrl'],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:nfc3_overload_oblivion/features/home/widgets/detailed_report_widget.dart';
// import 'package:nfc3_overload_oblivion/features/home/widgets/soil_report_page.dart';
// // Import the SoilReportCard widget
// import 'detailed_report_page.dart'; // Import the DetailedReportPage widget

// class SoilReportHistory extends StatelessWidget {
//   SoilReportHistory({Key? key}) : super(key: key);

//   // Sample Data for Testing
//   final List<Map<String, dynamic>> sampleReports = [
//     {
//       'soilType': 'Loamy Soil',
//       'cropImageUrl': 'https://via.placeholder.com/150', // Placeholder image
//       'nitrogenRange': '10-20 mg/kg',
//       'phosphorusRange': '5-15 mg/kg',
//       'potassiumRange': '100-150 mg/kg',
//       'pHRange': '6.5-7.5',
//     },
//     {
//       'soilType': 'Clay Soil',
//       'cropImageUrl': 'https://via.placeholder.com/150', // Placeholder image
//       'nitrogenRange': '15-25 mg/kg',
//       'phosphorusRange': '10-20 mg/kg',
//       'potassiumRange': '120-160 mg/kg',
//       'pHRange': '7.0-8.0',
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Soil Report History',
//             style: TextStyle(
//               color: Colors.black,
//               fontWeight: FontWeight.bold,
//               fontSize: 24,
//               fontFamily: 'Outfit',
//             )),
//         centerTitle: true,
//       ),
//       body: ListView.builder(
//         itemCount: sampleReports.length,
//         itemBuilder: (context, index) {
//           final report = sampleReports[index];
//           return SoilReportCard(
//             soilType: report['soilType'],
//             cropImageUrl: report['cropImageUrl'],
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => DetailedReportPage(
//                     soilType: report['soilType'],
//                     nitrogenRange: report['nitrogenRange'],
//                     phosphorusRange: report['phosphorusRange'],
//                     potassiumRange: report['potassiumRange'],
//                     pHRange: report['pHRange'],
//                     cropImageUrl: report['cropImageUrl'],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
