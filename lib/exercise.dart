import 'package:flutter/material.dart';

class ExerciseCard extends StatefulWidget {
  final String name;
  final String pic;
  final List<String> sets;
  final void Function(String name, List<String> sets)? onApply;


  const ExerciseCard({super.key, required this.name, required this.sets, this.onApply}) : pic = 'images/$name.jpg';

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  late final List<TextEditingController> _controllers;

  String _getName() {
    String name = widget.name;
    return name[0].toUpperCase() + name.substring(1);
  }

  void _setSets() {
    for (int i = 0; i < widget.sets.length; i++) {
      widget.sets[i] = _controllers[i].text;
    }
  }

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      5,
          (index) => TextEditingController(
        text: index < widget.sets.length ? widget.sets[index] : '',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(4),
      color: const Color(0xffe0e0e0),
      shadowColor: const Color(0xff000000),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
        side: const BorderSide(color: Color(0x4d9e9e9e), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  widget.pic,
                  height: 100,
                  width: 140,
                  fit: BoxFit.fill,
                ),
                const SizedBox(width: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      _getName(),
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        color: Color(0xff000000),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                      width: 16,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        _setSets();
                        widget.onApply!(widget.name, widget.sets);
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Color(0xffffffff),
                        side: BorderSide(color: Color(0xff808080), width: 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        padding: EdgeInsets.all(10),
                        minimumSize: Size(100, 20),
                      ),
                      child: Text(
                        "OK",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: List.generate(
                5,
                (index) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: TextField(
                      controller: _controllers[index],
                      obscureText: false,
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        color: Color(0xff000000),
                      ),
                      decoration: InputDecoration(
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide: const BorderSide(
                            color: Color(0xff000000),
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide: const BorderSide(
                            color: Color(0xff000000),
                            width: 1,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide: const BorderSide(
                            color: Color(0xff000000),
                            width: 1,
                          ),
                        ),
                        filled: true,
                        fillColor: const Color(0xfff2f2f3),
                        isDense: false,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
