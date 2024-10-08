import 'package:crafty_bay/Presentation/state_holders/otp_verification_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/timer_controller.dart';
import 'package:crafty_bay/Presentation/ui/screens/complete_profile_screen.dart';
import 'package:crafty_bay/Presentation/ui/utils/app_colors.dart';
import 'package:crafty_bay/Presentation/ui/utils/snack_message.dart';
import 'package:crafty_bay/Presentation/ui/widgets/app_logo_widget.dart';
import 'package:crafty_bay/Presentation/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPVerificationScreen extends StatefulWidget {
  const OTPVerificationScreen({
    super.key,
    required this.email,
  });

  final String email;

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final TextEditingController _otpTEController = TextEditingController();

  final TimerController _timerController = Get.find<TimerController>();
  final OtpVerificationController _otpVerificationController =
      Get.find<OtpVerificationController>();

  @override
  void initState() {
    super.initState();
    _timerController.startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 82),
              const AppLogoWidget(),
              const SizedBox(height: 24),
              Text(
                "Enter OTP Code",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 8),
              Text(
                "A 4 digit OTP code has been sent..",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.black45,
                    ),
              ),
              const SizedBox(height: 24),
              PinCodeTextField(
                length: 6,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor: Colors.white,
                  selectedColor: Colors.green,
                  selectedFillColor: Colors.white,
                  inactiveFillColor: Colors.white,
                  inactiveColor: AppColors.themeColor,
                ),
                animationDuration: const Duration(milliseconds: 300),
                backgroundColor: Colors.transparent,
                enableActiveFill: true,
                controller: _otpTEController,
                appContext: context,
              ),
              const SizedBox(height: 8),
              GetBuilder<OtpVerificationController>(
                  builder: (otpVerificationController) {
                return Visibility(
                  visible: !otpVerificationController.inProgress,
                  replacement: const CenteredCircularProgressIndicator(),
                  child: ElevatedButton(
                    onPressed: _onTapNextButton,
                    child: const Text("Next"),
                  ),
                );
              }),
              const SizedBox(height: 16),
              Obx(
                () => RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey,
                        ),
                    text: "The code will be expire ",
                    children: [
                      TextSpan(
                        text: "${_timerController.remainingSeconds}",
                        style: const TextStyle(
                          color: AppColors.themeColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Obx(
                () => TextButton(
                  onPressed: _timerController.remainingSeconds > 0
                      ? null
                      : () {
                          _timerController.resetTimer();
                        },
                  child: Text(
                    "Resend Code",
                    style: TextStyle(
                      color: _timerController.remainingSeconds > 0
                          ? Colors.grey
                          : AppColors.themeColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onTapNextButton() async {
    bool result = await _otpVerificationController.verifyOtp(
      widget.email,
      _otpTEController.text,
    );

    if (result) {
      Get.to(() => const CompleteProfileScreen());
    } else {
      if (mounted) {
        showSnackBarMessage(
          context,
          _otpVerificationController.errorMessage!,
        );
      }
    }
  }

  @override
  void dispose() {
    _timerController.onClose();
    super.dispose();
  }
}
