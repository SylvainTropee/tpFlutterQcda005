import 'package:flutter/material.dart';

import '../models/project.dart';

class ProjectProvider extends ChangeNotifier {
  List<Project> _projects = [
    Project(title: "Projet Manhattan", desc: "Un projet vraiment énorme"),
    Project(title: "Projet important", desc: "Un projet très important"),
  ];

  List<Project> get projects => _projects;

  set projects(List<Project> value) {
    _projects = value;
  }

  void updateProject(Project project){
   for(int i = 0; i < _projects.length; i++){
     if(_projects[i].key == project.key){
       _projects[i] = project;
     }
   }
   notifyListeners();
  }

  void addProject(Project project){
    _projects.add(project);
    notifyListeners();
  }



}
