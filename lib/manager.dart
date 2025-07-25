import 'exercise.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'dayLayout.dart';


class Manager {
  static final Manager _instance = Manager._internal();
  late final Directory _dir;
  late File _file;
  late Map<String, dynamic> _data;
  late String _day;

  Manager._internal();

  factory Manager() {
    return _instance;
  }

  Future<void> init() async {
    _dir = await getApplicationSupportDirectory();
    _file = File("${_dir.path}/data.json");
    _initJson();
    _day = setDayName();
  }

  // ACHTUNG MUSS DIE FILE LÖSCHEN UM SIE ZU AKTUALISIEREN
  void _initJson() {
    if (!_file.existsSync()) {
      Map<String, dynamic> data = {
        "Montag": {
          "Bankdrücken":         ["0", "0", "0", "0", "0"],
          "Butterfly":           ["0", "0", "0", "0", "0"],
          "Schrägbankdrücken":   ["0", "0", "0", "0", "0"],
          "Sitzend Bankdrücken": ["0", "0", "0", "0", "0"],
          "Kabelzug Butterflys": ["0", "0", "0", "0", "0"],
        },
        "Mittwoch": {
          "Curls":               ["0", "0", "0", "0", "0"],
          "Hammercurls":         ["0", "0", "0", "0", "0"],
          "Freihantelcurls":     ["0", "0", "0", "0", "0"],
          "Triceps Stangen Dips":["0", "0", "0", "0", "0"],
          "Triceps Seil Dips":   ["0", "0", "0", "0", "0"],
          "Sitzend Trizeps Dips":["0", "0", "0", "0", "0"],
        }
      };
      _file.writeAsStringSync(jsonEncode(data));
    }
    _refreshJson();
  }

  void _refreshJson() {
    _data = jsonDecode(_file.readAsStringSync());
  }

  ExerciseCard _getCard(String name, List<String> sets) {
    ExerciseCard card = ExerciseCard(name: name, sets: sets, onApply: setSets);
    return card;
  }

  bool setSets(String name, List<String> values) {
    for(int i = 0; i < values.length; i++) {
      _data[_day][name][i] = values[i];
    }
    _file.writeAsStringSync(jsonEncode(_data));
    return true;
  }

  String setDayName() {
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
    // return days[today - 1];
    return "Montag";
  }

  String getDayName() {
    return _day;
  }

  Day? getDayLayout() {
    final Map<String, dynamic>? dayEx = _data[_day];
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