import 'dart:async';
import 'dart:developer';

import 'package:clocks/commands/base_command.dart';

class ClockCommands extends BaseCommand {
  DateTime _now = DateTime.now();
  late Timer _timer;

  void _updateTime() {
    _now = DateTime.now();
    // Update once per second. Make sure to do it at the beginning of each
    // new second, so that the clock is accurate.
    _timer = Timer(const Duration(seconds: 1) - Duration(milliseconds: _now.millisecond), () {

      if (clockModel.isRunning) {
        clockModel.addSecond();
        _updateTime();
      }
    });
  }

  Future<void> start() async {
    log('Clock started.');
    clockModel.isRunning = true;
    _updateTime();
  }

  Future<void> stop() async {
    log('Clock stopped.');
    clockModel.isRunning = false;
    //_timer.cancel();
  }
}
