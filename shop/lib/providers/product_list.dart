import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

class ProductList with ChangeNotifier {
  final List<Product> _items = dummyProducts;

  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((prod) => prod.isFavorite).toList();
  //[..._items] Retornando um clone dos itens evitando que adicionem itens atraves do get

  int get itemsCount {
    return _items.length;
  }

  void saveProductFromData(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final product = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );

    if (hasId) {
      updateProduct(product);
    } else {
      addProduct(product);
    }
  }

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners(); //Notificando aos interessados que ouve uma mudança na lista
  }

  void updateProduct(Product product) {
    int index = _items.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      _items[index] = product;
    }
    notifyListeners(); //Notificando aos interessados que ouve uma mudança na lista
  }
}


//  bool _showFavoriteOnly = false;

//  List<Product> get items {
//    if (_showFavoriteOnly) {
//      return _items.where((prod) => prod.isFavorite).toList();
//    }
//    return [..._items];
//  }
  //[..._items] Retornando um clone dos itens evitando que adicionem itens atraves do get

//  void showFavoriteOnly() {
//    _showFavoriteOnly = true;
//    notifyListeners(); //Notificando aos interessados que ouve uma mudança na lista
//  }

//  void showAll() {
//    _showFavoriteOnly = false;
//    notifyListeners(); //Notificando aos interessados que ouve uma mudança na lista
//  }