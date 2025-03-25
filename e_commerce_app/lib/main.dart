import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'api/cart_provider.dart';
import 'screens/catalogue_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shopping App',
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        home: CatalogueScreen(),
      ),
    );
  }
}
