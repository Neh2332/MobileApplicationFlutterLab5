import 'package:uuid/uuid.dart';

class Task {
  final String id;
  String title;
  String description;
  DateTime deadline;

  Task({
    required this.title,
    required this.description,
    required this.deadline,
  }) : id = const Uuid().v4();
}