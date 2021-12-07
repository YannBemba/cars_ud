import 'package:cars_ud/data/models/car.dart';
import 'package:cars_ud/presentation/widgets/my_car_feed.dart';
import 'package:cars_ud/utils/services/db_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class MyCarList extends StatelessWidget {

  final String? userID;
  final String? pageName;
  const MyCarList({Key? key, this.userID, this.pageName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _cars = Provider.of<List<Car>>(context);
    return SliverList(
      delegate: SliverChildBuilderDelegate((_, index) {
        return StreamBuilder(
          stream: DatabaseService(userID: userID, carID: _cars[index].carID).myFavoriteCar,
          builder: (context, snapshot) {
            if(pageName == 'Profile') {
              if(!snapshot.hasData) return Container();
              _cars[index].isMyFavoritedCar = true;
              return MyCarFeed(car: _cars[index], userID: userID,);
            }
            if(!snapshot.hasData) {
              _cars[index].isMyFavoritedCar = false;
              return MyCarFeed(car: _cars[index], userID: userID,);
            } else {
              _cars[index].isMyFavoritedCar = true;
              return MyCarFeed(car: _cars[index], userID: userID,);
            }
          },
        );
      },
        childCount: _cars.length,
      ),
    );
  }
}
