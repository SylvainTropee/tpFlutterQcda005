class Project {
  String _title;
  String _desc;

  Project({required String title, required String desc})
    : _title = title,
      _desc = desc;

  String get desc => _desc;

  set desc(String value) {
    _desc = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }
}
