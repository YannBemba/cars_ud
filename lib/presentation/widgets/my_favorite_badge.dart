import 'package:cars_ud/config/colors.dart';
import 'package:cars_ud/data/models/car.dart';
import 'package:cars_ud/utils/services/db_service.dart';
import 'package:flutter/material.dart';

class MyFavoriteBadge extends StatefulWidget {
  final Car? car;
  final String? userID;

  const MyFavoriteBadge({Key? key, this.car, this.userID}) : super(key: key);

  @override
  State<MyFavoriteBadge> createState() => _MyFavoriteBadgeState();
}

class _MyFavoriteBadgeState extends State<MyFavoriteBadge> {

  bool isMyFavoritedCar = false;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 14.0,
      right: 50.0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        height: 12,
        width: 12,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          color: MyColor.WHITE_COLOR.withOpacity(0.7),
        ),
        child: widget.car!.isMyFavoritedCar! ? GestureDetector(
          onTap: () => DatabaseService().removeFavoriteCar(widget.car!, widget.userID!),
          child: Row(
            children: [
              Text('${widget.car!.carFavoriteCount}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),),
              const Icon(Icons.favorite_rounded, color: Colors.red, size: 25.0,),
            ],
          ),
        ) : GestureDetector(
          onTap: () => DatabaseService().addFavoriteCar(widget.car!, widget.userID!),
          child: Row(
            children: [
              widget.car!.carFavoriteCount! > 0 ?
              Text(
                '${widget.car!.carFavoriteCount}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ) : Container(),
              const Icon(Icons.favorite_outlined, size: 25.0, color: MyColor.WHITE_COLOR,)
            ],
          ),
        ),
      ),
    );
  }
}
