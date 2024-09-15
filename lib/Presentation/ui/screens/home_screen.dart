import 'package:crafty_bay/Presentation/ui/utils/assets_path.dart';
import 'package:crafty_bay/Presentation/ui/widgets/app_bar_icon.dart';
import 'package:crafty_bay/Presentation/ui/widgets/category_item.dart';
import 'package:crafty_bay/Presentation/ui/widgets/home_banner_slider.dart';
import 'package:crafty_bay/Presentation/ui/widgets/search_text_field.dart';
import 'package:crafty_bay/Presentation/ui/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            SearchTextField(textEditingController: TextEditingController()),
            const SizedBox(height: 16),
            const HomeBannerSlider(),
            const SizedBox(height: 16),
            HeaderSection(title: "Category", onTap: () {}),
            const SizedBox(height: 8),
            _buildCategoriesSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoriesSection() {
    return SizedBox(
      height: 140,
      child: _buildCategoriesListView(),
    );
  }

  Widget _buildCategoriesListView() {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: 10,
      itemBuilder: (context, index) {
        return const CategoryItem(
          iconData: Icons.computer,
          label: 'Electronics',
        );
      },
      separatorBuilder: (_, __) {
        return const SizedBox(width: 8);
      },
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
