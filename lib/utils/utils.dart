import 'dart:math';
import 'package:flutter/material.dart';

Random random = new Random();


String formatTimer(int h, int m) {
  return "${(h < 10 ? '0' : '') + h.toString()}:${(m < 10 ? '0' : '') + m.toString()}";
}


extension HypotenuseX on num {
  double get hypotenuse => sqrt(this*this + this*this);
}


int randInt(int min, int max) {
  // [min; max[
  return min + random.nextInt(max - min);
}

Size getScreenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

double screenHeight(BuildContext context, {double dividedBy = 1}) {
  return getScreenSize(context).height / dividedBy;
}

double screenWidth(BuildContext context, {double dividedBy = 1}) {
  return getScreenSize(context).width / dividedBy;
}
