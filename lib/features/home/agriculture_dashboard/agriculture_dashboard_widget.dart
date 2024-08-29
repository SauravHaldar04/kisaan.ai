import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:nfc3_overload_oblivion/common/global/app_pallete.dart';
import 'package:nfc3_overload_oblivion/features/home/agriculture_dashboard/agriculture_dashboard_model.dart';

// import '/flutter_flow/flutter_flow_animations.dart';
// import '/flutter_flow/flutter_flow_icon_button.dart';
// import '/flutter_flow/flutter_flow_theme.dart';
// import '/flutter_flow/flutter_flow_util.dart';
// import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nfc3_overload_oblivion/features/home/widgets/bell_icon.dart';
import 'package:nfc3_overload_oblivion/features/home/widgets/crop_card_widget.dart';
import 'package:provider/provider.dart';

class AgricultureDashboardWidget extends StatefulWidget {
  const AgricultureDashboardWidget({super.key});

  @override
  State<AgricultureDashboardWidget> createState() =>
      _AgricultureDashboardWidgetState();
}

class _AgricultureDashboardWidgetState extends State<AgricultureDashboardWidget>
    with TickerProviderStateMixin {
  late AgricultureDashboardModel _model;
  List<Map<String, dynamic>> crops = [];
  TextEditingController cropNameController = TextEditingController();
  TextEditingController landAreaController = TextEditingController();
  void _addCrop(String cropName, String landArea) {
    setState(() {
      crops.add({
        'cropName': cropName,
        'landArea': landArea,
        'imageUrl':
            'https://unsplash.com/photos/an-american-flag-on-top-of-a-building-yH-91E4c5_4', // Placeholder image URL, replace with actual images
      });
    });
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AgricultureDashboardModel());

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => setState(() {}));
    animationsMap.addAll({
      'containerOnPageLoadAnimation1': AnimationInfo(
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
            begin: Offset(30.0, 0.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
      'containerOnPageLoadAnimation2': AnimationInfo(
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
            begin: Offset(50.0, 0.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
      'containerOnPageLoadAnimation3': AnimationInfo(
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
            begin: Offset(0.0, 30.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
      'containerOnPageLoadAnimation4': AnimationInfo(
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
            begin: Offset(0.0, 40.0),
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
        backgroundColor: Color(0xFFF1F5F8),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 44, 16, 12),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          color: Color(0xFF827AE1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(2),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: Image.network(
                                'https://images.unsplash.com/photo-1573496799652-408c2ac9fe98?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mzh8fHVzZXJ8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Max Rosco',
                                style: TextStyle(
                                  fontFamily: 'Outfit',
                                  color: Color(0xFF0F1113),
                                  fontSize: 18,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                child: Text(
                                  'Good morning Max!',
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF57636C),
                                    fontSize: 14,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    NotificationToggleButton(),
                  ],
                ),
              ),
              //This is the code for adding crops
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 12, 0, 0),
                    child: Text(
                      'Your crops',
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        color: AppPallete.primaryText,
                        fontSize: 20,
                        letterSpacing: 0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Add Crop'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    labelText: 'Crop Name',
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: AppPallete.secondaryText,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: AppPallete.primaryColor,
                                      ),
                                    ),
                                  ),
                                  items: ['Crop 1', 'Crop 2', 'Crop 3']
                                      .map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    cropNameController.text = newValue!;
                                  },
                                ),
                                SizedBox(height: 16),
                                TextField(
                                  controller: landAreaController,
                                  decoration: InputDecoration(
                                    labelText: 'Land Area (in meter²)',
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: AppPallete.secondaryText,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: AppPallete.primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                child: Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text('Add'),
                                onPressed: () {
                                  _addCrop(
                                    cropNameController.text,
                                    landAreaController.text,
                                  );

                                  // Add logic to handle adding the crop
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                  color: Color(0xFFF1F5F8),
                ),
                child: crops.isEmpty
                    ? Center(
                        child: Text(
                          'No crops added yet. Tap "+" to add your first crop.',
                          style: TextStyle(
                            fontFamily: 'Outfit',
                            color: Color(0xFF57636C),
                            fontSize: 16,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: crops.length,
                        itemBuilder: (context, index) {
                          final crop = crops[index];
                          return Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 12, 12, 12),
                            child: CropCardWidget(
                              cropName: crop['cropName']!,
                              landArea: crop['landArea']!,
                              imageUrl: crop['imageUrl']!,
                            ),
                          );
                        },
                      ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 12, 0, 0),
                child: Text(
                  'My Tasks',
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    color: Color(0xFF0F1113),
                    fontSize: 20,
                    letterSpacing: 0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                child: Container(
                  width: double.infinity,
                  height: 400,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 6,
                        color: Color(0x1B090F13),
                        offset: Offset(
                          0.0,
                          -2,
                        ),
                      )
                    ],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment(0, 0),
                          child: TabBar(
                            isScrollable: true,
                            labelColor: Color(0xFF827AE1),
                            unselectedLabelColor: Color(0xFF57636C),
                            labelStyle: TextStyle(
                              fontFamily: 'Outfit',
                              color: Color(0xFF0F1113),
                              fontSize: 14,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w500,
                            ),
                            unselectedLabelStyle: TextStyle(),
                            indicatorColor: Color(0xFF827AE1),
                            indicatorWeight: 2,
                            tabs: [
                              Tab(
                                text: 'Today',
                              ),
                              Tab(
                                text: 'Completed',
                              ),
                            ],
                            controller: _model.tabBarController,
                            onTap: (i) async {
                              [() async {}, () async {}][i]();
                            },
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: _model.tabBarController,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 12, 16, 12),
                                child: ListView(
                                  padding: EdgeInsets.zero,
                                  primary: false,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 12),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          //TODO: Add navigation to the screen
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(
                                              color: Color(0xFFE0E3E7),
                                              width: 2,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(12),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Design Template Screens',
                                                  style: TextStyle(
                                                    fontFamily: 'Outfit',
                                                    color: Color(0xFF0F1113),
                                                    fontSize: 20,
                                                    letterSpacing: 0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 4, 0, 0),
                                                  child: Text(
                                                    'Create template screen for task todo app.',
                                                    style: TextStyle(
                                                      fontFamily: 'Outfit',
                                                      color: Color(0xFF57636C),
                                                      fontSize: 14,
                                                      letterSpacing: 0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                                Divider(
                                                  height: 24,
                                                  thickness: 1,
                                                  color: Color(0xFFE0E3E7),
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Due',
                                                      style: TextStyle(
                                                        fontFamily: 'Outfit',
                                                        color:
                                                            Color(0xFF0F1113),
                                                        fontSize: 14,
                                                        letterSpacing: 0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    8, 0, 0, 0),
                                                        child: Text(
                                                          'Tuesday, 10:00am',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Outfit',
                                                            color: Color(
                                                                0xFF827AE1),
                                                            fontSize: 14,
                                                            letterSpacing: 0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 100,
                                                      height: 32,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFF81E1D7),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(32),
                                                      ),
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0, 0),
                                                      child: Text(
                                                        'Done',
                                                        style: TextStyle(
                                                          fontFamily: 'Outfit',
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          letterSpacing: 0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ).animateOnPageLoad(animationsMap[
                                          'containerOnPageLoadAnimation3']!),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: Color(0xFFE0E3E7),
                                          width: 2,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(12),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Theme Collection',
                                              style: TextStyle(
                                                fontFamily: 'Outfit',
                                                color: Color(0xFF0F1113),
                                                fontSize: 20,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 4, 0, 0),
                                              child: Text(
                                                'Create themes for use by our users.',
                                                style: TextStyle(
                                                  fontFamily: 'Outfit',
                                                  color: Color(0xFF57636C),
                                                  fontSize: 14,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            Divider(
                                              height: 24,
                                              thickness: 1,
                                              color: Color(0xFFE0E3E7),
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Due',
                                                  style: TextStyle(
                                                    fontFamily: 'Outfit',
                                                    color: Color(0xFF0F1113),
                                                    fontSize: 14,
                                                    letterSpacing: 0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                8, 0, 0, 0),
                                                    child: Text(
                                                      'Tuesday, 10:00am',
                                                      style: TextStyle(
                                                        fontFamily: 'Outfit',
                                                        color:
                                                            Color(0xFF827AE1),
                                                        fontSize: 14,
                                                        letterSpacing: 0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: 100,
                                                  height: 32,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFF81E1D7),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            32),
                                                  ),
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0, 0),
                                                  child: Text(
                                                    'Done',
                                                    style: TextStyle(
                                                      fontFamily: 'Outfit',
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      letterSpacing: 0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ).animateOnPageLoad(animationsMap[
                                        'containerOnPageLoadAnimation4']!),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 12, 16, 12),
                                child: ListView(
                                  padding: EdgeInsets.zero,
                                  primary: false,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 12),
                                      child: Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFF1F5F8),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                            color: Color(0xFFE0E3E7),
                                            width: 2,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(12),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Design Template Screens',
                                                style: TextStyle(
                                                  fontFamily: 'Outfit',
                                                  color: Color(0xFF0F1113),
                                                  fontSize: 20,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.normal,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 4, 0, 0),
                                                child: Text(
                                                  'Create template screen for task todo app.',
                                                  style: TextStyle(
                                                    fontFamily: 'Outfit',
                                                    color: Color(0xFF57636C),
                                                    fontSize: 14,
                                                    letterSpacing: 0,
                                                    fontWeight: FontWeight.w500,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                  ),
                                                ),
                                              ),
                                              Divider(
                                                height: 24,
                                                thickness: 1,
                                                color: Color(0xFFE0E3E7),
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Completed',
                                                    style: TextStyle(
                                                      fontFamily: 'Outfit',
                                                      color: Color(0xFF0F1113),
                                                      fontSize: 14,
                                                      letterSpacing: 0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  8, 0, 0, 0),
                                                      child: Text(
                                                        'Tuesday, 10:00am',
                                                        style: TextStyle(
                                                          fontFamily: 'Outfit',
                                                          color:
                                                              Color(0xFF827AE1),
                                                          fontSize: 14,
                                                          letterSpacing: 0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 100,
                                                    height: 32,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              32),
                                                    ),
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0, 0),
                                                    child: Text(
                                                      'Complete',
                                                      style: TextStyle(
                                                        fontFamily: 'Outfit',
                                                        color:
                                                            Color(0xFF0F1113),
                                                        fontSize: 14,
                                                        letterSpacing: 0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF1F5F8),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: Color(0xFFE0E3E7),
                                          width: 2,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(12),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Design Template Screens',
                                              style: TextStyle(
                                                fontFamily: 'Outfit',
                                                color: Color(0xFF0F1113),
                                                fontSize: 20,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.normal,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 4, 0, 0),
                                              child: Text(
                                                'Create template screen for task todo app.',
                                                style: TextStyle(
                                                  fontFamily: 'Outfit',
                                                  color: Color(0xFF57636C),
                                                  fontSize: 14,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.w500,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                ),
                                              ),
                                            ),
                                            Divider(
                                              height: 24,
                                              thickness: 1,
                                              color: Color(0xFFE0E3E7),
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Completed',
                                                  style: TextStyle(
                                                    fontFamily: 'Outfit',
                                                    color: Color(0xFF0F1113),
                                                    fontSize: 14,
                                                    letterSpacing: 0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                8, 0, 0, 0),
                                                    child: Text(
                                                      'Tuesday, 10:00am',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Plus Jakarta Sans',
                                                        color:
                                                            Color(0xFF827AE1),
                                                        fontSize: 14,
                                                        letterSpacing: 0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: 100,
                                                  height: 32,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            32),
                                                  ),
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0, 0),
                                                  child: Text(
                                                    'Complete',
                                                    style: TextStyle(
                                                      fontFamily: 'Outfit',
                                                      color: Color(0xFF0F1113),
                                                      fontSize: 14,
                                                      letterSpacing: 0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
