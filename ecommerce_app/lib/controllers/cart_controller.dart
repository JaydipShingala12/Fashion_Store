import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class CartController extends ChangeNotifier {
  final List<CartItem> _items = [];
  
  List<CartItem> get items => _items;
  
  int get itemCount => _items.length;
  
  double get totalAmount {
    return _items.fold(0, (sum, item) => sum + item.totalPrice);
  }
  
  void addItem(Product product, String selectedSize, String selectedColor) {
    // Check if the item already exists in the cart
    final existingIndex = _items.indexWhere(
      (item) => 
        item.product.id == product.id && 
        item.selectedSize == selectedSize && 
        item.selectedColor == selectedColor
    );
    
    if (existingIndex >= 0) {
      // Increase quantity if item already exists
      _items[existingIndex].quantity += 1;
    } else {
      // Add new item
      _items.add(
        CartItem(
          product: product,
          selectedSize: selectedSize,
          selectedColor: selectedColor,
        ),
      );
    }
  }
  
  void removeItem(int index) {
    _items.removeAt(index);
  }
  
  void updateQuantity(int index, int quantity) {
    if (quantity > 0) {
      _items[index].quantity = quantity;
    }
  }
  
  void clearCart() {
    _items.clear();
  }
} 