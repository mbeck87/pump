import 'exercise.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'day.dart';


class Manager {
  static final Manager _instance = Manager._internal();
  late final Directory _dir;
  late Map<String, dynamic> _data;

  Manager._internal();

  factory Manager() {
    return _instance;
  }

  Future<void> init() async {
    _dir = await getApplicationSupportDirectory();
    _initJson();
  }

  void _initJson() {
    File file = File("${_dir.path}/data.json");
    if (!file.existsSync()) {
      Map<String, dynamic> data = {
        "Montag": {
          "Bankdrücken":         ["0", "0", "0", "0", "0"],
          "Butterfly":           ["0", "0", "0", "0", "0"],
          "Schrägbankdrücken":   ["0", "0", "0", "0", "0"],
          "Sitzend bankdrücken": ["0", "0", "0", "0", "0"],
          "Kabelzug":            ["0", "0", "0", "0", "0"],
        }
      };
      file.writeAsStringSync(jsonEncode(data));
    }
    _refreshJson();
  }

  void _refreshJson() {
    File file = File("${_dir.path}/data.json");
    _data = jsonDecode(file.readAsStringSync());
  }

  ExerciseCard _getCard(String name, List<String> sets) {
    ExerciseCard card = ExerciseCard(name: name, sets: sets, onApply: setSets);
    return card;
  }

  void setSets(String name, List<String> values) {
    print(name);
  }

  String getDayName() {
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

  Day? getDayLayout(String day) {
    final Map<String, dynamic>? dayEx = _data[day];
    final List<ExerciseCard> exercises = [];

    if (dayEx == null) return null;
    for (String name in dayEx.keys) {
      final List<String> sets = List<String>.from(dayEx[name]);
      final ExerciseCard card = _getCard(name, sets);
      exercises.add(card);
    }
    Day dayLayout = Day(exercises: exercises);
    return dayLayout;
  }
}