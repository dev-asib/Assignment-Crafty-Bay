import 'package:crafty_bay/Presentation/state_holders/product_list_by_category_controller.dart';
import 'package:crafty_bay/Presentation/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:crafty_bay/Presentation/ui/widgets/product_card.dart';
import 'package:crafty_bay/data/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<ProductListByCategoryController>()
        .getProductListByCategory(widget.category.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.categoryName ?? ''),
      ),
      body: GetBuilder<ProductListByCategoryController>(
          builder: (productListByCategoryController) {
        if (productListByCategoryController.inProgress) {
          return const CenteredCircularProgressIndicator();
        }

        if (productListByCategoryController.errorMessage != null) {
          return Center(
            child: Text(productListByCategoryController.errorMessage!),
          );
        }

        if (productListByCategoryController.productList.isEmpty) {
          return const Center(
            child: Text("Product List Empty."),
          );
        }

        return GridView.builder(
          itemCount: productListByCategoryController.productList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
            crossAxisSpacing: 2,
            mainAxisSpacing: 9,
          ),
          itemBuilder: (context, index) {
            return FittedBox(
              child: ProductCard(
                product: productListByCategoryController.productList[index],
              ),
            );
          },
        );
      }),
    );
  }
}
