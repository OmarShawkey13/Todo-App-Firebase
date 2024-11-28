class TaskModel {
  final String? title;
  final int? id;

  TaskModel({
    required this.title,
    required this.id,
  });

  TaskModel.fromJson(Map<String, dynamic>? json)
      : title = json?['title'],
        id = json?['id'];

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'id': id,
    };
  }
}
