import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tp_flutter_qcda005/models/project.dart';

class ProjectDetailPage extends StatelessWidget {
  final Project project;

  const ProjectDetailPage({required this.project, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(project.title),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              context.push('/edit', extra: project);
            },
            icon: Icon(Icons.mode),
          ),
        ],
      ),
      body: Column(
        children: [
          switch (project.status) {
            ProjectStatus.inProgress => Text(
              "Statut : en cours",
              style: TextStyle(color: Colors.amber),
            ),
            ProjectStatus.done => Text(
              "Statut : terminée",
              style: TextStyle(color: Colors.amber),
            ),
            ProjectStatus.upComing => Text(
              "Statut : a venir",
              style: TextStyle(color: Colors.amber),
            ),
          },
          Text(
            "Date de début : ${project.date?.day}/${project.date?.month}/${project.date?.year}",
            style: TextStyle(color: Colors.black),
          ),
          Text(project.desc, style: TextStyle(color: Colors.black)),
        ],
      ),
    );
  }
}
