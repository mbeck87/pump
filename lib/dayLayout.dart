import 'package:flutter/material.dart';
import 'exercise.dart';


class Day extends StatefulWidget {
  final List<ExerciseCard> exercises;
  
  const Day({super.key, required this.exercises});

  @override
  State<Day> createState() => _DayState();
}

class _DayState extends State<Day> {
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.exercises,
    );
  }
}