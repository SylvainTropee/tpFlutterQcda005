import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tp_flutter_qcda005/common/project-form.dart';
import 'package:tp_flutter_qcda005/models/project.dart';
import 'package:tp_flutter_qcda005/providers/project-provider.dart';

import '../common/projectFAB.dart';
import '../providers/navigation-provider.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void _onItemTap(int index){
    context.read<NavigationProvider>().selectedIndex = index;
  }

  @override
  Widget build(BuildContext context) {

    final _selectedIndex = context.watch<NavigationProvider>().selectedIndex;

    return Scaffold(
      floatingActionButton: ProjectFAB(),
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
      body: _selectedIndex == 0 ? ProjectsPage() : ProjectForm(),
    );
  }
}

class ProjectsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final _projects = context.watch<ProjectProvider>().projects;

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
