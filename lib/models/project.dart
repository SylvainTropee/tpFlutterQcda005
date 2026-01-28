enum ProjectStatus { inProgress, done, upComing }

class Project {
  String _title;
  String _desc;
  ProjectStatus _status;
  DateTime? _date;

  Project({
    required String title,
    required String desc,
    ProjectStatus status = ProjectStatus.upComing,
    DateTime? date,
  }) : _title = title,
       _desc = desc,
       _status = status,
       _date = date;

  ProjectStatus get status => _status;

  set status(ProjectStatus value) {
    _status = value;
  }

  String get desc => _desc;

  set desc(String value) {
    _desc = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  DateTime? get date => _date;

  set date(DateTime? value) {
    _date = value;
  }

  @override
  String toString() {
    return 'Project{_title: $_title, _desc: $_desc, _status: $_status, _date: $_date}';
  }
}
