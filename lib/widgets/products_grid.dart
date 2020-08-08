import 'package:abilita/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductsGrid extends StatelessWidget {
  final bool showOnlyFavs;
  ProductsGrid({this.showOnlyFavs});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('items').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 1,
              ),
            );
          }
          List<Product> _items = [];
          final docs = snapshot.data.documents;
          for (var d in docs) {
            _items.add(Product(
                id: d.documentID.toString(),
                title: d.data['name'].toString(),
                price: (d.data['price']).toString(),
                imageUrl: d.data['image'].toString()));
          }
          return GridView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: snapshot.data.documents.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (ctx, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: GridTile(
                    child: GestureDetector(
                      onTap: () {
                        // Navigator.of(context).pushNamed(
                        //     ProductDetailScreen.routeName,
                        //     arguments: product.id);
                      },
                      child: Image.network(
                        _items[index].imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    footer: GridTileBar(
                      title: Text(
                        _items[index].title,
                        textAlign: TextAlign.center,
                      ),
                      backgroundColor: Colors.black87,
                      // leading: IconButton(
                      //   icon: Icon(
                      //     (product.isFavourite)
                      //         ? Icons.favorite
                      //         : Icons.favorite_border,
                      //     color: Theme.of(context).accentColor,
                      //   ),
                      //   onPressed: () {
                      //     if (!isFav) {
                      //       product.changeIfFav();
                      //     }
                      //   },
                      // ),
                      trailing: IconButton(
                          icon: Icon(
                            Icons.add_shopping_cart,
                            color: Theme.of(context).accentColor,
                          ),
                          onPressed: () {
                            // cart.addItem(
                            //     product.id, product.price, product.title);
                          }),
                    ),
                  ),
                );
              });
        });
  }
}
