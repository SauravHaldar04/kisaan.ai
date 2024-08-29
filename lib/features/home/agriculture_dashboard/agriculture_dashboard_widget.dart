import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:nfc3_overload_oblivion/common/error/server_exception.dart';
import 'package:nfc3_overload_oblivion/common/global/app_pallete.dart';
import 'package:nfc3_overload_oblivion/features/auth/data/datasources/auth_remote_datasources.dart';
import 'package:nfc3_overload_oblivion/features/auth/data/models/user_model.dart';
import 'package:nfc3_overload_oblivion/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:nfc3_overload_oblivion/features/auth/domain/repository/auth_repository.dart';
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
import 'package:nfc3_overload_oblivion/init_dependencies.dart';
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
  List<String> cropsList = [
    'Apple',
    'Rice',
    'Corn',
    'Blueberry',
    'Cherry',
    'Garlic',
    'Grape',
    'Orange',
    'Peach',
    'Pepper',
    'Potato',
    'Raspberry',
    'Soyabean',
    'Strawberry',
    'Sugarcane',
    'Tomato',
    'Tea',
    'Cabbage',
    'Ginger',
    'Lemon',
    'Onion',
  ];

  String getCropDescription(String cropName) {
    if (cropName == 'Apple') {
      return 'Apple:\n'
          'Best Harvest/Sowing Time: Apples are best planted in early spring or late winter. Harvest typically occurs in late summer to early autumn.\n'
          'Irrigation Methods: Requires deep watering, especially during dry spells. Use drip irrigation or basin irrigation to ensure consistent moisture.\n'
          'Types of Fertilizers: Use a balanced fertilizer (e.g., NPK 10-10-10) during the growing season. Organic compost and well-rotted manure are beneficial for improving soil fertility.\n'
          'Additional Info: Apples require a cold winter period for dormancy and are best suited for temperate climates. Pruning in winter helps maintain tree shape and fruit quality.';
    } else if (cropName == 'Rice') {
      return 'Rice:\n'
          'Best Harvest/Sowing Time: Sowing usually starts in May-July, with harvesting in November-December. Timing can vary based on the region and variety.\n'
          'Irrigation Methods: Requires flooded fields or continuous flooding. Utilize puddled field methods or controlled irrigation to maintain water levels.\n'
          'Types of Fertilizers: Nitrogen-based fertilizers (e.g., urea), phosphate, and potash are commonly used. Apply fertilizers in stages, typically before planting and during the growing period.\n'
          'Additional Info: Rice grows best in areas with heavy rainfall. Clayey loam soil is preferred due to its water retention properties. Ensure proper field leveling to avoid uneven flooding.';
    } else if (cropName == 'Corn') {
      return 'Corn:\n'
          'Best Harvest/Sowing Time: Sowing should be done in spring after the last frost. Harvest in late summer or early autumn when kernels are firm and full.\n'
          'Irrigation Methods: Requires consistent moisture. Use furrow or drip irrigation systems to maintain adequate soil moisture.\n'
          'Types of Fertilizers: Nitrogen-rich fertilizers, such as urea, and balanced NPK (10-10-10) fertilizers are essential. Side-dress with nitrogen after the plants are 6-8 inches tall.\n'
          'Additional Info: Corn thrives in well-drained loamy soil with a pH of 5.8-7.0. Full sunlight is crucial for optimal growth. Avoid planting corn in the same location for consecutive years to prevent soil-borne diseases.';
    } else if (cropName == 'Blueberry') {
      return 'Blueberry:\n'
          'Best Harvest/Sowing Time: Plant in late autumn or early spring. Harvest typically occurs in mid to late summer when berries are fully ripe.\n'
          'Irrigation Methods: Requires regular watering; use drip irrigation to avoid wetting the foliage and to provide consistent moisture.\n'
          'Types of Fertilizers: Acidic fertilizers such as ammonium sulfate are ideal. Avoid fertilizers with nitrates. Organic matter like pine needles or sawdust can also be used to acidify the soil.\n'
          'Additional Info: Blueberries prefer acidic, well-drained soil with a pH of 4.5-5.5. Mulching helps retain soil moisture and suppress weeds. Pruning older canes to encourage new growth and increase yield.';
    } else if (cropName == 'Cherry') {
      return 'Cherry:\n'
          'Best Harvest/Sowing Time: Plant in early spring. Harvest cherries in late spring or early summer when they have reached full color and are firm.\n'
          'Irrigation Methods: Requires moderate watering; use drip irrigation to provide consistent moisture without waterlogging.\n'
          'Types of Fertilizers: Use balanced fertilizers with an NPK ratio of 16-16-16. Apply compost in early spring to improve soil fertility.\n'
          'Additional Info: Prefers well-drained, sandy loam soil with a pH of 6.0-7.5. Requires chilling hours (cold temperatures) for fruit development. Regular pruning helps maintain tree health and fruit quality.';
    } else if (cropName == 'Garlic') {
      return 'Garlic:\n'
          'Best Harvest/Sowing Time: Plant garlic in the fall (October-November) for a summer harvest. Harvest when the leaves start to yellow and die back, usually in late spring or early summer.\n'
          'Irrigation Methods: Requires moderate watering. Avoid over-watering to prevent bulb rot. Use furrow or drip irrigation for best results.\n'
          'Types of Fertilizers: Organic compost, well-rotted manure, and balanced NPK fertilizers. Avoid high-nitrogen fertilizers, which can promote excessive leaf growth at the expense of bulb development.\n'
          'Additional Info: Garlic prefers well-drained, fertile soil with a pH of 6.0-7.0. Ensure proper spacing between bulbs to allow for optimal bulb growth. Mulching helps to control weeds and retain moisture.';
    } else if (cropName == 'Grape') {
      return 'Grape:\n'
          'Best Harvest/Sowing Time: Plant in early spring. Harvest grapes in late summer to early fall when they are fully ripe and have developed their characteristic color.\n'
          'Irrigation Methods: Requires regular, deep watering; drip irrigation is ideal to provide consistent moisture while avoiding wetting the foliage.\n'
          'Types of Fertilizers: Use balanced fertilizers (NPK 10-10-10) in the spring and summer. Compost and organic matter can improve soil fertility.\n'
          'Additional Info: Grapes grow best in well-drained loamy soil with a pH of 5.5-7.0. Full sunlight is crucial for optimal fruit development. Pruning is essential to improve airflow and fruit quality.';
    } else if (cropName == 'Orange') {
      return 'Orange:\n'
          'Best Harvest/Sowing Time: Plant oranges in spring. Harvest oranges in winter when they are fully colored and firm.\n'
          'Irrigation Methods: Requires moderate watering. Drip or furrow irrigation systems are recommended to maintain soil moisture and avoid over-watering.\n'
          'Types of Fertilizers: Use a balanced fertilizer with an NPK ratio of 10-10-10. Supplement with micronutrients like zinc and magnesium as needed. Apply compost to improve soil structure.\n'
          'Additional Info: Oranges prefer well-drained sandy loam soil with a pH of 5.5-6.5. Ensure proper spacing between trees to promote airflow and reduce disease risk. Regular pruning helps maintain tree health and fruit quality.';
    } else if (cropName == 'Peach') {
      return 'Peach:\n'
          'Best Harvest/Sowing Time: Plant in early spring. Harvest peaches in summer when they are fully ripe and have a fragrant aroma.\n'
          'Irrigation Methods: Requires deep watering; drip irrigation is ideal to provide consistent moisture while avoiding wetting the foliage.\n'
          'Types of Fertilizers: Use balanced fertilizers (NPK 10-10-10) and apply compost in late winter. Adjust fertilizer application based on soil tests.\n'
          'Additional Info: Peaches thrive in well-drained loamy soil with a pH of 6.0-7.0. Require cold winter temperatures for dormancy. Regular pruning helps to shape the tree and enhance fruit quality.';
    } else if (cropName == 'Pepper') {
      return 'Pepper:\n'
          'Best Harvest/Sowing Time: Plant peppers in late spring or early summer. Harvest peppers when they are firm and have reached their full color, usually in late summer or early fall.\n'
          'Irrigation Methods: Requires consistent moisture. Drip or soaker hose irrigation is preferred to keep soil evenly moist and reduce water stress.\n'
          'Types of Fertilizers: Use balanced fertilizers (NPK 10-10-10) or high-potassium fertilizers. Apply compost to improve soil structure and fertility.\n'
          'Additional Info: Peppers grow best in well-drained loamy soil with a pH of 6.0-7.0. Full sunlight is essential for optimal fruit development. Regular pruning and staking can support plant growth and improve yields.';
    } else if (cropName == 'Potato') {
      return 'Potato:\n'
          'Best Harvest/Sowing Time: Plant potatoes in early spring. Harvest in late summer or early autumn when the foliage begins to yellow and die back.\n'
          'Irrigation Methods: Requires consistent moisture. Use furrow or drip irrigation to maintain soil moisture and avoid tuber rot.\n'
          'Types of Fertilizers: Use a balanced NPK fertilizer or one high in potassium and phosphorus. Organic compost and well-rotted manure can also be beneficial.\n'
          'Additional Info: Potatoes prefer well-drained, loose soil with a pH of 5.5-7.0. Avoid planting potatoes in the same location for consecutive years to reduce disease risk. Hilling soil around the plants helps to protect developing tubers from sunlight and pests.';
    } else if (cropName == 'Raspberry') {
      return 'Raspberry:\n'
          'Best Harvest/Sowing Time: Plant in early spring or late autumn. Harvest raspberries in summer or fall, depending on the variety (summer-bearing or fall-bearing).\n'
          'Irrigation Methods: Requires regular watering; use drip irrigation to provide consistent moisture and avoid wetting the foliage.\n'
          'Types of Fertilizers: Use balanced fertilizers (NPK 10-10-10) or those higher in phosphorus. Apply compost or well-rotted manure in early spring.\n'
          'Additional Info: Raspberries prefer well-drained, acidic soil with a pH of 5.5-6.5. Mulching helps to retain soil moisture and control weeds. Pruning is essential to promote new growth and improve fruit yield.';
    } else if (cropName == 'Soyabean') {
      return 'Soyabean:\n'
          'Best Harvest/Sowing Time: Plant soybeans in late spring or early summer. Harvest in late summer or early autumn when pods are dry and firm.\n'
          'Irrigation Methods: Requires moderate watering. Use furrow or drip irrigation systems to maintain consistent moisture.\n'
          'Types of Fertilizers: Use balanced fertilizers (NPK 10-10-10) or those higher in phosphorus. Soybeans also benefit from inoculation with Rhizobium bacteria to enhance nitrogen fixation.\n'
          'Additional Info: Soybeans grow best in well-drained loamy soil with a pH of 6.0-7.0. Ensure proper spacing between plants to reduce competition and promote healthy growth. Rotate crops to manage soil health and prevent diseases.';
    } else if (cropName == 'Strawberry') {
      return 'Strawberry:\n'
          'Best Harvest/Sowing Time: Plant strawberries in early spring or late autumn. Harvest in late spring to early summer when berries are fully red and firm.\n'
          'Irrigation Methods: Requires consistent moisture. Drip irrigation is ideal to avoid wetting the foliage and to provide even moisture.\n'
          'Types of Fertilizers: Use balanced fertilizers (NPK 10-10-10) or those higher in phosphorus. Apply compost to improve soil fertility and structure.\n'
          'Additional Info: Strawberries prefer well-drained, sandy loam soil with a pH of 5.5-6.5. Mulching helps to retain moisture and control weeds. Regularly remove dead leaves and runners to improve plant health and fruit quality.';
    } else if (cropName == 'Sugarcane') {
      return 'Sugarcane:\n'
          'Best Harvest/Sowing Time: Plant sugarcane in early spring. Harvest typically occurs in late autumn or winter when the cane reaches full maturity.\n'
          'Irrigation Methods: Requires consistent, ample moisture. Use furrow or drip irrigation to maintain water levels in the field.\n'
          'Types of Fertilizers: Use high-potassium fertilizers and balanced NPK fertilizers. Organic compost can also improve soil health.\n'
          'Additional Info: Sugarcane thrives in well-drained, fertile soil with a pH of 6.0-7.0. Requires full sunlight and warm temperatures for optimal growth. Regularly check for pests and diseases that can affect yield.';
    } else if (cropName == 'Tomato') {
      return 'Tomato:\n'
          'Best Harvest/Sowing Time: Plant tomatoes in late spring after the danger of frost has passed. Harvest in late summer or early autumn when fruits are fully ripe and firm.\n'
          'Irrigation Methods: Requires regular watering; drip or soaker hose irrigation is preferred to maintain consistent moisture and reduce disease risk.\n'
          'Types of Fertilizers: Use balanced fertilizers (NPK 10-10-10) or those higher in phosphorus. Compost and organic matter are also beneficial.\n'
          'Additional Info: Tomatoes prefer well-drained loamy soil with a pH of 6.0-6.8. Full sunlight is essential for optimal fruit development. Pruning and staking can help manage plant growth and improve yields.';
    } else if (cropName == 'Tea') {
      return 'Tea:\n'
          'Best Harvest/Sowing Time: Plant tea in spring or early summer. Harvest leaves throughout the growing season, usually from late spring to early autumn.\n'
          'Irrigation Methods: Requires regular, consistent watering. Drip irrigation is ideal to maintain soil moisture without waterlogging.\n'
          'Types of Fertilizers: Use balanced fertilizers (NPK 10-10-10) or those higher in potassium. Organic compost can also improve soil health.\n'
          'Additional Info: Tea grows best in well-drained, acidic soil with a pH of 4.5-5.5. Requires warm temperatures and high humidity. Regular pruning helps maintain plant shape and improve leaf quality.';
    } else if (cropName == 'Cabbage') {
      return 'Cabbage:\n'
          'Best Harvest/Sowing Time: Plant cabbage in early spring or late summer. Harvest in late spring or early autumn when heads are firm and well-formed.\n'
          'Irrigation Methods: Requires regular watering; use drip or soaker hose irrigation to maintain soil moisture and prevent diseases.\n'
          'Types of Fertilizers: Use balanced fertilizers (NPK 10-10-10) or those higher in nitrogen. Compost and well-rotted manure are also beneficial.\n'
          'Additional Info: Cabbage prefers well-drained, fertile soil with a pH of 6.0-7.5. Full sunlight is important for optimal growth. Regularly monitor for pests and diseases, and ensure proper spacing to promote healthy development.';
    } else if (cropName == 'Ginger') {
      return 'Ginger:\n'
          'Best Harvest/Sowing Time: Plant ginger in early spring. Harvest in late autumn or early winter when the leaves start to yellow and die back.\n'
          'Irrigation Methods: Requires consistent moisture; use drip irrigation or regular watering to maintain soil humidity.\n'
          'Types of Fertilizers: Use balanced fertilizers (NPK 10-10-10) or high-potassium fertilizers. Organic compost and well-rotted manure are also beneficial.\n'
          'Additional Info: Ginger prefers well-drained, fertile soil with a pH of 5.5-6.5. Requires warm temperatures and high humidity. Provide partial shade to protect from excessive sunlight.';
    } else if (cropName == 'Lemon') {
      return 'Lemon:\n'
          'Best Harvest/Sowing Time: Plant lemons in spring. Harvest lemons when they turn fully yellow and are firm, typically in winter or early spring.\n'
          'Irrigation Methods: Requires regular watering. Use drip irrigation to maintain consistent moisture and avoid over-watering.\n'
          'Types of Fertilizers: Use balanced fertilizers (NPK 10-10-10) or those higher in potassium. Apply compost and organic matter in spring.\n'
          'Additional Info: Lemons thrive in well-drained, sandy loam soil with a pH of 5.5-6.5. Full sunlight is essential for fruit development. Pruning helps maintain tree shape and health.';
    } else if (cropName == 'Onion') {
      return 'Onion:\n'
          'Best Harvest/Sowing Time: Plant onions in early spring or late summer. Harvest when the tops begin to yellow and fall over, usually in late summer.\n'
          'Irrigation Methods: Requires consistent moisture; use drip irrigation or furrow irrigation to maintain soil moisture and avoid bulb rot.\n'
          'Types of Fertilizers: Use balanced fertilizers (NPK 10-10-10) or those higher in potassium. Organic compost can also enhance soil fertility.\n'
          'Additional Info: Onions prefer well-drained, fertile soil with a pH of 6.0-7.0. Ensure proper spacing between bulbs to promote bulb development and prevent diseases.';
    } else {
      return 'Information not available for this crop.';
    }
  }

  String getImageUrlForCrop(String cropName) {
    if (cropName == 'Apple') {
      return 'https://upload.wikimedia.org/wikipedia/commons/1/15/Red_Apple.jpg';
    } else if (cropName == 'Rice') {
      return 'https://images.pexels.com/photos/6129010/pexels-photo-6129010.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260';
    } else if (cropName == 'Corn') {
      return 'https://iadsb.tmgrup.com.tr/48c5ff/0/0/0/0/1732/1104?u=https://idsb.tmgrup.com.tr/2019/01/06/beyond-taste-the-many-health-benefits-of-corn-1546803009016.jpg';
    } else if (cropName == 'Blueberry') {
      return 'https://upload.wikimedia.org/wikipedia/commons/1/15/Blueberries.jpg';
    } else if (cropName == 'Cherry') {
      return 'https://upload.wikimedia.org/wikipedia/commons/b/bb/Cherry_Stella444.jpg';
    } else if (cropName == 'Garlic') {
      return 'https://static.fanpage.it/wp-content/uploads/sites/22/2018/05/istock-531644839.jpg';
    } else if (cropName == 'Grape') {
      return 'https://upload.wikimedia.org/wikipedia/commons/b/bb/Table_grapes_on_white.jpg';
    } else if (cropName == 'Orange') {
      return 'https://upload.wikimedia.org/wikipedia/commons/c/c4/Orange-Fruit-Pieces.jpg';
    } else if (cropName == 'Peach') {
      return 'https://th.bing.com/th/id/R.e09a44d895f926bd6d1068fe16648fed?rik=Lqyko0gxPcO3kg&riu=http%3a%2f%2fblogs.extension.iastate.edu%2fwellness%2ffiles%2f2014%2f08%2fpeach.jpg&ehk=dc6D3rY3FNVyoytf%2b0DaZgyKzAQh17OQReRtFQANWLw%3d&risl=&pid=ImgRaw&r=0';
    } else if (cropName == 'Pepper') {
      return 'https://pepperscale.com/wp-content/uploads/2019/09/Bell-Pepper-Facts.jpg';
    } else if (cropName == 'Potato') {
      return 'https://upload.wikimedia.org/wikipedia/commons/8/8e/Potato_and_cross_section.jpg';
    } else if (cropName == 'Raspberry') {
      return 'https://upload.wikimedia.org/wikipedia/commons/4/46/Raspberries05.jpg';
    } else if (cropName == 'Soyabean') {
      return 'https://www.kitchenkneads.com/wp-content/uploads/2016/06/Soybeans-1000x1000.png';
    } else if (cropName == 'Strawberry') {
      return 'https://upload.wikimedia.org/wikipedia/commons/2/29/PerfectStrawberry.jpg';
    } else if (cropName == 'Sugarcane') {
      return 'https://morningchores.com/wp-content/uploads/2021/06/sugarcane-close.jpg';
    } else if (cropName == 'Tomato') {
      return 'https://upload.wikimedia.org/wikipedia/commons/8/89/Tomato_je.jpg';
    } else if (cropName == 'Tea') {
      return 'https://upload.wikimedia.org/wikipedia/commons/4/47/Tea_leaves.jpg';
    } else if (cropName == 'Cabbage') {
      return 'https://upload.wikimedia.org/wikipedia/commons/c/c7/Cabbage_and_cross_section_on_white.jpg';
    } else if (cropName == 'Ginger') {
      return 'https://upload.wikimedia.org/wikipedia/commons/5/5e/Ginger_Root.jpg';
    } else if (cropName == 'Lemon') {
      return 'https://upload.wikimedia.org/wikipedia/commons/7/71/Lemon.png';
    } else if (cropName == 'Onion') {
      return 'https://upload.wikimedia.org/wikipedia/commons/7/71/Onion.png';
    } else {
      return 'https://upload.wikimedia.org/wikipedia/commons/a/ac/No_image_available.svg'; // Placeholder image
    }
  }

  void _addCrop(String cropName, String landArea) {
    setState(() {
      crops.add({
        'cropName': cropName,
        'landArea': landArea,
        'imageUrl': getImageUrlForCrop(cropName),
      });
    });
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  UserModel? _userModel;

  Future<UserModel?> getCurrentUser() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        print('User is not logged in.');
        return null;
      }

      print('User ID: ${user.uid}');

      final docSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (!docSnapshot.exists) {
        print('User document does not exist.');
        return null;
      }

      return UserModel.fromMap(docSnapshot.data()!);
    } catch (e) {
      if (e is FirebaseException) {
        print('FirebaseException: ${e.message}, Code: ${e.code}');
      } else {
        print('Error: ${e.toString()}');
      }
      return null; // Ensure function returns null in case of an error
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser().then((userModel) {
      if (userModel != null) {
        setState(() {
          _userModel = userModel;
          print(userModel.name); // Assuming 'name' is a property of UserModel
        });
      } else {
        print('Failed to fetch user model.');
      }
    });
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
                                'https://th.bing.com/th/id/R.858e31ac1a2f642fb3ab0015d3f1acfa?rik=k06tBKUH3pIPaQ&riu=http%3a%2f%2fpngimg.com%2fuploads%2ffarmer%2ffarmer_PNG48.png&ehk=7n37l1%2fyRYfmF6FUNG%2bZeKYCOQDTyyb4D8jyHZ%2fPeWw%3d&risl=&pid=ImgRaw&r=0',
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
                                _userModel == null
                                    ? "Farmer"
                                    : _userModel!.name,
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
                                  _userModel == null
                                      ? "Good morning! Farmer"
                                      : 'Good morning ${_userModel!.name}!',
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
                                  items: cropsList.map((String value) {
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
                                onPressed: () async {
                                  _addCrop(
                                    cropNameController.text,
                                    landAreaController.text,
                                  );

                                  // Add logic to handle adding the crop
                                  // Create a reference to the current user
                                  final currentUser =
                                      FirebaseAuth.instance.currentUser;
                                  // Create a collection reference for crops
                                  final cropsCollection = FirebaseFirestore
                                      .instance
                                      .collection('crops');
                                  // Add the crop data to the collection
                                  cropsCollection.add({
                                    'cropName': cropNameController.text,
                                    'landArea': landAreaController.text,
                                    'userId': currentUser?.uid,
                                    'cropDescription': await getCropDescription(
                                      cropNameController.text,
                                    ),
                                  });

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
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('crops')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final crops = snapshot.data!.docs;
                      if (snapshot.data!.docs.isEmpty) {
                        return const Center(
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
                        );
                      } else {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: crops.length,
                          itemBuilder: (context, index) {
                            final crop = crops[index];
                            final cropName = crop['cropName'];
                            final landArea = crop['landArea'];
                            return Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16, 12, 12, 12),
                              child: CropCardWidget(
                                cropName: cropName,
                                landArea: landArea,
                                imageUrl: getImageUrlForCrop(cropName),
                                cropDescription: getCropDescription(cropName),
                              ),
                            );
                          },
                        );
                      }
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return CircularProgressIndicator();
                    }
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
