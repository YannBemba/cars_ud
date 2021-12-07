import 'package:cars_ud/data/models/car.dart';
import 'package:cars_ud/presentation/pages/detail/car_detail_page.dart';
import 'package:cars_ud/presentation/pages/home/home_page.dart';
import 'package:cars_ud/presentation/pages/login/login_page.dart';
import 'package:cars_ud/presentation/pages/profile/profile_page.dart';
import 'package:cars_ud/utils/services/auth_service.dart';
import 'package:cars_ud/utils/services/db_service.dart';
import 'package:cars_ud/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'config/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        StreamProvider.value(
          initialData: null,
          value: AuthService().user,
        ),
        StreamProvider<List<Car>>.value(
          initialData: const [],
          value: DatabaseService().cars,
        )
      ],
      child: const Wrapper(),
    ),

  );
}

class CarsUDApp extends StatelessWidget {
  const CarsUDApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Map<String, WidgetBuilder> routes = {
      '/': (context) => const Wrapper(),
      '/profile': (context) => const ProfilePage(),
      '/detail': (context) => const CarDetailPage()
    };

    return MaterialApp(
      title: 'CarsUD',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: routes,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        primaryColor: MyColor.WHITE_COLOR,
        textTheme: GoogleFonts.nunitoTextTheme(Theme.of(context).textTheme,),
        appBarTheme: const AppBarTheme(backgroundColor: MyColor.WHITE_COLOR)
      ),
    );
  }
}
