import 'package:crafty_bay/Presentation/state_holders/otp_verification_controller.dart';
import 'package:crafty_bay/Presentation/ui/screens/complete_profile_screen.dart';
import 'package:crafty_bay/Presentation/ui/utils/app_colors.dart';
import 'package:crafty_bay/Presentation/ui/widgets/app_logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPVerificationScreen extends StatefulWidget {
  const OTPVerificationScreen({super.key});

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final TextEditingController _otpTEController = TextEditingController();

  final OTPVerificationController otpVerificationController =
      OTPVerificationController();

  @override
  void initState() {
    super.initState();
    otpVerificationController.startTimer();
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
              ElevatedButton(
                onPressed: _onTapNextButton,
                child: const Text("Next"),
              ),
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
                        text: "${otpVerificationController.remainingSeconds}",
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
                  onPressed: otpVerificationController.remainingSeconds > 0
                      ? null
                      : () {
                          otpVerificationController.resetTimer();
                        },
                  child: Text(
                    "Resend Code",
                    style: TextStyle(
                      color: otpVerificationController.remainingSeconds > 0
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

  void _onTapNextButton() {
    Get.to(()=> const CompleteProfileScreen());
  }

  @override
  void dispose() {
    otpVerificationController.onClose();
    super.dispose();
  }
}
