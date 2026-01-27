import 'package:flutter/material.dart';

class ProjectFAB extends StatelessWidget {
  void Function() _addProject;

  ProjectFAB({required addProject}) : _addProject = addProject;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: _addProject,
      child: Icon(Icons.add, size: 40),
    );
  }
}
