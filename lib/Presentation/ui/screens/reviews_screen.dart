import 'package:crafty_bay/Presentation/ui/screens/create_review_screen.dart';
import 'package:crafty_bay/Presentation/ui/utils/app_colors.dart';
import 'package:crafty_bay/Presentation/ui/widgets/review_screen/review_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildReviewSection(),
          _totalReviewsAndAddReviewButton(),
        ],
      ),
    );
  }

  Widget _buildReviewSection() {
    return Expanded(
      child: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          return const ReviewCard(
            userName: "Asib",
            reviewText:
                "Reference site about Lorem Ipsum, giving information on its origins, as well as a random Lipsum generator Reference site about Lorem Ipsum, giving information on its origins, as well as a random Lipsum generator",
          );
        },
      ),
    );
  }

  Widget _totalReviewsAndAddReviewButton() {
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
              Text(
                'Reviews (1000)',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          FloatingActionButton(
            onPressed: _onTapAddButton,
            child: const Icon(
              Icons.add,
              size: 35,
            ),
          ),
        ],
      ),
    );
  }

  void _onTapAddButton() {
    Get.to(() => const CreateReviewScreen());
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios)),
      title: const Text("Reviews"),
    );
  }
}
