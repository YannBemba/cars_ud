import 'package:cars_ud/presentation/widgets/my_profile_app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final _user = Provider.of<User?>(context);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            MyProfileAppBar(user: _user,)
          ],
        ),
      ),
    );
  }
}
