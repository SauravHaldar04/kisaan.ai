import 'package:flutter/material.dart';
import 'package:nfc3_overload_oblivion/features/home/widgets/report/crop_report_widget.dart';

class CropCardWidget extends StatelessWidget {
  final String cropName;
  final String landArea;
  final String imageUrl;
  final String cropDescription;

  CropCardWidget({
    required this.cropName,
    required this.landArea,
    required this.imageUrl,
    required this.cropDescription,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ReportWidget(
              cropName: cropName,
              imageUrl: imageUrl,
              cropDescription: cropDescription,
            ),
          ),
        );
      },
      child: Container(
        width: 230,
        height: 50,
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
          mainAxisSize: MainAxisSize.max,
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
                mainAxisSize: MainAxisSize.max,
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
                  Padding(
                    padding: EdgeInsetsDirectional.only(end: 8),
                    child: Text(
                      landArea,
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        color: Color(0xFF0F1113),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
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
