import 'package:flutter/material.dart';
import 'package:tp_flutter_qcda005/models/project.dart';

class ProjectsPage extends StatelessWidget {
  final List<Project> _projects;

  const ProjectsPage({required projects}) : _projects = projects;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsetsGeometry.all(16),
      itemCount: _projects.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            leading: Icon(Icons.work_outline, color: Colors.indigo),
            trailing: Icon(Icons.arrow_forward_ios_outlined),
            title: Text(_projects[index].title),
            subtitle: Text(_projects[index].desc),
          ),
        );
      },
    );
  }
}
