import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nfc3_overload_oblivion/common/global/app_pallete.dart';
import 'package:nfc3_overload_oblivion/common/global/flask_string.dart';
import 'package:nfc3_overload_oblivion/common/utils/pickimage.dart';
import 'package:nfc3_overload_oblivion/features/home/widgets/report/crop_report_model.dart';
import 'package:provider/provider.dart';

class ReportWidget extends StatefulWidget {
  final String cropName;
  final String imageUrl;
  final String cropDescription;
  const ReportWidget(
      {super.key,
      required this.cropName,
      required this.imageUrl,
      required this.cropDescription});

  @override
  State<ReportWidget> createState() => _ReportWidgetState();
}

class _ReportWidgetState extends State<ReportWidget>
    with TickerProviderStateMixin {
  late ReportModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  String? detectedDisease;
  String? diseaseDescription;
  void analyzeImage() async {
    try {
      if (imageFile == null) {
        return;
      }
      final response = await http.post(
        Uri.parse('$url/predict_disease'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(<String, dynamic>{
          'content': base64.encode(await File(imageFile!.path).readAsBytes())
        }),
      );
      print(json.decode(response.body));
    } catch (e) {
      print(e);
    }
  }

  File? imageFile;
  bool isLoading = false;
  void pick() async {
    setState(() {
      isLoading = true;
    });
    if (imageFile != null) {
      imageFile = null;
      setState(() {
        isLoading = false;
      });
    }

    await pickImage().then((value) => imageFile = value);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ReportModel());

    animationsMap.addAll({
      'containerOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: Offset(0.0, 110.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
    });
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: AppPallete.secondaryBackground,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'Crop Report',
            style: TextStyle(
              fontFamily: "Outfit",
              color: AppPallete.primaryText,
              fontSize: 24.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image.network(
                        widget.imageUrl,
                        width: double.infinity,
                        height: 200.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.cropName,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: 'Outfit',
                            color: AppPallete.primaryText,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                          )),
                      Text(
                        widget.cropDescription,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'Outfit',
                          color: AppPallete.primaryText,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ]
                        .divide(SizedBox(height: 10.0))
                        .addToStart(SizedBox(height: 12.0)),
                  ),
                  Padding(
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
                      child: GestureDetector(
                        onTap: () => pick(),
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
                    ).animateOnPageLoad(
                        animationsMap['containerOnPageLoadAnimation']!),
                  ),
                  if (isLoading)
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  if (imageFile != null)
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image.file(
                          imageFile!,
                          width: double.infinity,
                          height: 200.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  if (imageFile != null)
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 12.0),
                      child: FFButtonWidget(
                        onPressed: () {
                          analyzeImage();
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
                  if (imageFile != null)
                    Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                        child: Text(
                          'Analysis Report:',
                          style: TextStyle(
                            fontFamily: 'Outfit',
                            color: AppPallete.primaryText,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                  if (detectedDisease != null)
                    Column(
                      children: [
                        Text('Detected Disease: $detectedDisease',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: 'Outfit',
                              color: AppPallete.primaryText,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            )),
                        Text('Description: $diseaseDescription',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: 'Outfit',
                              color: AppPallete.primaryText,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ))
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
