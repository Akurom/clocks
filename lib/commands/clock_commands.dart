import 'dart:async';
import 'dart:developer';

import 'package:clocks/commands/base_command.dart';

class ClockCommands extends BaseCommand {
  DateTime _now = DateTime.now();
  late Timer _timer;

  void _updateTime() {
    _now = DateTime.now();
    _timer = Timer(const Duration(seconds: 1) - Duration(milliseconds: _now.millisecond), () {
      if (clockModel.isRunning) {
        clockModel.addSecond();
        _updateTime();
      } else {
        _timer.cancel();
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
