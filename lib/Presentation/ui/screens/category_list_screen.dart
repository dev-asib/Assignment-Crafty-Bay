import 'package:crafty_bay/Presentation/state_holders/category_list_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/main_bottom_nav_controller.dart';
import 'package:crafty_bay/Presentation/ui/widgets/category_card.dart';
import 'package:crafty_bay/Presentation/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryListScreen extends StatelessWidget {
  const CategoryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (dipPop, result) {
        _backToHome();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: _backToHome,
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title: const Text("Categories"),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            Get.find<CategoryListController>().getCategoryList();
          },
          child: GetBuilder<CategoryListController>(
              builder: (categoryListController) {
            if (categoryListController.inProgress) {
              return const CenteredCircularProgressIndicator();
            } else if (categoryListController.errorMessage != null) {
              return Center(
                child: Text(categoryListController.errorMessage!),
              );
            } else if (categoryListController.categoryList.isEmpty) {
              return const Center(
                child: Text("Category List Empty."),
              );
            }
            return GridView.builder(
              itemCount: categoryListController.categoryList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 0.75,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                return CategoryCard(
                  categoryModel: categoryListController.categoryList[index],
                );
              },
            );
          }),
        ),
      ),
    );
  }

  void _backToHome() {
    Get.find<MainBottomNavController>().backToHome();
  }
}
