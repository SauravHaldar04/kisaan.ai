import 'package:flutter/material.dart';
import 'package:nfc3_overload_oblivion/features/home/widgets/mcrop_report.dart';
import 'package:nfc3_overload_oblivion/features/home/widgets/report/crop_report_widget.dart';

class CropCardWidget2 extends StatelessWidget {
  final String cropName;

  final String imageUrl;
  final String cropDescription;
  final String cropDisease;

  CropCardWidget2({
    required this.cropName,
    required this.imageUrl,
    required this.cropDescription,
    required this.cropDisease,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CropDetailPage(
              cropName: cropName,
              imageUrl: imageUrl,
              cropDescription: cropDescription,
              cropDisease: cropDisease,
            ),
          ),
        );
      },
      child: Container(
        width: 230,
        height: 250,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              color: Color(0x34090F13),
              offset: Offset(0.0, 2),
            )
          ],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 140,
              decoration: BoxDecoration(
                color: Color(0xFF81E1D7),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    cropName,
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      color: Color(0xFF0F1113),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
