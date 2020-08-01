import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../widgets/products_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool showOnlyFavs;
  ProductsGrid({this.showOnlyFavs});
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = showOnlyFavs ? productsData.favs : productsData.items;
    return GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (ctx, index) {
          if (showOnlyFavs && products[index].isFavourite) {
            return ChangeNotifierProvider.value(
                value: products[index],
                child: ProductItem(
                  isFav: showOnlyFavs,
                ));
          }
          return ChangeNotifierProvider.value(
            value: products[index],
            child: ProductItem(
              isFav: showOnlyFavs,
            ),
          );
        });
  }
}
