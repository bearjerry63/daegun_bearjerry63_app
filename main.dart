import 'package:flutter/material.dart';
import 'logins/login_page.dart';
import 'logins/login_api.dart';
import 'mainpage.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final isLoggedIn = await GoogleSignInService.isUserLoggedIn();
  isLoggedIn ? await GoogleSignInService.getUserInfo() : null;
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  MyApp({required this.isLoggedIn});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '인천대건고등학교 앱',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white,background: Color(
            0xFF292929)),
        useMaterial3: true,
      ),
      home: isLoggedIn ? mainpage() : LoginPage(),
    );
  }
}
