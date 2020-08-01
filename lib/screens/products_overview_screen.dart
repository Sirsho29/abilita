import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../widgets/badge.dart';
import '../widgets/products_grid.dart';
import '../screens/auth/user_model.dart';

enum FilterOptions {
  Favourites,
  All,
}

class ProductOverviewScreen extends StatefulWidget {
  static const routeName = "/product-overview-screen";
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool showOnlyFavs = false;

  @override
  Widget build(BuildContext context) {
    //final productsContainer = Provider.of<Products>(context, listen: false);
    return Consumer<User>(
      builder: (_, user, __) => Scaffold(
        drawer: Drawer(),
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Builder(
              builder: (ctx) => RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(
                        width: 3,
                        color: Color.fromRGBO(160, 160, 160, 1),
                      )),
                  color: Color.fromRGBO(57, 57, 57, 1),
                  padding: EdgeInsets.all(0),
                  hoverColor: Colors.lightBlue,
                  child: Icon(
                    Icons.apps,
                    color: Color.fromRGBO(249, 249, 249, 1),
                    size: 25,
                  ),
                  onPressed: () {
                    Scaffold.of(ctx).openDrawer();
                  }),
            ),
          ),
          title:
              Container(width: 150, child: Image.asset('assets/logoBig.png')),
          backgroundColor: Color.fromRGBO(57, 57, 57, 1),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Consumer<Cart>(
                    builder: (ctx, cart, child) =>
                        Badge(child: child, value: cart.cartCount.toString()),
                    child: FlatButton.icon(
                        label: Text(
                          'Cart',
                          style: GoogleFonts.breeSerif(color: Colors.white),
                        ),
                        icon: Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed('/my-cart');
                        }),
                  ),
                  (user != null)
                      ? Text(
                          'Welcome ${user.displayName}',
                          style: GoogleFonts.breeSerif(color: Colors.white),
                        )
                      : FlatButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/login-screen');
                          },
                          child: Text(
                            'Login',
                            style: GoogleFonts.breeSerif(color: Colors.white),
                          ),
                        ),
                  PopupMenuButton(
                      child: Center(
                        child: Text(
                          'More',
                          style: GoogleFonts.breeSerif(color: Colors.white),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Colors.redAccent, width: 1)),
                      elevation: 5,
                      onSelected: (FilterOptions value) {
                        if (value == FilterOptions.Favourites) {
                          //productsContainer.showFavsOnly();
                          setState(() {
                            showOnlyFavs = true;
                          });
                        } else {
                          //productsContainer.showAll();
                          setState(() {
                            showOnlyFavs = false;
                          });
                        }
                      },
                      itemBuilder: (_) => [
                            PopupMenuItem(
                              child: Text('Only Favourites'),
                              value: FilterOptions.Favourites,
                            ),
                            PopupMenuItem(
                                child: Text('Show All'),
                                value: FilterOptions.All),
                          ]),
                ],
              ),
            ),
          ],
        ),
        body: ProductsGrid(
          showOnlyFavs: showOnlyFavs,
        ),
      ),
    );
  }
}
