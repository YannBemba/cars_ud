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
                colors: [MyColor.WHITE_COLOR, MyColor.TRANSPARENT_COLOR],
                begin: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        title: RichText(
          textAlign: TextAlign.right,
          text: TextSpan(
            children: [
              TextSpan(
                  text: '${user!.displayName}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(color: MyColor.PRIMARY_COLOR)
              ),
              TextSpan(
                  text: '${user!.email}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(color: MyColor.PRIMARY_COLOR)
              ),
            ],
          ),
        ),
        titlePadding: const EdgeInsets.only(left: 46.0, bottom: 8.0),
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
