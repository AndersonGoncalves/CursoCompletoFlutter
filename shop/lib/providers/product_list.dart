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

  void addProduct(Product product) {
    _items.add(product);
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