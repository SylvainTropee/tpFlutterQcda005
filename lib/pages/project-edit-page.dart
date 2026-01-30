import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tp_flutter_qcda005/common/project-form.dart';
import 'package:tp_flutter_qcda005/models/project.dart';

class ProjectEditPage extends StatelessWidget {
  final Project project;

  const ProjectEditPage({required this.project, super.key});

  void _onUpdateProject(BuildContext context, Project project) {
    context.go("/");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Projet ${project.title} modifié !")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(project.title), centerTitle: true),
      body: ProjectForm(
        project: project,
      ),
    );
  }
}
