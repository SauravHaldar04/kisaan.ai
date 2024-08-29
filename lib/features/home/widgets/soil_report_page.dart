import 'package:flutter/material.dart';

class SoilReportCard extends StatelessWidget {
  final String soilType;
  final String cropImageUrl;
  final VoidCallback onTap;

  const SoilReportCard({
    Key? key,
    required this.soilType,
    required this.cropImageUrl,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                cropImageUrl,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 12.0),
              Text(
                soilType,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
