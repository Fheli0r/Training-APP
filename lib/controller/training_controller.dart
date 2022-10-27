import 'package:flutter_project/events/Training_Event.dart';
import 'package:flutter_project/events/end_event.dart';
import 'package:flutter_project/events/exercise_event.dart';
import 'package:flutter_project/events/start_event.dart';
import 'package:flutter_project/homepage.dart';
import 'package:flutter_project/repository/training_repository.dart';

class TrainingController {
  late List<Training> TrainingTimers;

  TrainingController({required this.TrainingTimers});

  Stream<TrainingEvent> start() async* {
    yield StartEvent();

    for (Training training in TrainingTimers) {
      for (int seconds = training.seconds; seconds >= 0; seconds--) {
        await Future.delayed(const Duration(seconds: 1));
        yield ExerciseEvent(now: seconds, training: training);
      }
    }

    yield EndEvent();
  }
}
