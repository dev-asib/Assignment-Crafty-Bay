import 'package:crafty_bay/Presentation/ui/utils/app_colors.dart';
import 'package:crafty_bay/Presentation/ui/widgets/color_picker.dart';
import 'package:crafty_bay/Presentation/ui/widgets/size_picker.dart';
import 'package:crafty_bay/Presentation/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:item_count_number_button/item_count_number_button.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text("Product Details"),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildProductDetails(),
          ),
          _buildPriceAndAddToCartSection()
        ],
      ),
    );
  }

  Widget _buildProductDetails() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const ProductImageSlider(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildNameAndQuantitySection(),
                const SizedBox(height: 4),
                _buildRatingAndReviewSection(),
                const SizedBox(height: 8),
                ColorPicker(
                  colors: const [
                    Colors.green,
                    Colors.red,
                    Colors.blue,
                    Colors.black,
                  ],
                  onColorSelected: (color) {},
                ),
                const SizedBox(height: 16),
                SizePicker(
                  sizes: const [
                    'S',
                    'M',
                    'L',
                    'XL',
                    "XXL",
                  ],
                  onSizeSelected: (String selectedSize) {},
                ),
                const SizedBox(height: 16),
                _buildDescriptionSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Description",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        const Text(
          '''Item Count Number Button is a Flutter package that allows you to easily implement a customizable item count widget with increment and decrement buttons. Item Count Number Button is a Flutter package that allows you to easily implement a customizable item count widget with increment and decrement buttons. This widget is particularly useful in scenarios where you need to manage the quantity of items, such as in a shopping cart or inventory management system.''',
          style: TextStyle(color: Colors.black45),
        ),
      ],
    );
  }

  Widget _buildNameAndQuantitySection() {
    return Row(
      children: [
        Expanded(
          child: Text(
            "Nike show 2024 latest model - Happy new year special deal.",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        ItemCount(
          initialValue: 1,
          minValue: 1,
          maxValue: 10,
          decimalPlaces: 0,
          color: AppColors.themeColor,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          onChanged: (value) {},
        ),
      ],
    );
  }

  Widget _buildRatingAndReviewSection() {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        const Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Icon(
              Icons.star,
              color: Colors.amber,
            ),
            Text(
              "4.2",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
          ],
        ),
        const SizedBox(width: 8),
        const Text(
          "Review",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: AppColors.themeColor,
          ),
        ),
        const SizedBox(width: 8),
        Card(
          color: AppColors.themeColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Padding(
            padding: EdgeInsets.all(4.0),
            child: Icon(
              Icons.favorite_outline,
              size: 16,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildPriceAndAddToCartSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.themeColor.withOpacity(0.1),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Price'),
              Text(
                '\$100',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: AppColors.themeColor),
              ),
            ],
          ),
          SizedBox(
            width: 140,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text("Add To Cart"),
            ),
          ),
        ],
      ),
    );
  }
}
