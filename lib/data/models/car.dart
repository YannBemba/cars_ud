import 'package:cloud_firestore/cloud_firestore.dart';

class Car {

  String? carID;
  String? carUserID;
  String? carName;
  String? carUrlImg;
  String? carUsername;
  Timestamp? carTimestamp;
  bool? isMyFavoritedCar;
  int? carFavoriteCount;

  Car(
      {this.carID,
        this.carName,
        this.carUrlImg,
        this.carUserID,
        this.carUsername,
        this.carTimestamp,
        this.isMyFavoritedCar,
        this.carFavoriteCount,
      });
}