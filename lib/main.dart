import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc3_overload_oblivion/common/cubits/auth_user/auth_user_cubit.dart';
import 'package:nfc3_overload_oblivion/common/global/app_pallete.dart';
import 'package:nfc3_overload_oblivion/common/global/placemark.dart';
import 'package:nfc3_overload_oblivion/features/auth/pages/login_page.dart';
import 'package:nfc3_overload_oblivion/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:nfc3_overload_oblivion/features/home/home_page.dart';
import 'package:nfc3_overload_oblivion/init_dependencies.dart';
import 'package:provider/provider.dart';
import 'dart:async'; // Import Timer

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => serviceLocator<AuthUserCubit>()),
      BlocProvider(create: (context) => serviceLocator<AuthBloc>()),
    ],
    child: MultiProvider(
      providers: [
        Provider<ChangeNotifier>(
          create: (context) => PlacemarkProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Timer _alertTimer;

  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
    _startAlertTimer();
  }

  void _startAlertTimer() {
    // List of alerts to show
    final List<String> alerts = [
      "Remember to water your crops.",
      "Time to check soil health.",
      "Harvest season is approaching!",
      "Consider applying fertilizer."
    ];

    int alertIndex = 0;

    _alertTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      // Show alert if there are still alerts to show
      if (alertIndex < alerts.length) {
        _showAlert(alerts[alertIndex]);
        alertIndex++;
      } else {
        timer.cancel(); // Stop the timer when all alerts have been shown
      }
    });
  }

  void _showAlert(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Reminder'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _alertTimer.cancel(); // Cancel timer when widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: AppPallete.primaryBackground),
        useMaterial3: true,
      ),
      home: BlocSelector<AuthBloc, AuthState, bool>(
        selector: (state) => state is AuthUserLoggedIn,
        builder: (context, isLoggedIn) {
          return isLoggedIn ? const HomePage() : const LoginWidget();
        },
      ),
    );
  }
}
