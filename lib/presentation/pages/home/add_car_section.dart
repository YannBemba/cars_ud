import 'package:cars_ud/config/app_str.dart';
import 'package:cars_ud/presentation/widgets/show_card_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddCarSection extends StatelessWidget {

  final User? user;

  const AddCarSection({Key? key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 24.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    AppSTR.HI_TEXT,
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  Text(
                    user!.displayName!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32.0,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[300],
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.search_rounded),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(left: 11.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor.withOpacity(0.5),
                    ),
                    child: IconButton(
                      onPressed: () => showCarDialog(context, user!),
                      icon: const Icon(Icons.add_rounded),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }

  void showCarDialog(BuildContext context, User? user) {
    CarDialog(user: user).showCarDialog(context, ImageSource.gallery);
  }

}
