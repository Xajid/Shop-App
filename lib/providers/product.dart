import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;
  Product(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.imageUrl,
      @required this.price,
      this.isFavourite = false});

  void toggleFavouriteStatus() async {
    final oldStatus = isFavourite;

    isFavourite = !isFavourite;
    notifyListeners();
    try {
      final response = await http.patch(
          Uri.parse(
              'https://shop-app-b3e6c-default-rtdb.firebaseio.com/products/$id.json'),
          body: jsonEncode({'isFavourite': isFavourite}));
      if (response.statusCode >= 400) {
        isFavourite = oldStatus;
        notifyListeners();
      }
    } catch (error) {
      isFavourite = oldStatus;
      notifyListeners();
    }
  }
}
