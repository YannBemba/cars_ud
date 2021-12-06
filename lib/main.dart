import 'package:cars_ud/presentation/pages/login/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CarsUDApp());
}

class CarsUDApp extends StatelessWidget {
  const CarsUDApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'CarsUD',
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
