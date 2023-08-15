import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

class ProductList with ChangeNotifier {
  final List<Product> _items = dummyProducts;
  List<Product> get items => [..._items];
  //[..._items] Retornando um clone dos itens evitando que adicionem itens atraves do get

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners(); //Notificando aos interessados que ouve uma mudança na lista
  }
}
