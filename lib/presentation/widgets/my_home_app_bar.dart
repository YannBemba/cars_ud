import 'package:cars_ud/config/app_str.dart';
import 'package:cars_ud/config/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyHomeAppBar extends StatelessWidget {

  final User? user;

  const MyHomeAppBar({Key? key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: const Text(AppSTR.APP_NAME, style: TextStyle(
        color: MyColor.PRIMARY_COLOR,
        fontWeight: FontWeight.w500,
        fontSize: 24.0,
      ),),
      elevation: .8,
      floating: true,
      toolbarHeight: 75,
      backgroundColor: MyColor.WHITE_COLOR,
      forceElevated: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: GestureDetector(
            onTap: () => Navigator.of(context).pushNamed('/profile'),
            child: CircleAvatar(
              backgroundColor: MyColor.GREY_COLOR,
              backgroundImage: NetworkImage(user!.photoURL!),
            ),
          ),
        ),
      ],
    );
  }
}

