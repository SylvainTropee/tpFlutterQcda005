import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tp_flutter_qcda005/common/project-form.dart';
import 'package:tp_flutter_qcda005/models/project.dart';

import '../common/projectFAB.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Project> _projects = [
    Project(title: "Projet Manhattan", desc: "Un projet vraiment énorme"),
    Project(title: "Projet important", desc: "Un projet très important"),
  ];

  void _addProject() {
    int index = _projects.length + 1;
    setState(() {
      _projects.add(
        Project(title: "Nouveau projet $index", desc: "Nouveau projet"),
      );
    });
  }

  void onSubmitForm(Project project) {
    setState(() {
      _projects.add(project);
      _selectedIndex = 0;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Le projet ${project.title} a été ajouté !")),
    );
  }

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ProjectFAB(addProject: _addProject),
      appBar: AppBar(
        title: Text(_selectedIndex == 0 ? "Mes Projets" : "Contribuer"),
        centerTitle: true,
        leading: Icon(Icons.rocket_launch),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.folder_open),
            label: "Projets",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: "Contribuer",
          ),
        ],
      ),
      body: _selectedIndex == 0
          ? ProjectsPage(projects: _projects)
          : ProjectForm(onSubmitForm: onSubmitForm),
    );
  }
}

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
            onTap: () {
              context.push("/detail", extra: _projects[index]);
            },
          ),
        );
      },
    );
  }
}
