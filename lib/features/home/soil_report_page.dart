import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:nfc3_overload_oblivion/common/global/app_pallete.dart';
import 'package:nfc3_overload_oblivion/common/global/flask_string.dart';
import 'package:nfc3_overload_oblivion/common/utils/pickimage.dart';
import 'package:nfc3_overload_oblivion/features/home/detailed_report_page.dart';

class SoilReportPage extends StatefulWidget {
  @override
  _SoilReportPageState createState() => _SoilReportPageState();
}

class _SoilReportPageState extends State<SoilReportPage> {
  void saveSoilData(String soilType, String nitrogen, String phosphorus,
      String cropImagePath, String potassium, String pH) async {
    try {
      // Upload image to Firebase Storage
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('crop_images')
          .child(DateTime.now().millisecondsSinceEpoch.toString());
      final uploadTask = storageRef.putFile(File(cropImagePath));
      final snapshot = await uploadTask.whenComplete(() => null);
      final imageUrl = await snapshot.ref.getDownloadURL();

      // Store data in Firestore
      FirebaseFirestore.instance.collection('soil_reports').add({
        'soilType': soilType,
        'nitrogenRange': nitrogen,
        'phosphorusRange': phosphorus,
        'potassiumRange': potassium,
        'pHRange': pH,
        'cropImageUrl': imageUrl,
      }).then((value) {
        print('Soil data saved successfully!');
      }).catchError((error) {
        print('Failed to save soil data: $error');
      });
    } catch (e) {
      print('Error uploading image and saving soil data: $e');
    }
  }

  bool _imageUploaded = false;
  // Flag to track image upload
  String? soilType;
  String? nitrogen;
  String? phosphorus;
  String? potassium;
  String? pH;
  void analyzeSoil() async {
    try {
      if (_image == null) {
        return;
      }
      final response = await http.post(
        Uri.parse('$url/analyze_soil'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(<String, dynamic>{
          'content': base64.encode(await _image!.readAsBytes() as Uint8List)
        }),
      );
      print(json.decode(response.body));
      setState(() {
        soilType = json.decode(response.body)['soil_type'];
        nitrogen = json.decode(response.body)['soil_info']['- Nitrogen (N)'];

        phosphorus =
            json.decode(response.body)['soil_info']['- Phosphorous (P)'];
        potassium = json.decode(response.body)['soil_info']['- Potassium (K)'];
        pH = json.decode(response.body)['soil_info']['- pH'];
        print(soilType);
        print(nitrogen);
        print(phosphorus);
        print(potassium);
        print(pH);
      });
    } catch (e) {
      print(e);
    }
  }

  bool isLoading = false;
  File? _image;
  void pick() async {
    setState(() {
      isLoading = true;
    });
    if (_image != null) {
      _image = null;
      setState(() {
        isLoading = false;
      });
    }
    await pickImage().then((value) => _image = value);
    setState(() {
      isLoading = false;
    });
  }

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
        child: _image != null
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    // Image section with rounded corners
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                      ),
                      child: Image.file(
                        _image!,
                        height: 300,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 24.0),

                    if (soilType == null)
                      isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 24.0, 0.0, 12.0),
                              child: FFButtonWidget(
                                onPressed: () {
                                  analyzeSoil();
                                },
                                text: 'Analyze Soil',
                                icon: Icon(
                                  Icons.analytics_sharp,
                                  size: 30.0,
                                ),
                                options: FFButtonOptions(
                                  width: double.infinity,
                                  height: 54.0,
                                  padding: EdgeInsets.all(0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: AppPallete.primaryColor,
                                  textStyle: TextStyle(
                                    color: AppPallete.secondaryBackground,
                                    fontFamily: 'Outfit',
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
                    // Soil report details in a beautiful card
                    if (soilType != null)
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _buildSoilInfoTile(
                                        'Nitrogen', nitrogen!, Icons.grass),
                                    _buildSoilInfoTile('Phosphorus',
                                        phosphorus!, Icons.science),
                                  ],
                                ),
                                const SizedBox(height: 16.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _buildSoilInfoTile(
                                        'Potassium', potassium!, Icons.terrain),
                                    _buildSoilInfoTile(
                                        'pH', pH!, Icons.water_drop),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(height: 24.0),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 12.0),
                      child: FFButtonWidget(
                        onPressed: () {
                          saveSoilData(soilType!, nitrogen!, phosphorus!,
                              _image!.path, potassium!, pH!);
                        },
                        text: "Save Report",
                        icon: Icon(
                          Icons.analytics_sharp,
                          size: 30.0,
                        ),
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 54.0,
                          padding: EdgeInsets.all(0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: AppPallete.primaryColor,
                          textStyle: TextStyle(
                            color: AppPallete.secondaryBackground,
                            fontFamily: 'Outfit',
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
                  ],
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image upload section
                  GestureDetector(
                    onTap: () async {
                      pick();
                    },
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
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
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 0.0, 0.0),
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
                  ),
                  SizedBox(height: 24),

                  // Placeholder for reports

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            'Reports will be displayed here',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.grey,
                              fontFamily: 'Outfit',
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }

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
