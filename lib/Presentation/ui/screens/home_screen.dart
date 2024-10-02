import 'package:crafty_bay/Presentation/state_holders/category_list_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/main_bottom_nav_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/new_product_list_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/popular_product_list_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/special_product_list_controller.dart';
import 'package:crafty_bay/Presentation/ui/utils/assets_path.dart';
import 'package:crafty_bay/Presentation/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:crafty_bay/Presentation/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 16),
              SearchTextField(textEditingController: TextEditingController()),
              const SizedBox(height: 16),
              const HomeBannerSlider(),
              const SizedBox(height: 16),
              _buildCategoriesSection(),
              _buildPopularProductSection(),
              const SizedBox(height: 16),
              _buildNewProductSection(),
              const SizedBox(height: 16),
              _buildSpecialProductSection(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNewProductSection() {
    return Column(
      children: [
        SectionHeader(title: "New", onTap: () {}),
        SizedBox(
          height: 180,
          child: GetBuilder<NewProductListController>(
              builder: (newProductListController) {
            return Visibility(
              visible: !newProductListController.inProgress,
              replacement: const CenteredCircularProgressIndicator(),
              child: HorizontalProductListView(
                productList: newProductListController.productList,
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildSpecialProductSection() {
    return Column(
      children: [
        SectionHeader(title: "Special", onTap: () {}),
        SizedBox(
          height: 180,
          child: GetBuilder<SpecialProductListController>(
              builder: (specialProductListController) {
                return Visibility(
                  visible: !specialProductListController.inProgress,
                  replacement: const CenteredCircularProgressIndicator(),
                  child: HorizontalProductListView(
                    productList: specialProductListController.productList,
                  ),
                );
              }),
        ),
      ],
    );
  }

  Widget _buildPopularProductSection() {
    return Column(
      children: [
        SectionHeader(title: "Popular", onTap: () {}),
        SizedBox(
          height: 180,
          child: GetBuilder<PopularProductListController>(
              builder: (popularProductListController) {
                return Visibility(
                  visible: !popularProductListController.inProgress,
                  replacement: const CenteredCircularProgressIndicator(),
                  child: HorizontalProductListView(
                    productList: popularProductListController.productList,
                  ),
                );
              }),
        ),
      ],
    );
  }

  Widget _buildCategoriesSection() {
    return Column(
      children: [
        SectionHeader(
            title: "Categories",
            onTap: () {
              Get.find<MainBottomNavController>().selectCategory();
            }),
        const SizedBox(height: 8),
        SizedBox(
          height: 120,
          child: GetBuilder<CategoryListController>(
              builder: (categoryListController) {
            return Visibility(
              visible: !categoryListController.inProgress,
              replacement: const CenteredCircularProgressIndicator(),
              child: HorizontalCategoryListView(
                categoryList: categoryListController.categoryList,
              ),
            );
          }),
        ),
      ],
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: SvgPicture.asset(AssetsPath.appLogoNav),
      actions: [
        AppBarIconButton(
          onTap: () {},
          iconData: Icons.person,
        ),
        const SizedBox(width: 8),
        AppBarIconButton(
          onTap: () {},
          iconData: Icons.call,
        ),
        const SizedBox(width: 8),
        AppBarIconButton(
          onTap: () {},
          iconData: Icons.notifications_active_outlined,
        ),
      ],
    );
  }
}
