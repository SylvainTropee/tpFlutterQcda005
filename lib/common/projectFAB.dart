import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/project.dart';
import '../providers/project-provider.dart';

class ProjectFAB extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    void _addProject() {
      int index = context.read<ProjectProvider>().projects.length + 1;
      context.read<ProjectProvider>().addProject(
        Project(title: "Nouveau projet $index", desc: "Nouveau projet"),
      );
    }

    return FloatingActionButton(
      onPressed: _addProject,
      child: Icon(Icons.add, size: 40),
    );
  }
}
