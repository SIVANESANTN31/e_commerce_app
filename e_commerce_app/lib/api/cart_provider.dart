import 'package:flutter/material.dart';
import 'product_model.dart';

class CartProvider with ChangeNotifier {
  Map<int, Product> _items = {};

  Map<int, Product> get items => _items;

  int get itemCount => _items.length;

  double get totalPrice {
    return _items.values.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  get cartItems => null;

  void addToCart(Product product) {
    if (_items.containsKey(product.id)) {
      _items[product.id]!.quantity += 1;
    } else {
      _items[product.id] = product.copyWith(quantity: 1);
    }
    notifyListeners();
  }

  void decreaseQuantity(int id) {
    if (_items.containsKey(id) && _items[id]!.quantity > 1) {
      _items[id]!.quantity -= 1;
    } else {
      _items.remove(id);
    }
    notifyListeners();
  }
}
