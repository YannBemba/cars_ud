import 'package:cars_ud/config/colors.dart';
import 'package:cars_ud/data/models/car.dart';
import 'package:cars_ud/presentation/widgets/my_favorite_badge.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class MyCarFeed extends StatelessWidget {

  final Car? car;
  final String? userID;

  const MyCarFeed({Key? key, this.car, this.userID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/detail', arguments: car!),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.35,
                margin: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                ),
                decoration: BoxDecoration(
                  color: MyColor.GREY_COLOR,
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  image: DecorationImage(
                    image: NetworkImage(car!.carUrlImg!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            MyFavoriteBadge(car: car!, userID: userID,),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    car!.carName!,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 35.0),
                  ),
                  Text(
                    'De ${car!.carUsername!}',
                    style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 17.0),
                  ),
                ],
              ),
              Text(formattingDate(car!.carTimestamp)),
            ],
          ),
        ),
      ],
    );
  }

  String formattingDate(Timestamp? timestamp) {
    initializeDateFormatting('fr', null);
    DateTime? dateTime = timestamp?.toDate();
    DateFormat dateFormat = DateFormat.MMMd();

    return dateFormat.format(dateTime ?? DateTime.now());
  }

}
