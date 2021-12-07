import 'package:cars_ud/config/app_str.dart';
import 'package:cars_ud/config/colors.dart';
import 'package:cars_ud/utils/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyProfileAppBar extends StatelessWidget {
  final User? user;

  const MyProfileAppBar({Key? key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height * 0.4,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(user!.photoURL!),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [MyColor.PRIMARY_COLOR, MyColor.TRANSPARENT_COLOR],
                begin: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        title: RichText(
          textAlign: TextAlign.start,
          text: TextSpan(
            children: [
              TextSpan(
                text: '${user!.displayName}\n',
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
              TextSpan(
                  text: '${user!.email}',
                  style: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                  ),
              ),
            ],
          ),
        ),
        titlePadding: const EdgeInsets.only(left: 26.0, bottom: 20.0),
      ),
      actions: [
        IconButton(
          onPressed: () => signOut(context),
          icon: const Icon(Icons.logout_rounded),
        )
      ],
    );
  }

  signOut(BuildContext context) {
    Navigator.of(context).pop();
    AuthService().signOut();
  }

}
