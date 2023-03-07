import 'package:clocks/models/app_model.dart';
import 'package:clocks/models/clock_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



late BuildContext _mainContext;
// The commands will use this to access the Provided models and services.
void init(BuildContext c) => _mainContext = c;

// Provide quick lookup methods for all the top-level models and services. Keeps the Command code slightly cleaner.
class BaseCommand {
  // Models
  AppModel appModel = _mainContext.read();
  ClockModel clockModel = _mainContext.read();

// Services
//UserService userService = _mainContext.read();
}