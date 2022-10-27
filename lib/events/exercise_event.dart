import 'package:flutter_project/events/Training_Event.dart';
import 'package:flutter_project/repository/training_repository.dart';

class ExerciseEvent implements TrainingEvent {
  late Training training;
  late int now;
  ExerciseEvent({required this.now, required this.training});
}
