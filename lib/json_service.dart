import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'restaurant.dart';

class JsonService {
  List<Restaurant>? _cache;

  Future<List<Restaurant>> loadRestaurants() async {
    if (_cache != null) return _cache!;

    final jsonString = await rootBundle.loadString('assets/restaurants.json');
    final List<dynamic> data = jsonDecode(jsonString);

    _cache = data.map((e) => Restaurant.fromJson(e)).toList();
    return _cache!;
  }
}
