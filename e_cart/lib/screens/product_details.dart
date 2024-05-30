

import 'package:flutter/material.dart';
import 'details_card.dart';

class ProductDetails extends StatelessWidget {
  var product;
   ProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${product['topic']}'),
      ),
      body:
      Column(
        children: [
      Image.network(product['image'], fit: BoxFit.cover), // Top image
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Design apps and websites', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                DetailCard(title: "Price", description: product['price'].toString()),
                DetailCard(title: "id", description: product['id'].toString()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

