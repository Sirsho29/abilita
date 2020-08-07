import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
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

 factory Product.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;
    return Product(
      id: doc.documentID,
      title: data['name'],
      price: data['price'],
      imageUrl: data['image'],
      description: data['type'] + ' with quantity ' + data['quantity'],
    ); 
  }
}
