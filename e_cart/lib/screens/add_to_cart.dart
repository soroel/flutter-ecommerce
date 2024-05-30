import 'package:flutter/material.dart';
import '../cotrollers/productController.dart';
import 'add_to_cart.dart';

class ProductDetailsPage extends StatelessWidget {
  final Map<String, dynamic> product;
  final ProductController productController = ProductController();

  ProductDetailsPage({required this.product});

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
                addToCart(context);
              },
              child: Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }

  void addToCart(BuildContext context) {
    // Here you can implement the logic to add the product to the cart
    // For example, you can call a function from your controller
    productController.addItemsToCart(product);

    // Show a dialog to inform the user that the item has been added to the cart
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add to Cart'),
        content: Text('Item added to cart!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
