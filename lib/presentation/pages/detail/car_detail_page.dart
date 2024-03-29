import 'package:cars_ud/config/app_str.dart';
import 'package:cars_ud/config/colors.dart';
import 'package:cars_ud/data/models/car.dart';
import 'package:cars_ud/presentation/widgets/show_snackbar.dart';
import 'package:cars_ud/utils/services/db_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CarDetailPage extends StatelessWidget {
  const CarDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final car = ModalRoute.of(context)!.settings.arguments as Car;
    final _userID = Provider.of<User>(context).uid;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          car.carName!,
          style: const TextStyle(color: MyColor.WHITE_COLOR),
        ),
        backgroundColor: MyColor.TRANSPARENT_COLOR,
        iconTheme: const IconThemeData(color: MyColor.WHITE_COLOR),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
        ),
        actions: [
          car.carUserID == _userID
              ? IconButton(onPressed: () => onDeleteCar(context, car), icon: const Icon(Icons.delete),)
              : Container()
        ],
      ),
      body: InteractiveViewer(
        child: Hero(
          tag: car.carName!,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: MyColor.PRIMARY_COLOR,
                image: DecorationImage(
                  image: NetworkImage(car.carUrlImg!),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onDeleteCar(BuildContext context, Car? car) {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        content: Text(
          'Voulez-vous supprimer votre ${car!.carName}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(AppSTR.CANCEL_TEXT),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              DatabaseService().deleteCar(car.carID);
              showNotification(context, AppSTR.DELETE_SUCCESS);
            },
            child: const Text(AppSTR.DELETE),
          ),
        ],
      );
    },);
  }

}
