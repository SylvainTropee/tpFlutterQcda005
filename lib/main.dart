import 'package:flutter/material.dart';
import 'package:tp_flutter_qcda005/models/project.dart';

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
        primarySwatch : Colors.indigo,
        scaffoldBackgroundColor: Color(0xffeceaea),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.indigo,
        )
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<Project> _projects = [
    Project(title: "Projet Manhattan", desc: "Un projet vraiment énorme"),
    Project(title: "Projet important", desc: "Un projet très important"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mes Projets"),
        centerTitle: true,
        leading: Icon(Icons.rocket_launch),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
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
      body: ListView.builder(
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
      ),
    );
  }
}
