import 'package:crafty_bay/Presentation/state_holders/auth_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/category_list_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/email_verification_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/main_bottom_nav_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/new_product_list_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/otp_verification_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/popular_product_list_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/product_details_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/product_list_by_category_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/slider_list_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/special_product_list_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/timer_controller.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(MainBottomNavController());
    Get.put(TimerController());
    Get.put(Logger());
    Get.put(NetworkCaller(logger: Get.find<Logger>()));
    Get.put(SliderListController());
    Get.put(CategoryListController());
    Get.put(NewProductListController());
    Get.put(PopularProductListController());
    Get.put(SpecialProductListController());
    Get.put(ProductListByCategoryController());
    Get.put(ProductDetialsController());
    Get.put(AuthController());
    Get.put(EmailVerificationController());
    Get.put(OtpVerificationController());
  }
}
