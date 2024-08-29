<<<<<<< HEAD
// import 'package:flutterflow_ui/flutterflow_ui.dart';
// import 'dart:math';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:nfc3_overload_oblivion/common/global/app_pallete.dart';
// import 'package:provider/provider.dart';
=======
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nfc3_overload_oblivion/common/global/app_pallete.dart';
import 'package:nfc3_overload_oblivion/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:nfc3_overload_oblivion/features/home/home_page.dart';
import 'package:provider/provider.dart';
>>>>>>> d1c802bbeba64a91be46b39dc50519ef666ca3f8

// class LoginCopyModel extends FlutterFlowModel<LoginCopyWidget> {
//   ///  State fields for stateful widgets in this page.

//   final unfocusNode = FocusNode();
//   // State field(s) for emailAddress widget.
//   FocusNode? emailAddressFocusNode;
//   TextEditingController? emailAddressTextController;
//   String? Function(BuildContext, String?)? emailAddressTextControllerValidator;
//   // State field(s) for Name widget.
//   FocusNode? nameFocusNode;
//   TextEditingController? nameTextController;
//   String? Function(BuildContext, String?)? nameTextControllerValidator;
//   // State field(s) for Landarea widget.
//   FocusNode? landareaFocusNode;
//   TextEditingController? landareaTextController;
//   String? Function(BuildContext, String?)? landareaTextControllerValidator;
//   // State field(s) for IrrigationMethod widget.
//   FocusNode? irrigationMethodFocusNode;
//   TextEditingController? irrigationMethodTextController;
//   String? Function(BuildContext, String?)?
//       irrigationMethodTextControllerValidator;
//   // State field(s) for password widget.
//   FocusNode? passwordFocusNode;
//   TextEditingController? passwordTextController;
//   late bool passwordVisibility;
//   String? Function(BuildContext, String?)? passwordTextControllerValidator;
//   // State field(s) for confirmPassword widget.
//   FocusNode? confirmPasswordFocusNode;
//   TextEditingController? confirmPasswordTextController;
//   late bool confirmPasswordVisibility;
//   String? Function(BuildContext, String?)?
//       confirmPasswordTextControllerValidator;

//   @override
//   void initState(BuildContext context) {
//     passwordVisibility = false;
//     confirmPasswordVisibility = false;
//   }

//   @override
//   void dispose() {
//     emailAddressFocusNode?.dispose();
//     emailAddressTextController?.dispose();

//     nameFocusNode?.dispose();
//     nameTextController?.dispose();

//     landareaFocusNode?.dispose();
//     landareaTextController?.dispose();

//     irrigationMethodFocusNode?.dispose();
//     irrigationMethodTextController?.dispose();

//     passwordFocusNode?.dispose();
//     passwordTextController?.dispose();

//     confirmPasswordFocusNode?.dispose();
//     confirmPasswordTextController?.dispose();
//   }
// }

// class LoginCopyWidget extends StatefulWidget {
//   const LoginCopyWidget({super.key});

//   @override
//   State<LoginCopyWidget> createState() => _LoginCopyWidgetState();
// }

// class _LoginCopyWidgetState extends State<LoginCopyWidget>
//     with TickerProviderStateMixin {
//   late LoginCopyModel _model;

//   final animationsMap = <String, AnimationInfo>{};

//   @override
//   void initState() {
//     super.initState();
//     _model = createModel(context, () => LoginCopyModel());

//     _model.emailAddressTextController ??= TextEditingController();
//     _model.emailAddressFocusNode ??= FocusNode();

//     _model.nameTextController ??= TextEditingController();
//     _model.nameFocusNode ??= FocusNode();

//     _model.landareaTextController ??= TextEditingController();
//     _model.landareaFocusNode ??= FocusNode();

//     _model.irrigationMethodTextController ??= TextEditingController();
//     _model.irrigationMethodFocusNode ??= FocusNode();

//     _model.passwordTextController ??= TextEditingController();
//     _model.passwordFocusNode ??= FocusNode();

//     _model.confirmPasswordTextController ??= TextEditingController();
//     _model.confirmPasswordFocusNode ??= FocusNode();

