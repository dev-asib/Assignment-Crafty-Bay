import 'dart:async';

import 'package:get/get.dart';

class TimerController extends GetxController {
  static const int initialSeconds = 5;
  final RxInt _remainingSeconds = initialSeconds.obs;
  Timer? _timer;

  int get remainingSeconds => _remainingSeconds.value;

  bool isTimerActive() => _timer != null && _timer!.isActive;

  void startTimer() {
    if (isTimerActive()) return;
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (_remainingSeconds.value > 0) {
          _remainingSeconds.value--;
        } else {
          stopTimer();
        }
      },
    );
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  void onClose() {
    stopTimer();
    super.onClose();
  }

  void resetTimer() {
    stopTimer();
    _remainingSeconds.value = initialSeconds;
    startTimer();
  }
}
