import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../cotrollers/productController.dart';
import 'products_grid_widget.dart';
import 'profile.dart';
import 'search_bar_widget.dart';
import 'CartItems.dart';

class HomePage extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    productController.fetchAllCategories();

    return Scaffold(
      appBar: AppBar(
        title: Text("Product Categories"),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Get.to(()=> CartPage());
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          SearchBarWidget(),
          SizedBox(height: 20), // Spacer
          // Product Categories
          Obx(() {
            if (productController.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Container(
                width: 600,
                height: 60,
                child: ListView.builder(
                  //shrinkWrap:false,
                  scrollDirection: Axis.horizontal,
                  itemCount: productController.categoryList.length,
                  itemBuilder: (context, index) {
                    String category = productController.categoryList[index];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(category),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          }),
          SizedBox(height: 20), // Spacer
          // Other Products Grid
          Expanded(
            flex: 2,
            child: OtherProductsGridWidget(),
          ),
        ],
      ),
    );
  }
}