//     animationsMap.addAll({
//       'containerOnPageLoadAnimation': AnimationInfo(
//         trigger: AnimationTrigger.onPageLoad,
//         effectsBuilder: () => [
//           VisibilityEffect(duration: 1.ms),
//           FadeEffect(
//             curve: Curves.easeInOut,
//             delay: 0.0.ms,
//             duration: 300.0.ms,
//             begin: 0.0,
//             end: 1.0,
//           ),
//           MoveEffect(
//             curve: Curves.easeInOut,
//             delay: 0.0.ms,
//             duration: 300.0.ms,
//             begin: Offset(0.0, 140.0),
//             end: Offset(0.0, 0.0),
//           ),
//           ScaleEffect(
//             curve: Curves.easeInOut,
//             delay: 0.0.ms,
//             duration: 300.0.ms,
//             begin: Offset(0.9, 1.0),
//             end: Offset(1.0, 1.0),
//           ),
//           TiltEffect(
//             curve: Curves.easeInOut,
//             delay: 0.0.ms,
//             duration: 300.0.ms,
//             begin: Offset(-0.349, 0),
//             end: Offset(0, 0),
//           ),
//         ],
//       ),
//     });
//   }

//   @override
//   void dispose() {
//     _model.dispose();

//     super.dispose();
//   }

