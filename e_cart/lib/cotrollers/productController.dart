import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProductController extends GetxController {
  RxList<dynamic> productList = RxList([]);
  RxList<String> categoryList = RxList([]);
  RxList<dynamic> cart = RxList([]);
  RxList<dynamic> displayCart = RxList([]);
  RxBool isLoading = RxBool(false);

  final String _baseUrl = "https://fakestoreapi.com";

  @override
  void onInit() {
    super.onInit();
    fetchAllProducts();
    fetchAllCategories();
  }

  Future<void> fetchAllProducts() async {
    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse('$_baseUrl/products'));
      if (response.statusCode == 200) {
        productList.assignAll(json.decode(response.body));
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchAllCategories() async {
    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse('$_baseUrl/products/categories'));
      if (response.statusCode == 200) {
        categoryList.assignAll(List<String>.from(json.decode(response.body)));
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchOneProduct(int productId) async {
    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse('$_baseUrl/products/$productId'));
      if (response.statusCode == 200) {
        // Assuming we want to add this product to the productList
        productList.assignAll([json.decode(response.body)]);
      } else {
        throw Exception('Failed to load product');
      }
    } catch (e) {
      throw Exception('Failed to load product: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchAllCarts() async {
    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse('$_baseUrl/carts'));
      if (response.statusCode == 200) {
        cart.assignAll(json.decode(response.body));
      } else {
        throw Exception('Failed to load carts');
      }
    } catch (e) {
      throw Exception('Failed to load carts: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void addItemsToCart(dynamic product) {
    int index = cart.indexWhere((item) => item['id'] == product['id']);
    if (index != -1) {
      cart[index]['quantity'] = (cart[index]['quantity'] as int) + 1;
    } else {
      var newProduct = Map<String, dynamic>.from(product);
      newProduct['quantity'] = 1;
      cart.add(newProduct);
    }
    cart.refresh();
  }

  void increaseQuantity(dynamic product) {
    int index = cart.indexWhere((item) => item['id'] == product['id']);
    if (index != -1) {
      cart[index]['quantity'] = (cart[index]['quantity'] as int) + 1;
      cart.refresh();
    }
  }

  void decreaseQuantity(dynamic product) {
    int index = cart.indexWhere((item) => item['id'] == product['id']);
    if (index != -1) {
      var currentQuantity = cart[index]['quantity'] as int;
      if (currentQuantity > 1) {
        cart[index]['quantity'] = currentQuantity - 1;
        cart.refresh();
      }
    }
  }

  int getTotalItemCount() {
    return cart.fold(0, (sum, item) => sum + (item['quantity'] as int));
  }

  double getTotalPrice() {
    return cart.fold(0.0, (sum, item) => sum + ((item['quantity'] as int) * (item['price'] as double)));
  }

  void removeFromCart(int id) {
    cart.removeWhere((item) => item['id'] == id);
    cart.refresh();
  }
}
