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
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Make Payment'),
                    content: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            TextField(
                              controller: TextEditingController(), // Add your controller here
                              decoration: InputDecoration(labelText: 'Phone Number'),
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Confirm Payment'),
                                      content: Text('Send \$${productController.getTotalPrice().toStringAsFixed(2)} to account ?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            // Perform payment logic here
                                            // Close the dialog
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Confirm'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            // Close the dialog
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Cancel'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Text('Submit Payment'),
                            ),

                          ],
                        );
                      },
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Close'),
                      ),
                    ],
                  );
                },
              );
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
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Item removed from cart'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                    ),
                    Text('Quantity: ${item['quantity']}'),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        productController.increaseQuantity(item);
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
