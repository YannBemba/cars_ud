import 'package:cars_ud/config/app_str.dart';
import 'package:cars_ud/config/colors.dart';
import 'package:cars_ud/utils/services/auth_service.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool inLoginProcess = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.ORANGE_COLOR,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/pres.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    AppSTR.PRES_TITLE,
                    style: TextStyle(
                      color: MyColor.WHITE_COLOR,
                      fontWeight: FontWeight.w900,
                      fontSize: 50.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                    AppSTR.PRES_DESC,
                    style: TextStyle(
                      color: MyColor.WHITE_COLOR,
                      fontWeight: FontWeight.w400,
                      fontSize: 20.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
                  _buildGoogleSignButton(
                    context,
                    title: AppSTR.GOOGLE_SIGN,
                    onTap: () => signIn(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  signIn() {
    setState(() {
      inLoginProcess = true;
      AuthService().signInWithGoogle();
    });
  }

  Widget _buildGoogleSignButton(BuildContext context, {
    void Function()? onTap,
    String? title,
  }) {

    return InkWell(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          color: MyColor.WHITE_COLOR,
          borderRadius: BorderRadius.circular(11.0),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset('assets/images/google.png', width: 40,),
              Text(
                title!,
                style: const TextStyle(
                  color: MyColor.PRIMARY_COLOR,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
