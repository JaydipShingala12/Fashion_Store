import 'package:flutter/material.dart';
import '../models/product.dart';

class WishlistController extends ChangeNotifier {
  final List<Product> _items = [];
  
  List<Product> get items => _items;
  
  int get itemCount => _items.length;
  
  bool isProductLiked(String productId) {
    return _items.any((product) => product.id == productId);
  }
  
  void toggleLike(Product product) {
    final isLiked = isProductLiked(product.id);
    
    if (isLiked) {
      _items.removeWhere((item) => item.id == product.id);
    } else {
      _items.add(product);
    }
  }
  
  void removeItem(String productId) {
    _items.removeWhere((item) => item.id == productId);
  }
  
  void clearWishlist() {
    _items.clear();
  }
} 