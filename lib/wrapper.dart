import 'package:cars_ud/presentation/pages/home/home_page.dart';
import 'package:cars_ud/presentation/pages/login/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User?>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _user == null ? const LoginPage(): const HomePage(),
    );
  }
}
