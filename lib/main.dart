import 'package:flutter/material.dart';
import 'splash_page.dart';
import 'home_page.dart';
import 'restaurant_list_page.dart';
import 'category_page.dart';
import 'detail_page.dart';

void main() {
  runApp(const RestaurantApp());
}

class RestaurantApp extends StatelessWidget {
  const RestaurantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashPage(),
        '/home': (context) => const HomePage(),
        '/list': (context) => const ListPage(),
        '/category': (context) => const CategoryPage(),
        '/detail': (context) => const DetailPage(),
      },
    );
  }
}