<<<<<<< HEAD
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: Scaffold(
//         backgroundColor: const Color(0x101F3C), // Updated color
//         body: Container(
//           height: double.infinity,
//           decoration: BoxDecoration(
//             color: Color(0xFF101F3C), // Updated color
//           ),
//           alignment: AlignmentDirectional(0.0, -1.0),
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(0.0, 70.0, 0.0, 32.0),
//                   child: Container(
//                     width: 200.0,
//                     height: 10.0,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(16.0),
//                       color: const Color(0x101F3C), // Updated color
//                     ),
//                     alignment: AlignmentDirectional(0.0, 0.0),
//                   ),
//                 ),
//                 Text(
//                   'kisaan.ai',
//                   style: TextStyle(
//                     fontSize: 40.0,
//                     color: Colors.white, // Updated color
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(16.0),
//                   child: Container(
//                     width: double.infinity,
//                     constraints: BoxConstraints(
//                       maxWidth: 570.0,
//                     ),
//                     decoration: BoxDecoration(
//                       color: Colors.white, // Updated color
//                       boxShadow: [
//                         BoxShadow(
//                           blurRadius: 4.0,
//                           color: Colors.grey, // Updated color
//                           offset: Offset(
//                             0.0,
//                             2.0,
//                           ),
//                         )
//                       ],
//                       borderRadius: BorderRadius.circular(12.0),
//                     ),
//                     child: Align(
//                       alignment: AlignmentDirectional(0.0, 0.0),
//                       child: Padding(
//                         padding: EdgeInsets.all(32.0),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.max,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Text(
//                               'Welcome',
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 fontFamily: 'Readex Pro',
//                                 fontSize: 24.0,
//                                 color: Color(0xFF101F3C), // Updated color
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsetsDirectional.fromSTEB(
//                                   0.0, 12.0, 0.0, 24.0),
//                               child: Text(
//                                 'Fill out the information below in order to create your account.',
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                   fontFamily: "Readex Pro",
//                                   fontSize: 16.0,
//                                   color: Color(0xFF101F3C), // Updated color
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsetsDirectional.fromSTEB(
//                                   0.0, 0.0, 0.0, 16.0),
//                               child: Container(
//                                 width: double.infinity,
//                                 child: TextFormField(
//                                   controller: _model.emailAddressTextController,
//                                   focusNode: _model.emailAddressFocusNode,
//                                   autofocus: true,
//                                   autofillHints: [AutofillHints.email],
//                                   obscureText: false,
//                                   decoration: InputDecoration(
//                                     labelText: 'Email',
//                                     labelStyle: TextStyle(
//                                       fontSize: 16.0,
//                                       color: Color(0xFF101F3C), // Updated color
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                         color: AppPallete.primaryBackground,
//                                         width: 2.0,
//                                       ),
//                                       borderRadius: BorderRadius.circular(12.0),
//                                     ),
//                                     focusedBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                         color: AppPallete.primaryColor,
//                                       ),
//                                       borderRadius: BorderRadius.circular(12.0),
//                                     ),
//                                     errorBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                           color: AppPallete.alternate),
//                                       borderRadius: BorderRadius.circular(12.0),
//                                     ),
//                                     focusedErrorBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                         color: AppPallete.alternate,
//                                       ),
//                                       borderRadius: BorderRadius.circular(12.0),
//                                     ),
//                                     filled: true,
//                                     fillColor: AppPallete.primaryBackground,
//                                   ),
//                                   style: TextStyle(
//                                     fontSize: 16.0,
//                                     color: Color(0xFF101F3C), // Updated color
//                                     fontFamily: 'Readex Pro',
//                                   ),
//                                   keyboardType: TextInputType.emailAddress,
//                                   validator: _model
//                                       .emailAddressTextControllerValidator
//                                       .asValidator(context),
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsetsDirectional.fromSTEB(
//                                   0.0, 0.0, 0.0, 16.0),
//                               child: Container(
//                                 width: double.infinity,
//                                 child: TextFormField(
//                                   controller: _model.nameTextController,
//                                   focusNode: _model.nameFocusNode,
//                                   autofocus: true,
//                                   autofillHints: [AutofillHints.email],
//                                   obscureText: false,
//                                   decoration: InputDecoration(
//                                     labelText: 'Name',
//                                     labelStyle: TextStyle(
//                                         fontSize: 16.0,
//                                         color: Color(0xFF101F3C),
//                                         fontFamily:
//                                             "Readex Pro" // Updated color
//                                         ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                         color: AppPallete.primaryBackground,
//                                         width: 2.0,
//                                       ),
//                                       borderRadius: BorderRadius.circular(12.0),
//                                     ),
//                                     focusedBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                         color: AppPallete.primaryColor,
//                                         width: 2.0,
//                                       ),
//                                       borderRadius: BorderRadius.circular(12.0),
//                                     ),
//                                     errorBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                         color: AppPallete.alternate,
//                                         width: 2.0,
//                                       ),
//                                       borderRadius: BorderRadius.circular(12.0),
//                                     ),
//                                     focusedErrorBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                         color: AppPallete.alternate,
//                                         width: 2.0,
//                                       ),
//                                       borderRadius: BorderRadius.circular(12.0),
//                                     ),
//                                     filled: true,
//                                     fillColor: AppPallete.primaryBackground,
//                                   ),
//                                   style: TextStyle(
//                                     fontSize: 16.0,
//                                     color: Color(0xFF101F3C),
//                                     fontFamily: 'Readex Pro',
//                                   ),
//                                   keyboardType: TextInputType.emailAddress,
//                                   validator: _model.nameTextControllerValidator
//                                       .asValidator(context),
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsetsDirectional.fromSTEB(
//                                   0.0, 0.0, 0.0, 16.0),
//                               child: Container(
//                                 width: double.infinity,
//                                 child: TextFormField(
//                                   controller: _model.landareaTextController,
//                                   focusNode: _model.landareaFocusNode,
//                                   autofocus: true,
//                                   autofillHints: [AutofillHints.email],
//                                   obscureText: false,
//                                   decoration: InputDecoration(
//                                     labelText: 'Land Area (in acres)',
//                                     labelStyle: TextStyle(
//                                       fontSize: 16.0,
//                                       color: Color(0xFF101F3C),
//                                       fontFamily: 'Readex Pro',
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                         color: AppPallete.primaryBackground,
//                                         width: 2.0,
//                                       ),
//                                       borderRadius: BorderRadius.circular(12.0),
//                                     ),
//                                     focusedBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                         color: AppPallete.primaryColor,
//                                         width: 2.0,
//                                       ),
//                                       borderRadius: BorderRadius.circular(12.0),
//                                     ),
//                                     errorBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                         color: AppPallete.alternate,
//                                         width: 2.0,
//                                       ),
//                                       borderRadius: BorderRadius.circular(12.0),
//                                     ),
//                                     focusedErrorBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                         color: AppPallete.primaryColor,
//                                         width: 2.0,
//                                       ),
//                                       borderRadius: BorderRadius.circular(12.0),
//                                     ),
//                                     filled: true,
//                                     fillColor: AppPallete.primaryBackground,
//                                   ),
//                                   style: TextStyle(
//                                     fontSize: 16.0,
//                                     color: Color(0xFF101F3C),
//                                     fontFamily: 'Readex Pro',
//                                   ),
//                                   keyboardType: TextInputType.number,
//                                   validator: _model
//                                       .landareaTextControllerValidator
//                                       .asValidator(context),
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsetsDirectional.fromSTEB(
//                                   0.0, 0.0, 0.0, 16.0),
//                               child: Container(
//                                 width: double.infinity,
//                                 child: TextFormField(
//                                   controller:
//                                       _model.irrigationMethodTextController,
//                                   focusNode: _model.irrigationMethodFocusNode,
//                                   autofocus: true,
//                                   autofillHints: [AutofillHints.name],
//                                   readOnly: true,
//                                   obscureText: false,
//                                   decoration: InputDecoration(
//                                     labelText: 'Irrigation Methods',
//                                     labelStyle: TextStyle(
//                                       fontSize: 16.0,
//                                       color: Color(0xFF101F3C),
//                                       fontFamily: 'Readex Pro',
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                         color: AppPallete.primaryBackground,
//                                         width: 2.0,
//                                       ),
//                                       borderRadius: BorderRadius.circular(12.0),
//                                     ),
//                                     focusedBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                         color: AppPallete.primaryColor,
//                                         width: 2.0,
//                                       ),
//                                       borderRadius: BorderRadius.circular(12.0),
//                                     ),
//                                     errorBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                         color: AppPallete.alternate,
//                                         width: 2.0,
//                                       ),
//                                       borderRadius: BorderRadius.circular(12.0),
//                                     ),
//                                     focusedErrorBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                         color: AppPallete.alternate,
//                                         width: 2.0,
//                                       ),
//                                       borderRadius: BorderRadius.circular(12.0),
//                                     ),
//                                     filled: true,
//                                     fillColor: AppPallete.primaryBackground,
//                                   ),
//                                   style: TextStyle(
//                                     fontSize: 16.0,
//                                     color: Color(0xFF101F3C),
//                                     fontFamily: 'Readex Pro',
//                                   ),
//                                   keyboardType: TextInputType.number,
//                                   validator: _model
//                                       .irrigationMethodTextControllerValidator
//                                       .asValidator(context),
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsetsDirectional.fromSTEB(
//                                   0.0, 0.0, 0.0, 16.0),
//                               child: Container(
//                                 width: double.infinity,
//                                 child: TextFormField(
//                                   controller: _model.passwordTextController,
//                                   focusNode: _model.passwordFocusNode,
//                                   autofocus: true,
//                                   autofillHints: [AutofillHints.password],
//                                   obscureText: !_model.passwordVisibility,
//                                   decoration: InputDecoration(
//                                     labelText: 'Password',
//                                     labelStyle: TextStyle(
//                                       fontSize: 16.0,
//                                       color: Color(0xFF101F3C),
//                                       fontFamily: 'Readex Pro',
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                           color: AppPallete.primaryBackground),
//                                       borderRadius: BorderRadius.circular(12.0),
//                                     ),
//                                     focusedBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                         color: AppPallete.primaryColor,
//                                         width: 2.0,
//                                       ),
//                                       borderRadius: BorderRadius.circular(12.0),
//                                     ),
//                                     errorBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                         color: AppPallete.alternate,
//                                         width: 2.0,
//                                       ),
//                                       borderRadius: BorderRadius.circular(12.0),
//                                     ),
//                                     focusedErrorBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                         color: AppPallete.alternate,
//                                         width: 2.0,
//                                       ),
//                                       borderRadius: BorderRadius.circular(12.0),
//                                     ),
//                                     filled: true,
//                                     fillColor: AppPallete.primaryBackground,
//                                     suffixIcon: InkWell(
//                                       onTap: () => setState(
//                                         () => _model.passwordVisibility =
//                                             !_model.passwordVisibility,
//                                       ),
//                                       focusNode: FocusNode(skipTraversal: true),
//                                       child: Icon(
//                                         _model.passwordVisibility
//                                             ? Icons.visibility_outlined
//                                             : Icons.visibility_off_outlined,
//                                         color: AppPallete.secondaryText,
//                                         size: 24.0,
//                                       ),
//                                     ),
//                                   ),
//                                   style: TextStyle(
//                                     fontSize: 16.0,
//                                     color: Color(0xFF101F3C),
//                                     fontFamily: 'Readex Pro',
//                                   ),
//                                   validator: _model
//                                       .passwordTextControllerValidator
//                                       .asValidator(context),
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsetsDirectional.fromSTEB(
//                                   0.0, 0.0, 0.0, 16.0),
//                               child: Container(
//                                 width: double.infinity,
//                                 child: TextFormField(
//                                   controller:
//                                       _model.confirmPasswordTextController,
//                                   focusNode: _model.confirmPasswordFocusNode,
//                                   autofocus: true,
//                                   autofillHints: [AutofillHints.password],
//                                   obscureText:
//                                       !_model.confirmPasswordVisibility,
//                                   decoration: InputDecoration(
//                                     labelText: 'Confirm Password',
//                                     labelStyle: TextStyle(
//                                       fontSize: 16.0,
//                                       color: Color(0xFF101F3C),
//                                       fontFamily: 'Readex Pro',
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                         color: AppPallete.primaryBackground,
//                                         width: 2.0,
//                                       ),
//                                       borderRadius: BorderRadius.circular(12.0),
//                                     ),
//                                     focusedBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                         color: AppPallete.primaryColor,
//                                         width: 2.0,
//                                       ),
//                                       borderRadius: BorderRadius.circular(12.0),
//                                     ),
//                                     errorBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                         color: AppPallete.alternate,
//                                         width: 2.0,
//                                       ),
//                                       borderRadius: BorderRadius.circular(12.0),
//                                     ),
//                                     focusedErrorBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                         color: AppPallete.alternate,
//                                         width: 2.0,
//                                       ),
//                                       borderRadius: BorderRadius.circular(12.0),
//                                     ),
//                                     filled: true,
//                                     fillColor: AppPallete.primaryBackground,
//                                     suffixIcon: InkWell(
//                                       onTap: () => setState(
//                                         () => _model.confirmPasswordVisibility =
//                                             !_model.confirmPasswordVisibility,
//                                       ),
//                                       focusNode: FocusNode(skipTraversal: true),
//                                       child: Icon(
//                                         _model.confirmPasswordVisibility
//                                             ? Icons.visibility_outlined
//                                             : Icons.visibility_off_outlined,
//                                         color: AppPallete.secondaryText,
//                                         size: 24.0,
//                                       ),
//                                     ),
//                                   ),
//                                   style: TextStyle(
//                                     fontSize: 16.0,
//                                     color: Color(0xFF101F3C),
//                                     fontFamily: 'Readex Pro',
//                                   ),
//                                   validator: _model
//                                       .confirmPasswordTextControllerValidator
//                                       .asValidator(context),
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsetsDirectional.fromSTEB(
//                                   0.0, 0.0, 0.0, 16.0),
//                               child: FFButtonWidget(
//                                 onPressed: () async {},
//                                 text: 'Sign Up',
//                                 options: FFButtonOptions(
//                                   width: double.infinity,
//                                   height: 44.0,
//                                   padding: EdgeInsetsDirectional.fromSTEB(
//                                       0.0, 0.0, 0.0, 0.0),
//                                   iconPadding: EdgeInsetsDirectional.fromSTEB(
//                                       0.0, 0.0, 0.0, 0.0),
//                                   color: AppPallete.primaryColor,
//                                   textStyle: TextStyle(
//                                     fontSize: 16.0,
//                                     color: AppPallete.primaryBackground,
//                                     fontFamily: 'Readex Pro',
//                                   ),
//                                   elevation: 3.0,
//                                   borderSide: BorderSide(
//                                     color: Colors.transparent,
//                                     width: 1.0,
//                                   ),
//                                   borderRadius: BorderRadius.circular(12.0),
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsetsDirectional.fromSTEB(
//                                   16.0, 0.0, 16.0, 24.0),
//                               child: Text(
//                                 'Or sign in with',
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                   fontSize: 14.0,
//                                   color: Color(0xFF101F3C),
//                                   fontFamily: 'Readex Pro',
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsetsDirectional.fromSTEB(
//                                   0.0, 0.0, 0.0, 16.0),
//                               child: FFButtonWidget(
//                                 onPressed: () async {},
//                                 text: 'Continue with Google',
//                                 icon: FaIcon(
//                                   FontAwesomeIcons.google,
//                                   size: 20.0,
//                                 ),
//                                 options: FFButtonOptions(
//                                   width: double.infinity,
//                                   height: 44.0,
//                                   padding: EdgeInsetsDirectional.fromSTEB(
//                                       0.0, 0.0, 0.0, 0.0),
//                                   iconPadding: EdgeInsetsDirectional.fromSTEB(
//                                       0.0, 0.0, 0.0, 0.0),
//                                   color: AppPallete.secondaryBackground,
//                                   textStyle: TextStyle(
//                                     fontSize: 11.0,
//                                     color: AppPallete.primaryText,
//                                     fontFamily: 'Readex Pro',
//                                   ),
//                                   elevation: 0.0,
//                                   borderSide: BorderSide(
//                                     color: AppPallete.primaryBackground,
//                                     width: 2.0,
//                                   ),
//                                   borderRadius: BorderRadius.circular(12.0),
//                                   hoverColor: AppPallete.primaryBackground,
//                                 ),
//                               ),
//                             ),

//                             // You will have to add an action on this rich text to go to your login page.
//                             Padding(
//                               padding: EdgeInsetsDirectional.fromSTEB(
//                                   0.0, 12.0, 0.0, 12.0),
//                               child: RichText(
//                                 textScaler: MediaQuery.of(context).textScaler,
//                                 text: TextSpan(
//                                   children: [
//                                     TextSpan(
//                                       text: 'Already have an account?  ',
//                                       style: TextStyle(),
//                                     ),
//                                     TextSpan(
//                                       text: 'Sign In',
//                                       style: TextStyle(
//                                         color: AppPallete.primaryColor,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     )
//                                   ],
//                                   style: TextStyle(
//                                     fontSize: 14.0,
//                                     color: Color(0xFF101F3C),
//                                     fontFamily: 'Readex Pro',
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ).animateOnPageLoad(
//                       animationsMap['containerOnPageLoadAnimation']!),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
=======
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0x101F3C), // Updated color
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFF101F3C), // Updated color
          ),
          alignment: AlignmentDirectional(0.0, -1.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 70.0, 0.0, 32.0),
                  child: Container(
                    width: 200.0,
                    height: 10.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: const Color(0x101F3C), // Updated color
                    ),
                    alignment: AlignmentDirectional(0.0, 0.0),
                  ),
                ),
                Text(
                  'kisaan.ai',
                  style: TextStyle(
                    fontSize: 40.0,
                    color: Colors.white, // Updated color
                    fontWeight: FontWeight.bold,
                  ),
                ),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Sign Up Successful'),
                        ),
                      );
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Container(
                        width: double.infinity,
                        constraints: BoxConstraints(
                          maxWidth: 570.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white, // Updated color
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4.0,
                              color: Colors.grey, // Updated color
                              offset: Offset(
                                0.0,
                                2.0,
                              ),
                            )
                          ],
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Padding(
                            padding: EdgeInsets.all(32.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Welcome',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 24.0,
                                    color: Color(0xFF101F3C), // Updated color
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 12.0, 0.0, 24.0),
                                  child: Text(
                                    'Fill out the information below in order to create your account.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: "Readex Pro",
                                      fontSize: 16.0,
                                      color: Color(0xFF101F3C), // Updated color
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 16.0),
                                  child: Container(
                                    width: double.infinity,
                                    child: TextFormField(
                                      controller:
                                          _model.emailAddressTextController,
                                      focusNode: _model.emailAddressFocusNode,
                                      autofocus: true,
                                      autofillHints: [AutofillHints.email],
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'Email',
                                        labelStyle: TextStyle(
                                          fontSize: 16.0,
                                          color: Color(
                                              0xFF101F3C), // Updated color
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppPallete.primaryBackground,
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppPallete.primaryColor,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppPallete.alternate),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppPallete.alternate,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        filled: true,
                                        fillColor: AppPallete.primaryBackground,
                                      ),
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color:
                                            Color(0xFF101F3C), // Updated color
                                        fontFamily: 'Readex Pro',
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                      validator: _model
                                          .emailAddressTextControllerValidator
                                          .asValidator(context),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 16.0),
                                  child: Container(
                                    width: double.infinity,
                                    child: TextFormField(
                                      controller: _model.nameTextController,
                                      focusNode: _model.nameFocusNode,
                                      autofocus: true,
                                      autofillHints: [AutofillHints.email],
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'Name',
                                        labelStyle: TextStyle(
                                            fontSize: 16.0,
                                            color: Color(0xFF101F3C),
                                            fontFamily:
                                                "Readex Pro" // Updated color
                                            ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppPallete.primaryBackground,
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppPallete.primaryColor,
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppPallete.alternate,
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppPallete.alternate,
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        filled: true,
                                        fillColor: AppPallete.primaryBackground,
                                      ),
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Color(0xFF101F3C),
                                        fontFamily: 'Readex Pro',
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                      validator: _model
                                          .nameTextControllerValidator
                                          .asValidator(context),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 16.0),
                                  child: Container(
                                    width: double.infinity,
                                    child: TextFormField(
                                      controller: _model.landareaTextController,
                                      focusNode: _model.landareaFocusNode,
                                      autofocus: true,
                                      autofillHints: [AutofillHints.email],
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'Land Area (in acres)',
                                        labelStyle: TextStyle(
                                          fontSize: 16.0,
                                          color: Color(0xFF101F3C),
                                          fontFamily: 'Readex Pro',
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppPallete.primaryBackground,
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppPallete.primaryColor,
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppPallete.alternate,
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppPallete.primaryColor,
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        filled: true,
                                        fillColor: AppPallete.primaryBackground,
                                      ),
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Color(0xFF101F3C),
                                        fontFamily: 'Readex Pro',
                                      ),
                                      keyboardType: TextInputType.number,
                                      validator: _model
                                          .landareaTextControllerValidator
                                          .asValidator(context),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 16.0),
                                  child: Container(
                                    width: double.infinity,
                                    child: TextFormField(
                                      controller:
                                          _model.irrigationMethodTextController,
                                      focusNode:
                                          _model.irrigationMethodFocusNode,
                                      autofocus: true,
                                      autofillHints: [AutofillHints.name],
                                      readOnly: false,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'Irrigation Methods',
                                        labelStyle: TextStyle(
                                          fontSize: 16.0,
                                          color: Color(0xFF101F3C),
                                          fontFamily: 'Readex Pro',
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppPallete.primaryBackground,
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppPallete.primaryColor,
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppPallete.alternate,
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppPallete.alternate,
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        filled: true,
                                        fillColor: AppPallete.primaryBackground,
                                      ),
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Color(0xFF101F3C),
                                        fontFamily: 'Readex Pro',
                                      ),
                                      keyboardType: TextInputType.number,
                                      validator: _model
                                          .irrigationMethodTextControllerValidator
                                          .asValidator(context),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 16.0),
                                  child: Container(
                                    width: double.infinity,
                                    child: TextFormField(
                                      controller: _model.passwordTextController,
                                      focusNode: _model.passwordFocusNode,
                                      autofocus: true,
                                      autofillHints: [AutofillHints.password],
                                      obscureText: !_model.passwordVisibility,
                                      decoration: InputDecoration(
                                        labelText: 'Password',
                                        labelStyle: TextStyle(
                                          fontSize: 16.0,
                                          color: Color(0xFF101F3C),
                                          fontFamily: 'Readex Pro',
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  AppPallete.primaryBackground),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppPallete.primaryColor,
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppPallete.alternate,
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppPallete.alternate,
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        filled: true,
                                        fillColor: AppPallete.primaryBackground,
                                        suffixIcon: InkWell(
                                          onTap: () => setState(
                                            () => _model.passwordVisibility =
                                                !_model.passwordVisibility,
                                          ),
                                          focusNode:
                                              FocusNode(skipTraversal: true),
                                          child: Icon(
                                            _model.passwordVisibility
                                                ? Icons.visibility_outlined
                                                : Icons.visibility_off_outlined,
                                            color: AppPallete.secondaryText,
                                            size: 24.0,
                                          ),
                                        ),
                                      ),
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Color(0xFF101F3C),
                                        fontFamily: 'Readex Pro',
                                      ),
                                      validator: _model
                                          .passwordTextControllerValidator
                                          .asValidator(context),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 16.0),
                                  child: Container(
                                    width: double.infinity,
                                    child: TextFormField(
                                      controller:
                                          _model.confirmPasswordTextController,
                                      focusNode:
                                          _model.confirmPasswordFocusNode,
                                      autofocus: true,
                                      autofillHints: [AutofillHints.password],
                                      obscureText:
                                          !_model.confirmPasswordVisibility,
                                      decoration: InputDecoration(
                                        labelText: 'Confirm Password',
                                        labelStyle: TextStyle(
                                          fontSize: 16.0,
                                          color: Color(0xFF101F3C),
                                          fontFamily: 'Readex Pro',
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppPallete.primaryBackground,
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppPallete.primaryColor,
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppPallete.alternate,
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppPallete.alternate,
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        filled: true,
                                        fillColor: AppPallete.primaryBackground,
                                        suffixIcon: InkWell(
                                          onTap: () => setState(
                                            () => _model
                                                    .confirmPasswordVisibility =
                                                !_model
                                                    .confirmPasswordVisibility,
                                          ),
                                          focusNode:
                                              FocusNode(skipTraversal: true),
                                          child: Icon(
                                            _model.confirmPasswordVisibility
                                                ? Icons.visibility_outlined
                                                : Icons.visibility_off_outlined,
                                            color: AppPallete.secondaryText,
                                            size: 24.0,
                                          ),
                                        ),
                                      ),
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Color(0xFF101F3C),
                                        fontFamily: 'Readex Pro',
                                      ),
                                      validator: _model
                                          .confirmPasswordTextControllerValidator
                                          .asValidator(context),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 16.0),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      context.read<AuthBloc>().add(AuthSignUp(
                                            _model.emailAddressTextController!
                                                .text,
                                            _model.passwordTextController!.text,
                                            _model.nameTextController!.text,
                                            double.parse(_model
                                                .landareaTextController!.text),
                                            _model
                                                .irrigationMethodTextController!
                                                .text,
                                          ));
                                    },
                                    text: 'Sign Up',
                                    options: FFButtonOptions(
                                      width: double.infinity,
                                      height: 44.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color: AppPallete.primaryColor,
                                      textStyle: TextStyle(
                                        fontSize: 16.0,
                                        color: AppPallete.primaryBackground,
                                        fontFamily: 'Readex Pro',
                                      ),
                                      elevation: 3.0,
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 16.0, 24.0),
                                  child: Text(
                                    'Or sign in with',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Color(0xFF101F3C),
                                      fontFamily: 'Readex Pro',
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 16.0),
                                  child: FFButtonWidget(
                                    onPressed: () async {},
                                    text: 'Continue with Google',
                                    icon: FaIcon(
                                      FontAwesomeIcons.google,
                                      size: 20.0,
                                    ),
                                    options: FFButtonOptions(
                                      width: double.infinity,
                                      height: 44.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color: AppPallete.secondaryBackground,
                                      textStyle: TextStyle(
                                        fontSize: 11.0,
                                        color: AppPallete.primaryText,
                                        fontFamily: 'Readex Pro',
                                      ),
                                      elevation: 0.0,
                                      borderSide: BorderSide(
                                        color: AppPallete.primaryBackground,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                      hoverColor: AppPallete.primaryBackground,
                                    ),
                                  ),
                                ),

                                // You will have to add an action on this rich text to go to your login page.
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 12.0, 0.0, 12.0),
                                  child: RichText(
                                    textScaler:
                                        MediaQuery.of(context).textScaler,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Already have an account?  ',
                                          style: TextStyle(),
                                        ),
                                        TextSpan(
                                          text: 'Sign In',
                                          style: TextStyle(
                                            color: AppPallete.primaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Color(0xFF101F3C),
                                        fontFamily: 'Readex Pro',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ).animateOnPageLoad(
                          animationsMap['containerOnPageLoadAnimation']!),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
>>>>>>> d1c802bbeba64a91be46b39dc50519ef666ca3f8
