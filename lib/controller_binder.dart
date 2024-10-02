import 'package:crafty_bay/Presentation/state_holders/category_list_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/main_bottom_nav_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/new_product_list_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/otp_verification_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/popular_product_list_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/slider_list_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/special_product_list_controller.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainBottomNavController());
    Get.lazyPut(() => OTPVerificationController());
    Get.put(Logger());
    Get.put(NetworkCaller(logger: Get.find<Logger>()));
    Get.lazyPut(() => SliderListController());
    Get.lazyPut(() => CategoryListController());
    Get.lazyPut(() => NewProductListController());
    Get.lazyPut(() => PopularProductListController());
    Get.lazyPut(() => SpecialProductListController());
  }
}
