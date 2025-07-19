import 'exercise.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';


class Manager {
  static final Manager _instance = Manager._internal();
  late final Directory? _dir;

  Manager._internal();

  factory Manager() {
    return _instance;
  }

  static Future<Manager> create() async {
    _instance._dir ??= await getApplicationSupportDirectory();
    return _instance;
  }

  ExerciseCard getCard(String name) {
    List<String> sets = getSets(name);
    ExerciseCard card = ExerciseCard(name: name, sets: sets, onApply: setSets);
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

  void setSets(String name, List<String> values) {
    print(name);
  }

  String getDay() {
    const days = [
      'Montag',
      'Dienstag',
      'Mittwoch',
      'Donnerstag',
      'Freitag',
      'Samstag',
      'Sonntag',
    ];
    int today = DateTime.now().weekday;
    return days[today - 1];
  }
}