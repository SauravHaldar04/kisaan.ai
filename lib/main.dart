import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc3_overload_oblivion/common/cubits/auth_user/auth_user_cubit.dart';
import 'package:nfc3_overload_oblivion/features/auth/pages/login_page.dart';
import 'package:nfc3_overload_oblivion/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:nfc3_overload_oblivion/features/home/home_page.dart';
import 'package:nfc3_overload_oblivion/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => serviceLocator<AuthUserCubit>()),
      BlocProvider(create: (context) => serviceLocator<AuthBloc>()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocSelector<AuthBloc, AuthState, bool>(selector: (state) {
        return state is AuthUserLoggedIn;
      }, builder: (context, state) {
        if (state) {
          return const HomePage();
        }
        return const LoginWidget();
      }),
    );
  }
}
