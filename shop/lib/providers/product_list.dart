import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/exceptions/http_exception.dart';
import 'package:shop/models/product.dart';
import 'package:shop/utils/constants.dart';

class ProductList with ChangeNotifier {
  String token;
  String userId;
  List<Product> _items = [];

  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((prod) => prod.isFavorite).toList();
  //[..._items] Retornando um clone dos itens evitando que adicionem itens atraves do get

  ProductList([
    this.token = '',
    this.userId = '',
    this._items = const [],
  ]);

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadProducts() async {
    _items.clear();
    final response = await http.get(
      Uri.parse('${Constants.productBaseUrl}.json?auth=$token'),
    );
    if (response.body == 'null') return;

    final favResponse = await http.get(
      Uri.parse(
        '${Constants.userFavoritesUrl}/$userId.json?auth=$token',
      ),
    );

    Map<String, dynamic> favData =
        favResponse.body == 'null' ? {} : jsonDecode(favResponse.body);

    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((productId, productData) {
      final isFavorite = favData[productId] ?? false;

      _items.add(Product(
        id: productId,
        name: productData['name'],
        description: productData['description'],
        price: productData['price'],
        imageUrl: productData['imageUrl'],
        isFavorite: isFavorite,
      ));
    });
    notifyListeners(); //Notificando aos interessados que ouve uma mudança na lista
  }

  Future<void> saveProductFromData(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final product = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );

    if (hasId) {
      return updateProduct(product);
    } else {
      return addProduct(product);
    }
  }

  Future<void> addProduct(Product product) async {
    final response = await http.post(
        Uri.parse('${Constants.productBaseUrl}.json?auth=$token'),
        body: jsonEncode({
          "name": product.name,
          "description": product.description,
          "price": product.price,
          "imageUrl": product.imageUrl,
        }));

    final id = jsonDecode(response.body)['name'];
    _items.add(Product(
      id: id,
      name: product.name,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
    ));
    notifyListeners(); //Notificando aos interessados que ouve uma mudança na lista
  }

  Future<void> updateProduct(Product product) async {
    int index = _items.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      await http.patch(
          Uri.parse(
              '${Constants.productBaseUrl}/${product.id}.json?auth=$token'),
          body: jsonEncode({
            "name": product.name,
            "description": product.description,
            "price": product.price,
            "imageUrl": product.imageUrl,
          }));

      _items[index] = product;
      notifyListeners(); //Notificando aos interessados que ouve uma mudança na lista
    }
  }

  Future<void> removeProduct(Product product) async {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      final product = _items[index];
      _items.remove(product);
      notifyListeners(); //Notificando aos interessados que ouve uma mudança na lista

      final response = await http.delete(
        Uri.parse('${Constants.productBaseUrl}/${product.id}.json?auth=$token'),
      );

      //erro da familia dos 400 é do lado do cliente
      //erro da familia dos 500 é do lado do servidor
      if (response.statusCode >= 400) {
        _items.insert(index, product);
        notifyListeners(); //Notificando aos interessados que ouve uma mudança na lista
        throw HttpException(
          msg: 'Não foi possível excluir o produto',
          statusCode: response.statusCode,
        );
      }
    }
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