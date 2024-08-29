import 'package:flutter/material.dart';
import 'package:nfc3_overload_oblivion/common/global/app_pallete.dart';

class DetailedReportPage extends StatelessWidget {
  final String soilType;
  final String nitrogenRange;
  final String phosphorusRange;
  final String potassiumRange;
  final String pHRange;
  final String cropImageUrl;

  const DetailedReportPage({
    Key? key,
    required this.soilType,
    required this.nitrogenRange,
    required this.phosphorusRange,
    required this.potassiumRange,
    required this.pHRange,
    required this.cropImageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detailed Soil Report'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image section with rounded corners
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0),
              ),
              child: Image.network(
                cropImageUrl,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 24.0),

            // Soil report details in a beautiful card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Soil Type: $soilType',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                          color: Colors.black87,
                          fontFamily: 'Outfit',
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildSoilInfoTile(
                              'Nitrogen', nitrogenRange, Icons.grass),
                          _buildSoilInfoTile(
                              'Phosphorus', phosphorusRange, Icons.science),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildSoilInfoTile(
                              'Potassium', potassiumRange, Icons.terrain),
                          _buildSoilInfoTile('pH', pHRange, Icons.water_drop),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }

  // Helper method to build individual soil info tiles
  Widget _buildSoilInfoTile(String label, String value, IconData icon) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 32, color: AppPallete.primaryColor),
          const SizedBox(height: 8.0),
          Text(
            label,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
