import 'package:flutter/material.dart';
import 'package:red_cuba/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'red CUBA', home: HomePage());
  }
}
