import 'package:flutter/material.dart';

class ProductsGrid extends StatelessWidget {
  final bool showOnlyFavs;
  ProductsGrid({this.showOnlyFavs});
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: 2, //products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (ctx, index) {});
  }
}
