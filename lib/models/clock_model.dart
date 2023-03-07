
import 'package:flutter/material.dart';

class ClockModel extends ChangeNotifier {

  late int _seconds;
  late int _minutes;
  late int _hours;
  late bool _isRunning;

  ClockModel.reset() {
    _seconds = 0;
    _minutes = 59;
    _hours = 8;
    _isRunning = false;
  }

  void addSecond() {
    _seconds = _seconds + 1;
    if (seconds >=60) addMinute();
    _seconds = _seconds % 60;
    notifyListeners();
  }

  void addMinute() {
    _minutes = _minutes + 1;
    if (_minutes >=60) addHour();
    _minutes = _minutes % 60;
  }

  void addHour() {
    _hours = _hours + 1;
  }

  int get seconds => _seconds;
  int get minutes => _minutes;
  int get hours => _hours;
  bool get isRunning => _isRunning;

  void set isRunning(bool isRunning) {
    _isRunning = isRunning;
  }
}