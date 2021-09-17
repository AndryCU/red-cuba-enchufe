import 'package:flutter/material.dart';
import 'package:red_cuba/pages/abut_page.dart';
import 'package:red_cuba/pages/home_page.dart';
import 'package:red_cuba/pages/search_page.dart';
import 'package:red_cuba/utiles/preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomePage(),
        'search': (BuildContext context) => SearchPage(),
        'about': (BuildContext context) => AboutPage()
      },
    );
  }
}
