import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tp_flutter_qcda005/models/project.dart';
import 'package:tp_flutter_qcda005/pages/project-detail-page.dart';
import 'package:tp_flutter_qcda005/pages/home-page.dart';
import 'package:tp_flutter_qcda005/pages/project-edit-page.dart';
import 'package:tp_flutter_qcda005/providers/navigation-provider.dart';
import 'package:tp_flutter_qcda005/providers/project-provider.dart';
import 'package:url_strategy/url_strategy.dart';

import 'common/projectFAB.dart';

void main() {
  setPathUrlStrategy();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProjectProvider()),
        ChangeNotifierProvider(create: (_) => NavigationProvider(0)),
      ],
      child: const ProjectManhattanApp(),
    ),
  );
}

final GoRouter _router = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(path: "/", builder: (context, state) => HomePage()),
    GoRoute(
      path: "/detail",
      builder: (context, state) {
        Project project = state.extra as Project;
        return ProjectDetailPage(project: project);
      },
    ),
    GoRoute(
      path: "/edit",
      builder: (context, state) {
        Project project = state.extra as Project;
        return ProjectEditPage(project: project);
      },
    ),
  ],
);

class ProjectManhattanApp extends StatelessWidget {
  const ProjectManhattanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: "Gestion des projets",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Color(0xffeceaea),
        appBarTheme: AppBarTheme(backgroundColor: Colors.indigo),
      ),
    );
  }
}
