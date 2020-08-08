import 'package:abilita/screens/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
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
      builder: (_, user, child) => Scaffold(
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
                  (user != null)
                      ? FlatButton(
                          onPressed: () async {
                            await context
                                .read<FirebaseAuthService>()
                                .signOut()
                                .whenComplete(() {
                              Navigator.of(context)
                                  .pushReplacementNamed('/login-screen');
                            });
                          },
                          child: Text(
                            'Logout',
                            style: GoogleFonts.comfortaa(color: Colors.white),
                          ),
                        )
                      : FlatButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/login-screen');
                          },
                          child: Text(
                            'Login',
                            style: GoogleFonts.comfortaa(color: Colors.white),
                          ),
                        ),
                  PopupMenuButton(
                      child: Center(
                        child: Text(
                          'More',
                          style: GoogleFonts.comfortaa(color: Colors.white),
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
        body: Column(
          children: [
            ListTile(
              leading: (user != null)
                  ? StreamBuilder<Object>(
                      stream: Firestore.instance
                          .collection('users')
                          .document(user.uid)
                          .snapshots(),
                      builder: (context, userSnapshot) {
                        return Text(
                          "Welcome ${(user == null) ? "" : userSnapshot.data}",
                          style: GoogleFonts.comfortaa(
                              color: Colors.black54, fontSize: 40),
                        );
                      })
                  : Text(
                      "Welcome",
                      style: GoogleFonts.comfortaa(
                          color: Colors.black54, fontSize: 40),
                    ),
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 10,
                  ),
                  FlatButton.icon(
                      label: Text(
                        'Categories',
                        style: GoogleFonts.comfortaa(
                            color: Colors.black87, fontSize: 20),
                      ),
                      icon: Icon(
                        Icons.arrow_drop_down,
                        size: 30,
                        color: Colors.black54,
                      ),
                      onPressed: () {
                        //Navigator.of(context).pushNamed('/my-cart');
                      }),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 30,
                  ),
                  FlatButton.icon(
                      label: Text(
                        'All Products',
                        style: GoogleFonts.comfortaa(
                            color: Colors.black87, fontSize: 20),
                      ),
                      icon: Icon(
                        Icons.arrow_drop_down,
                        size: 30,
                        color: Colors.black54,
                      ),
                      onPressed: () {
                        //Navigator.of(context).pushNamed('/my-cart');
                      }),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 20,
                  ),
                  FlatButton.icon(
                      label: Text(
                        'Popular',
                        style: GoogleFonts.comfortaa(
                            color: Colors.black87, fontSize: 20),
                      ),
                      icon: Icon(
                        Icons.arrow_drop_down,
                        size: 30,
                        color: Colors.black54,
                      ),
                      onPressed: () {
                        //Navigator.of(context).pushNamed('/my-cart');
                      }),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FlatButton.icon(
                      label: Text(
                        ' My Cart',
                        style: GoogleFonts.comfortaa(color: Colors.black87),
                      ),
                      icon: Icon(
                        Icons.shopping_cart,
                        color: Colors.black54,
                      ),
                      onPressed: () {
                        //Navigator.of(context).pushNamed('/my-cart');
                      }),
                  FlatButton.icon(
                      label: Text(
                        ' My Profile',
                        style: GoogleFonts.comfortaa(color: Colors.black87),
                      ),
                      icon: Icon(
                        FontAwesomeIcons.userAlt,
                        color: Colors.black54,
                      ),
                      onPressed: () {
                        //Navigator.of(context).pushNamed('/my-cart');
                      }),
                ],
              ),
            ),
            Divider(),
            Container(
              height: MediaQuery.of(context).size.height / 2,
              child: ProductsGrid(
                showOnlyFavs: showOnlyFavs,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
