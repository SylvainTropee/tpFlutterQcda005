import 'package:flutter/material.dart';
import 'package:tp_flutter_qcda005/models/project.dart';

class ProjectForm extends StatefulWidget {
  final Function(Project) onSubmitForm;
  final Project? project;

  const ProjectForm({required this.onSubmitForm, this.project});

  @override
  State<ProjectForm> createState() => _ProjectFormState();
}

class _ProjectFormState extends State<ProjectForm> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  DateTime? _pickedDate;
  String? title, desc;
  ProjectStatus? status = ProjectStatus.inProgress;

  TextEditingController dateController = TextEditingController();

  String? requiredValidateField(String? value) {
    return (value == null || value.isEmpty) ? "Champ requis !" : null;
  }

  @override
  void initState() {
    super.initState();
    if (widget.project?.date != null) {
      dateController.text =
          "${widget.project?.date?.day}/${widget.project?.date?.month}/${widget.project?.date?.year}";
    }
  }

  void _submitForm() {
    if (_key.currentState!.validate()) {
      //création d'un nouveau projet à sauvegarder
      _key.currentState!.save();

      var project = widget.project;

      if (project == null) {
        project = Project(
          title: title ?? "",
          desc: desc ?? "",
          status: status ?? ProjectStatus.inProgress,
          date: _pickedDate,
        );
      }else{
        project.title = title ?? "";
        project.desc = desc ?? "";
        project.status = status ?? ProjectStatus.inProgress;
        project.date = _pickedDate;
      }
      //print(project);
      widget.onSubmitForm(project);
    }
  }

  Future<void> _selectedDate() async {
    var date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      initialDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 2),
    );
    _pickedDate = date;
    dateController.text = "${date!.day}/${date.month}/${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextFormField(
              initialValue: widget.project?.title,
              onSaved: (value) {
                title = value;
              },
              validator: requiredValidateField,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: "Titre du projet",
                hintText: "Un nouveau projet...",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: widget.project?.desc,
              onSaved: (value) {
                desc = value;
              },
              validator: requiredValidateField,
              maxLines: 5,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                alignLabelWithHint: true,
                labelText: "Description",
                hintText: "Une decription du projet...",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField(
              initialValue: widget.project?.status,
              onSaved: (value) {
                status = value;
              },
              dropdownColor: Colors.white,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(labelText: "Status"),
              items: [
                DropdownMenuItem(
                  child: Text("En cours"),
                  value: ProjectStatus.inProgress,
                ),
                DropdownMenuItem(
                  child: Text("Terminé"),
                  value: ProjectStatus.done,
                ),
                DropdownMenuItem(
                  child: Text("A Venir"),
                  value: ProjectStatus.upComing,
                ),
              ],
              onChanged: (value) {},
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: dateController,
              readOnly: true,
              onTap: _selectedDate,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: "Date de début",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _submitForm,
              label: Text("Soumettre"),
              // style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.indigo)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
              icon: Icon(Icons.send),
            ),
          ],
        ),
      ),
    );
  }
}
