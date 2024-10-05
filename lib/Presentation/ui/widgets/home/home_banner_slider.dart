import 'package:carousel_slider/carousel_slider.dart';
import 'package:crafty_bay/Presentation/state_holders/slider_list_controller.dart';
import 'package:crafty_bay/Presentation/ui/utils/app_colors.dart';
import 'package:crafty_bay/Presentation/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeBannerSlider extends StatefulWidget {
  const HomeBannerSlider({
    super.key,
  });

  @override
  State<HomeBannerSlider> createState() => _HomeBannerSliderState();
}

class _HomeBannerSliderState extends State<HomeBannerSlider> {
  final ValueNotifier<int> _selectedIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SliderListController>(builder: (sliderListController) {
      return Visibility(
        visible: !sliderListController.inProgress,
        replacement: const CenteredCircularProgressIndicator(),
        child: Column(
          children: <Widget>[
            _buildCarouselSlider(sliderListController),
            const SizedBox(height: 8),
            _buildCarouselSliderDots(sliderListController),
          ],
        ),
      );
    });
  }

  Widget _buildCarouselSlider(SliderListController sliderListController) {
    return CarouselSlider(
      options: CarouselOptions(
          height: 180.0,
          viewportFraction: 1,
          onPageChanged: (index, reason) {
            _selectedIndex.value = index;
          }),
      items: sliderListController.sliders.map(
        (slider) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: AppColors.themeColor,
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                      image: NetworkImage(slider.image ?? ''), fit: BoxFit.fill),
                ),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      slider.price ?? '',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.themeColor,
                            fontWeight: FontWeight.bold,
                        fontSize: 18
                          ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: 100,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: AppColors.themeColor,
                        ),
                        onPressed: () {},
                        child: const Text("Buy now"),
                      ),
                    ),
                  ],
                ),

                // child: Row(
                //   children: [
                //     const Placeholder(
                //       fallbackHeight: 100,
                //       fallbackWidth: 100,
                //     ),
                //     Expanded(
                //       child: Column(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Text(
                //             textAlign: TextAlign.center,
                //             slider.price ?? '',
                //             style: Theme.of(context)
                //                 .textTheme
                //                 .titleLarge
                //                 ?.copyWith(
                //                   color: AppColors.whiteColor,
                //                   fontWeight: FontWeight.bold,
                //                 ),
                //           ),
                //           const SizedBox(height: 16),
                //           SizedBox(
                //             width: 100,
                //             child: ElevatedButton(
                //               style: ElevatedButton.styleFrom(
                //                   backgroundColor: Colors.white,
                //                   foregroundColor: AppColors.themeColor),
                //               onPressed: () {},
                //               child: const Text("Buy now"),
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ],
                // ),
              );
            },
          );
        },
      ).toList(),
    );
  }

  Widget _buildCarouselSliderDots(SliderListController sliderListController) {
    return ValueListenableBuilder(
      valueListenable: _selectedIndex,
      builder: (context, currentIndex, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < sliderListController.sliders.length; i++)
              Container(
                height: 12,
                width: 12,
                margin: const EdgeInsets.only(right: 4),
                decoration: BoxDecoration(
                    color: currentIndex == i ? AppColors.themeColor : null,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey)),
              ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _selectedIndex.dispose();
    super.dispose();
  }
}
