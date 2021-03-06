import 'package:abilita/screens/all_prod.dart';
import 'package:abilita/screens/auth/auth_service.dart';
import 'package:abilita/screens/auth/login.dart';
import 'package:flutter/material.dart';
import './screens/my_cart.dart';
import './screens/product_detail_screen.dart';
import 'package:provider/provider.dart';
import './screens/products_overview_screen.dart';

void main() => runApp(MultiProvider(providers: [
      Provider(create: (_) => FirebaseAuthService()),
      StreamProvider(
          create: (context) =>
              context.read<FirebaseAuthService>().onAuthStateChanged),
    ], child: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyShop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //primarySwatch: MaterialColor(1, {1: Color.fromRGBO(57, 57, 57, 1)}),
        accentColor: Colors.deepOrange,
        fontFamily: 'Lato',
      ),
      home: ProductOverviewScreen(),
      routes: {
        ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
        MyCart.routeName: (ctx) => MyCart(),
        '/login-screen': (ctx) => LoginScreen(),
        "/product-overview-screen": (ctx) => ProductOverviewScreen(),
        '/all-products': (ctx) => AllProducts(),
      },
    );
  }
}
