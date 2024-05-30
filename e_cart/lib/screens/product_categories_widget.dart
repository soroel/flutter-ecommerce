import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../cotrollers/productController.dart';

class ProductCategoriesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.find();

    return Obx(() {
      if (productController.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      } else if (productController.categoryList.isEmpty) {
        return Center(child: Text('No categories found'));
      } else {
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.5,
          ),
          itemCount: productController.categoryList.length,
          itemBuilder: (context, index) {
            String category = productController.categoryList[index];
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    category,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            );
          },
        );
      }
    });
  }
}
