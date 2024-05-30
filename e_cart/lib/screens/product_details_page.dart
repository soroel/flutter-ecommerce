import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../cotrollers/productController.dart';

class ProductDetailsPage extends StatelessWidget {
  final Map<String, dynamic> product;

  ProductDetailsPage({required this.product});
  final ProductController productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                product['image'],
                height: 300,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              product['title'],
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              product['description'],
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            Text(
              '\$${product['price']}',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                productController.addItemsToCart(product);
                // Show a Snackbar after adding to cart
                Get.snackbar(
                  'Cart Update',  // Title of the Snackbar
                  'Item added to cart!',  // Message displayed
                  snackPosition: SnackPosition.BOTTOM,  // Position of the Snackbar
                  backgroundColor: Colors.purple,
                  colorText: Colors.white,
                  duration: Duration(seconds: 2),  // Duration the Snackbar is visible
                );

                print("item ${productController.cart}");
              },
              child: Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}
