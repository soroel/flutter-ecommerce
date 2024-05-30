import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../cotrollers/productController.dart';
import 'payment.dart';

class CartPage extends StatelessWidget {
  final ProductController productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        actions: [
          IconButton(
            icon: Icon(Icons.payment),
            onPressed: () {
              Get.to(() => PaymentScreen());
            },
          ),
        ],
      ),
      body: Obx(() {
        final cartItems = productController.cart;
        if (cartItems.isEmpty) {
          return Center(
            child: Text('Your cart is empty'),
          );
        } else {
          return ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final item = cartItems[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(item['image']),
                ),
                title: Text(item['title'] ?? 'Unknown Title'),
                subtitle: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        productController.decreaseQuantity(item);
                        // Show snackbar
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Item removed from cart'),
                            duration: Duration(seconds: 2), // Optional duration
                          ),
                        );
                      },
                    ),
                    Text('Quantity: ${item['quantity']}'),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        productController.increaseQuantity(item);
                        // Show snackbar
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                            content: Text('Item added to cart'),
                            duration: Duration(seconds: 2),
                            ),
                        );
                      },
                    ),
                  ],
                ),
                trailing: Text('\$${item['price'] ?? 0}'),
              );
            },
          );
        }
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Perform checkout action
          // Navigate to payment page or perform checkout logic
          Get.to(() => PaymentScreen());
        },
        label: Text('Checkout'),
        icon: Icon(Icons.shopping_cart),
        backgroundColor: Colors.purple,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
