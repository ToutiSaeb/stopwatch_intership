import 'dart:async';

import 'package:get/get.dart';

class StopwatchController extends GetxController {
  var elapsedTime = 0.obs; 
  Stopwatch stopwatch = Stopwatch();
  Timer? _timer;
  var laps = <String>[].obs;
  var isRunning = false.obs;

  void toggleStopwatch() {
    if (stopwatch.isRunning) {
 
      _timer?.cancel();
      stopwatch.stop();
      isRunning.value = false;
    } else {
     
      stopwatch.start();
      isRunning.value = true;
      _timer = Timer.periodic(Duration(milliseconds: 30), (Timer timer) {
        elapsedTime.value = stopwatch.elapsedMilliseconds;
      });
    }
  }

  void resetStopwatch() {
    _timer?.cancel();
    stopwatch.reset();
    elapsedTime.value = 0; 
    laps.clear();
    isRunning.value = false;
  }

  void recordLap() {
    var minutes = (elapsedTime.value ~/ 60000).toString().padLeft(2, '0');
    var seconds = ((elapsedTime.value % 60000) ~/ 1000).toString().padLeft(2, '0');
    var milliseconds = (elapsedTime.value % 1000).toString().padLeft(3, '0');
    laps.add('$minutes:$seconds.$milliseconds');
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}