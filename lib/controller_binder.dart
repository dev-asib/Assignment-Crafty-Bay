import 'package:crafty_bay/Presentation/state_holders/main_bottom_nav_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/otp_verification_controller.dart';
import 'package:get/get.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => MainBottomNavController(),
    );
    Get.lazyPut(
      () => OTPVerificationController(),
    );
  }
}
