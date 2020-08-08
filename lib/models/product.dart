import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String price;
  final String imageUrl;
  bool isFavourite;

  changeIfFav() {
    isFavourite = !isFavourite;
    notifyListeners();
  }

  Product(
      {@required this.id,
      @required this.title,
      this.description,
      @required this.price,
      @required this.imageUrl,
      this.isFavourite = false});
}
