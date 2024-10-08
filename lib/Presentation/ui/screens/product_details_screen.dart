import 'package:crafty_bay/Presentation/state_holders/auth_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/product_details_controller.dart';
import 'package:crafty_bay/Presentation/ui/screens/email_verification_screen.dart';
import 'package:crafty_bay/Presentation/ui/screens/reviews_screen.dart';
import 'package:crafty_bay/Presentation/ui/utils/app_colors.dart';
import 'package:crafty_bay/Presentation/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:crafty_bay/Presentation/ui/widgets/size_picker.dart';
import 'package:crafty_bay/Presentation/ui/widgets/widgets.dart';
import 'package:crafty_bay/data/models/product_details_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:item_count_number_button/item_count_number_button.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({
    super.key,
    required this.id,
  });

  final int id;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<ProductDetialsController>().getProductDetails(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text("Product Details"),
      ),
      body: GetBuilder<ProductDetialsController>(
          builder: (productDetailsController) {
        if (productDetailsController.inProgress) {
          return const CenteredCircularProgressIndicator();
        }

        if (productDetailsController.errorMessage != null) {
          return Center(
            child: Text(productDetailsController.errorMessage!),
          );
        }

        return Column(
          children: [
            Expanded(
              child: _buildProductDetails(
                  productDetailsController.productDetailsModel!),
            ),
            _buildPriceAndAddToCartSection(
                productDetailsController.productDetailsModel!)
          ],
        );
      }),
    );
  }

  Widget _buildProductDetails(ProductDetailsModel productDetails) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ProductImageSlider(
            sliderUrls: [
              productDetails.img1!,
              productDetails.img2!,
              productDetails.img3!,
              productDetails.img4!,
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildNameAndQuantitySection(productDetails),
                const SizedBox(height: 4),
                _buildRatingAndReviewSection(productDetails),
                const SizedBox(height: 8),
                // ColorPicker(
                //   colors: const [
                //     Colors.green,
                //     Colors.red,
                //     Colors.blue,
                //     Colors.black,
                //   ],
                //   onColorSelected: (color) {},
                // ),
                SizePicker(
                  sizes: productDetails.color!.split(','),
                  onSizeSelected: (String selectedSize) {},
                ),
                const SizedBox(height: 16),
                SizePicker(
                  sizes: productDetails.size!.split(','),
                  onSizeSelected: (String selectedSize) {},
                ),
                const SizedBox(height: 16),
                _buildDescriptionSection(productDetails),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection(ProductDetailsModel productDetails) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Description",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Text(
          productDetails.product?.shortDes ?? '',
          style: const TextStyle(color: Colors.black45),
        ),
      ],
    );
  }

  Widget _buildNameAndQuantitySection(ProductDetailsModel productDetails) {
    return Row(
      children: [
        Expanded(
          child: Text(
            productDetails.product?.title ?? '',
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

  Widget _buildRatingAndReviewSection(ProductDetailsModel productDetails) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            Text(
              "${productDetails.product?.star ?? ''}",
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
          ],
        ),
        const SizedBox(width: 8),
        TextButton(
          onPressed: _onTapReviewButton,
          child: const Text(
            "Review",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.themeColor,
            ),
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

  Widget _buildPriceAndAddToCartSection(ProductDetailsModel productDetails) {
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Price'),
              Text(
                '\$${productDetails.product?.price}',
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: AppColors.themeColor),
              ),
            ],
          ),
          SizedBox(
            width: 140,
            child: ElevatedButton(
              onPressed: _onTapAddToCart,
              child: const Text("Add To Cart"),
            ),
          ),
        ],
      ),
    );
  }

  void _onTapAddToCart() async {
    bool isLoggedInUser = await Get.find<AuthController>().isLoginUser();

    if (isLoggedInUser) {

    } else {
      Get.to(
        () => const EmailVerificationScreen(),
      );
    }
  }

  void _onTapReviewButton() {
    Get.to(() => const ReviewsScreen());
  }
}

