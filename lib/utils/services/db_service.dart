import 'package:cars_ud/data/models/car.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseService {

  String? userID;
  String? carID;


  DatabaseService({this.userID, this.carID});

  final CollectionReference _cars = FirebaseFirestore.instance.collection('cars');
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // image upload

  Future<String> uploadFile(file) async {
    Reference reference = _storage.ref().child('cars/${DateTime.now()}.png');
    UploadTask uploadTask = reference.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask;

    return await taskSnapshot.ref.getDownloadURL();
  }

  // add a car
  void addCar(Car car) {
    _cars.add({
      "carName": car.carName,
      "carUrlImg": car.carUrlImg,
      "carUserID": car.carUserID,
      "carUsername": car.carUsername,
      "carTimestamp": FieldValue.serverTimestamp(),
      "carFavoriteCount": 0,
    });
  }

  // get all cars
  Stream<List<Car>> get cars {
    Query queryCars = _cars.orderBy('carTimestamp', descending: true);
    return queryCars.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Car(
            carID: doc.id,
            carName: doc.get('carName'),
            carUrlImg: doc.get('carUrlImg'),
            carUserID: doc.get('carUserID'),
            carUsername: doc.get('carUsername'),
            carFavoriteCount: doc.get('carFavoriteCount')
        );
      }).toList();
    });
  }

  // add a favorite car

  void addFavoriteCar(Car car, String userID) async {
    final carDocRef = _cars.doc(car.carID);
    final favoriteBy = carDocRef.collection('favoritedBy');

    int carFavoriteCount = car.carFavoriteCount!;
    int increaseCount = carFavoriteCount;
    favoriteBy.doc(userID).set({
      "carName": car.carName,
      "carUrlImg": car.carUrlImg,
      "carUserID": car.carUserID,
      "carUsername": car.carUsername,
      "carTimestamp": car.carTimestamp,
      "carFavoriteCount": increaseCount,
    });

    carDocRef.update({'carFavoriteCount': increaseCount});

  }

  // remove a car

  void removeFavoriteCar(Car car, String userID) {
    final carDocRef = _cars.doc(car.carID);
    final favoritedBy = carDocRef.collection('favoriteBy');

    int carFavoriteCount = car.carFavoriteCount!;
    int decreaseCount = carFavoriteCount -= 1;

    carDocRef.update({'carFavoriteCount': decreaseCount});
    favoritedBy.doc(userID).delete();

  }

  // get all favorite cars

  Stream<Car> get myFavoriteCar {
    final favoritedBy = _cars.doc(carID).collection('favoritedBy');

    return favoritedBy.doc(userID).snapshots().map((doc) {
      return Car(
        carID: doc.id,
        carName: doc.get('carName'),
        carUrlImg: doc.get('carUrlImg'),
        carUserID: doc.get('carUserID'),
        carUsername: doc.get('carUsername'),
        carFavoriteCount: doc.get('carFavoriteCount'),
        carTimestamp: doc.get('carTimestamp')
      );
    });
  }


}