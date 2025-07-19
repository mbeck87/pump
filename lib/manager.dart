import 'exercise.dart';
import 'dart:io';
import 'dart:convert';


class Manager {
  static final Manager _instance = Manager._internal();

  Manager._internal();

  factory Manager() {
    return _instance;
  }

  ExerciseCard getCard(String name) {
    List<String> sets = getSets(name);
    ExerciseCard card = ExerciseCard(name: name, sets: sets, onApply: writeValues);
    return card;
  }

  List<String> getSets(String name) {
    List<String> list = [];
    list.add("50");
    list.add("60");
    list.add("70");
    list.add("80");
    list.add("100");
    return list;
  }

  void writeValues(String name, List<String> values) {
    print(name);
  }
}