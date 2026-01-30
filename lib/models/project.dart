import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:tp_flutter_qcda005/models/task.dart';

enum ProjectStatus { inProgress, done, upComing }

class Project {
  Key _key;
  String _title;
  String _desc;
  ProjectStatus _status;
  DateTime? _date;
  List<Task> _tasks = [];

  Project({
    required String title,
    required String desc,
    ProjectStatus status = ProjectStatus.upComing,
    DateTime? date,
  }) : _key = UniqueKey(),
       _title = title,
       _desc = desc,
       _status = status,
       _date = date;


  Key get key => _key;

  set key(Key value) {
    _key = value;
  }

  ProjectStatus get status => _status;

  set status(ProjectStatus value) {
    _status = value;
  }

  String get desc => _desc;

  set desc(String value) {
    _desc = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  DateTime? get date => _date;

  set date(DateTime? value) {
    _date = value;
  }

  List<Task> get tasks => _tasks;

  set tasks(List<Task> value) {
    _tasks = value;
  }

  Future<void> initTasks() async {
    if (_tasks.isEmpty) {
      var response = await http.get(
        Uri.parse("https://jsonplaceholder.typicode.com/users/1/todos"),
      );
      _tasks = List.from(
        jsonDecode(response.body).map((t) => Task.fromJson(t)),
      );
    }
  }

  @override
  String toString() {
    return 'Project{_title: $_title, _desc: $_desc, _status: $_status, _date: $_date}';
  }
}
