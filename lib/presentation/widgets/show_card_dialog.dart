import 'dart:io';

import 'package:cars_ud/config/app_str.dart';
import 'package:cars_ud/config/colors.dart';
import 'package:cars_ud/data/models/car.dart';
import 'package:cars_ud/presentation/pages/shared-ui/show_snackbar.dart';
import 'package:cars_ud/utils/services/db_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class CarDialog {

  User? user;
  CarDialog({this.user});

  void showCarDialog(BuildContext context, ImageSource source) async {
    XFile? _xFile = await ImagePicker().pickImage(source: source);
    File _file = File(_xFile!.path);

    final _keyForm = GlobalKey<FormState>();

    String _carName = "";

    showDialog(context: context, builder: (context) {
      return SimpleDialog(
        contentPadding: EdgeInsets.zero,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            margin: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              color: Colors.grey,
              image: DecorationImage(
                image: FileImage(_file),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Form(
                  key: _keyForm,
                  child: TextFormField(
                    autocorrect: false,
                    keyboardType: TextInputType.name,
                    maxLength: 20,
                    style: const TextStyle(
                      color: MyColor.PRIMARY_COLOR,
                    ),
                    onChanged: (value) => _carName = value,
                    validator: (value) => _carName == ''
                        ? AppSTR.ERROR_ALERT_TEXT
                        : null,
                    decoration: const InputDecoration(
                      labelText: AppSTR.NAME_OF_CAR,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: MyColor.PRIMARY_COLOR)
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Wrap(
                    children: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text(
                          AppSTR.CANCEL_TEXT,
                          style: TextStyle(
                            color: MyColor.PRIMARY_COLOR,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: MyColor.PRIMARY_COLOR,
                        ),
                        onPressed: () => onSubmit(context, _keyForm, _file, _carName, user),
                        child: const Text(
                          AppSTR.PUBLISH_TEXT,
                          style: TextStyle(
                            color: MyColor.WHITE_COLOR,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      );
    },);
  }

  void onSubmit(context, keyForm, file, carName, User? user) async {
    if(keyForm.currentState!.validate()) {
      Navigator.of(context).pop();
      showNotification(context, "Chargement...");
      DatabaseService db = DatabaseService();
      String carUrlImg = await db.uploadFile(file);

      db.addCar(Car(
        carName: carName,
        carUrlImg: carUrlImg,
        carUserID: user!.uid,
        carUsername: user.displayName
      ));
    }
  }

}