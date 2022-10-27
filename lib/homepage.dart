import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_project/controller/training_controller.dart';
import 'package:flutter_project/events/Training_Event.dart';
import 'package:flutter_project/events/end_event.dart';
import 'package:flutter_project/events/exercise_event.dart';
import 'package:flutter_project/events/start_event.dart';
import 'package:flutter_project/repository/training_repository.dart';

import 'countdown_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showstartbutton = true;
  late final TrainingController controller;
  late final Stream<TrainingEvent> trainingStream;

  start() {
    controller = TrainingController(TrainingTimers: [
      Training(seconds: 50, name: 'Push ups'),
      Training(seconds: 20, name: 'Rest'),
      Training(seconds: 50, name: 'Biceps curls'),
      Training(seconds: 20, name: 'Rest'),
      Training(seconds: 50, name: 'Tricep extension'),
      Training(seconds: 20, name: 'Rest'),
      Training(seconds: 50, name: 'Shoulders press'),
      Training(seconds: 20, name: 'Rest'),
      Training(seconds: 50, name: 'Reverse fly'),
      Training(seconds: 20, name: 'Rest'),
      Training(seconds: 50, name: 'Lateral raise'),
    ]);
    setState(() {
      trainingStream = controller.start();
      showstartbutton = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: Colors.white,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            exit(0);
          },
        ),
        backgroundColor: Colors.black,
        title: Text('Training App'),
      ),
      body: Center(
        child: showstartbutton
            ? ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    textStyle:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                child: const Text(
                  'Start Training',
                ),
                onPressed: start,
              )
            : StreamBuilder(
                stream: trainingStream,
                builder: (context, AsyncSnapshot<TrainingEvent> snapshot) {
                  TrainingEvent? event = snapshot.data;
                  if (snapshot.hasError) {
                    return const Text('Sorry, your training not loading');
                  } else if (event is StartEvent) {
                    return const Text('Starting Training...');
                  } else if (event is EndEvent) {
                    return Text('Ending Training...');
                  } else if (event is ExerciseEvent) {
                    return CountDown(event: event);
                  }
                  return HomePage();
                },
              ),
      ),
    );
  }
}
