import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'auth/auth_service.dart';
import 'auth/user_model.dart';

class AllProducts extends StatelessWidget {
  static const routeName = '/all-products';
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
                ],
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: (user != null)
                    ? StreamBuilder<DocumentSnapshot>(
                        stream: Firestore.instance
                            .collection('users')
                            .document(user.uid)
                            .snapshots(),
                        builder: (context, userSnapshot) {
                          return Text(
                            "Welcome ${(user == null) ? "" : userSnapshot.data['name']}",
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
                        onPressed: () {}),
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
              // SizedBox(
              //   height: height / 10,
              // ),
              Container(
                height: height / 1.3,
                child: StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance.collection('items').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            child: CircularProgressIndicator(
                          strokeWidth: 1,
                        ));
                      }
                      List<Widget> fWidgets = [];
                      final docs = snapshot.data.documents;
                      for (var doc in docs) {
                        final name = doc.data['name'];
                        final desc = doc.data['desc'];
                        final image = doc.data['image'];
                        final price = doc.data['price'];
                        final fdata = Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                color: Colors.white,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          height: 100,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(image),
                                                fit: BoxFit.fill),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            name,
                                            style: GoogleFonts.comfortaa(
                                                color: Colors.black87,
                                                fontSize: 20),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            desc.toString(),
                                            style: GoogleFonts.comfortaa(
                                                color: Colors.black54,
                                                fontSize: 15),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "₹" + price.toString(),
                                            style: GoogleFonts.comfortaa(
                                                color: Colors.black87,
                                                fontSize: 18),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        IconButton(
                                            icon: Icon(Icons.favorite_border),
                                            onPressed: () {}),
                                        RaisedButton(
                                            child: Text(
                                              'Add To Cart',
                                              style: GoogleFonts.comfortaa(
                                                  color: Colors.black87),
                                            ),
                                            onPressed: () {})
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                        fWidgets.add(fdata);
                      }
                      return ListView.builder(
                          itemCount: fWidgets.length,
                          itemBuilder: (ctx, index) {
                            return fWidgets[index];
                          });
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
