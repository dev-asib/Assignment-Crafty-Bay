import 'package:carousel_slider/carousel_slider.dart';
import 'package:crafty_bay/Presentation/ui/utils/app_colors.dart';
import 'package:crafty_bay/Presentation/ui/utils/assets_path.dart';
import 'package:flutter/material.dart';

class ProductImageSlider extends StatefulWidget {
  const ProductImageSlider({
    super.key,
  });

  @override
  State<ProductImageSlider> createState() => _ProductImageSliderState();
}

class _ProductImageSliderState extends State<ProductImageSlider> {
  final ValueNotifier<int> _selectedIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CarouselSlider(
          options: CarouselOptions(
            height: 220.0,
            onPageChanged: (index, reason) {
              _selectedIndex.value = index;
            },
            viewportFraction: 1,
          ),
          items: [1, 2, 3, 4, 5].map(
            (i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      image: const DecorationImage(
                        image: AssetImage(AssetsPath.dummyProductImage),
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    alignment: Alignment.center,
                  );
                },
              );
            },
          ).toList(),
        ),
        Positioned(
          bottom: 12,
          left: 0,
          right: 0,
          child: ValueListenableBuilder(
            valueListenable: _selectedIndex,
            builder: (context, currentIndex, _) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < 5; i++)
                    Container(
                      height: 12,
                      width: 12,
                      margin: const EdgeInsets.only(right: 4),
                      decoration: BoxDecoration(
                        color: currentIndex == i
                            ? AppColors.themeColor
                            : Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _selectedIndex.dispose();
    super.dispose();
  }
}
