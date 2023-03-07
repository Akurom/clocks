
import 'package:clocks/models/client_model.dart';
import 'package:clocks/models/session_model.dart';
import 'package:flutter/material.dart';

class ProjectModel extends ChangeNotifier {

  late String _name;
  late ClientModel _client;
  late List<String> _tasks = [];
  late List<SessionModel> _sessions = [];
}