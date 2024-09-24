import 'package:hive/hive.dart';

part 'task_model.g.dart';  // This will be generated

@HiveType(typeId: 0)  // Each model needs a unique typeId
class TaskModel extends HiveObject {
  @HiveField(0)
  String taskName;

  @HiveField(1)
  String description;

  @HiveField(2)
  bool isCompleted;

  TaskModel({
    required this.taskName,
    required this.description,
    this.isCompleted = false,
  });
}
