import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';  // Import dart:async for TimeoutException

import 'product_details_page.dart';

class OtherProductsGridWidget extends StatefulWidget {
  @override
  _OtherProductsGridWidgetState createState() => _OtherProductsGridWidgetState();
}

class _OtherProductsGridWidgetState extends State<OtherProductsGridWidget> {
  List<dynamic> products = [];
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http
          .get(Uri.parse('https://fakestoreapi.com/products'))
          .timeout(Duration(seconds: 10)); // Set a timeout of 10 seconds
      if (response.statusCode == 200) {
        setState(() {
          products = json.decode(response.body);
          isLoading = false;
        });
      } else {
        setState(() {
          hasError = true;
          isLoading = false;
        });
        throw Exception('Failed to load products');
      }
    } on http.ClientException catch (e) {
      setState(() {
        hasError = true;
        isLoading = false;
      });
      print('Error: $e');
    } on TimeoutException catch (_) {
      setState(() {
        hasError = true;
        isLoading = false;
      });
      print('Error: Request timed out');
    } catch (e) {
      setState(() {
        hasError = true;
        isLoading = false;
      });
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (hasError) {
      return Center(child: Text('Failed to load products. Please try again.'));
    }

    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.7,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailsPage(product: product),
              ),
            );
          },
          child: Card(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    product['image'],
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product['title'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ), // Display product title
                        //Text(product['description']), // Display product description
                        Text('\$${product['price']}'), // Display product price
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
