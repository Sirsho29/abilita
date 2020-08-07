import 'package:flutter/material.dart';

class MyCart extends StatelessWidget {
  static const routeName = '/my-cart';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: Text('My Cart'),
        ),
        body: Column());
  }
}
