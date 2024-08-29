import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:nfc3_overload_oblivion/common/global/app_pallete.dart';
import 'package:nfc3_overload_oblivion/features/home/detailed_report_page.dart';

class SoilReportPage extends StatefulWidget {
  @override
  _SoilReportPageState createState() => _SoilReportPageState();
}

class _SoilReportPageState extends State<SoilReportPage> {
  bool _imageUploaded = false; // Flag to track image upload

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Soil Report',
          style: TextStyle(
            fontFamily: 'Outfit',
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SoilReportHistory()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image upload section
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
              child: Container(
                width: double.infinity,
                constraints: BoxConstraints(
                  maxWidth: 500.0,
                ),
                decoration: BoxDecoration(
                  color: AppPallete.secondaryBackground,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: AppPallete.alternate,
                    width: 2.0,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(
                        Icons.add_a_photo_rounded,
                        color: AppPallete.primaryColor,
                        size: 32.0,
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
                        child: Text(
                          'Upload Image for analysis',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Outfit',
                            color: AppPallete.primaryColor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),
            if (_imageUploaded) // Only show the button if an image is uploaded
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 12.0),
                child: FFButtonWidget(
                  onPressed: () {
                    print('Button pressed ...');
                  },
                  text: 'Analyze Crop',
                  icon: Icon(
                    Icons.analytics_sharp,
                    size: 30.0,
                  ),
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: 54.0,
                    padding: EdgeInsets.all(0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: AppPallete.primaryColor,
                    textStyle: TextStyle(
                      color: AppPallete.secondaryBackground,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                    elevation: 4.0,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
            SizedBox(height: 24),
            // Placeholder for reports
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                'Reports will be displayed here',
                style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: 'Outfit',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
