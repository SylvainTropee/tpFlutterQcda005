import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tp_flutter_qcda005/models/project.dart';
import 'package:tp_flutter_qcda005/models/task.dart';

class ProjectDetailPage extends StatefulWidget {
  final Project project;

  const ProjectDetailPage({required this.project, super.key});

  @override
  State<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadTasks();
  }

  Future<void> loadTasks() async {
    await widget.project.initTasks();
    setState(() {});
  }

  void showAddDetailDialog(Task task) {
    TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Ajouter un détail ${task.name}"),
        content: TextField(
          decoration: InputDecoration(labelText: "Détail :"),
          controller: controller,
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: Text("Annuler"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                task.details.add(controller.text.trim());
              });
              context.pop();
            },
            child: Text("Ajouter"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.project.title),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              context.push('/edit', extra: widget.project);
            },
            icon: Icon(Icons.mode),
          ),
        ],
      ),
      body: Column(
        children: [
          switch (widget.project.status) {
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
            "Date de début : ${widget.project.date?.day}/${widget.project.date?.month}/${widget.project.date?.year}",
            style: TextStyle(color: Colors.black),
          ),
          Text(widget.project.desc, style: TextStyle(color: Colors.black)),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: widget.project.tasks.length,
                itemBuilder: (context, index) {
                  final task = widget.project.tasks[index];

                  return Card(
                    child: ListTile(
                      title: Text(
                        task.name,
                        style: TextStyle(
                          decoration: task.isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      subtitle: task.isCompleted
                          ? Text(
                              "Tâche complétée",
                              style: TextStyle(color: Colors.green),
                            )
                          : task.details.isEmpty
                          ? Text("Aucun détail") //: Text("Detailssssss"),
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: task.details
                                  .map((t) => Text("- $t"))
                                  .toList(),
                            ),
                      // : ListView.builder(
                      //     itemCount: task.details.length,
                      //     itemBuilder: (context, index) {
                      //       Text("- ${task.details[index]}");
                      //     },
                      //   ),
                      leading: task.isCompleted
                          ? Icon(Icons.check, color: Colors.green)
                          : Icon(
                              Icons.keyboard_arrow_right,
                              color: Colors.yellow,
                            ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              if (mounted) {
                                setState(() {
                                  task.isCompleted = !task.isCompleted;
                                });
                              }
                            },
                            icon: task.isCompleted
                                ? Icon(Icons.repeat_rounded)
                                : Icon(Icons.check_box, color: Colors.yellow),
                          ),
                          PopupMenuButton(
                            onSelected: (value) {
                              if (value == 'delete') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Voulez-vous supprimer cette tâche ?",
                                    ),
                                    action: SnackBarAction(
                                      label: "Confirmer",
                                      onPressed: () {
                                        setState(() {
                                          widget.project.tasks.removeAt(index);
                                        });

                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text("Element supprimé !"),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              } else {
                                showAddDetailDialog(task);
                              }
                            },
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                child: Text("Ajouter des détails"),
                                value: "addDetail",
                              ),
                              PopupMenuItem(
                                child: Text("Supprimer tâche"),
                                value: "delete",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
