import 'package:cars_ud/config/app_str.dart';
import 'package:cars_ud/presentation/widgets/my_car_list.dart';
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
            MyProfileAppBar(user: _user,),
            SliverList(
              delegate: SliverChildListDelegate([
                const Padding(
                  padding: EdgeInsets.only(top: 24.0, left: 16.0, bottom: 12.0),
                  child: Text(
                    AppSTR.FAVORITE_CAR,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 23.0
                    ),
                  ),
                ),
                const Divider()
              ]),
            ),
            MyCarList(
              pageName: 'Profile',
              userID: _user!.uid,
            ),
          ],
        ),
      ),
    );
  }
}
