import 'package:flutter/material.dart';
import 'package:tp_flutter_qcda005/models/project.dart';
import 'package:tp_flutter_qcda005/pages/contribution-page.dart';
import 'package:tp_flutter_qcda005/pages/projects-page.dart';

import 'common/projectFAB.dart';

void main() {
  runApp(const ProjectManhattanApp());
}

class ProjectManhattanApp extends StatelessWidget {
  const ProjectManhattanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Gestion des projets",
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Color(0xffeceaea),
        appBarTheme: AppBarTheme(backgroundColor: Colors.indigo),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        title: Text("Mes Projets"),
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
          : ContributionPage(onSubmitForm: onSubmitForm),
    );
  }
}
