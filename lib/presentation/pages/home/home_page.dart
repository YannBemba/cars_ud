import 'package:cars_ud/config/colors.dart';
import 'package:cars_ud/presentation/widgets/add_car_section.dart';
import 'package:cars_ud/presentation/widgets/my_home_app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final _user = Provider.of<User?>(context);
    return Scaffold(
      backgroundColor: MyColor.WHITE_COLOR,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            MyHomeAppBar(user: _user,),
            AddCarSection(user: _user),
          ],
        ),
      ),
    );
  }
}
