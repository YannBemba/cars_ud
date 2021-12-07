import 'package:cars_ud/data/models/car.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseService {

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


}