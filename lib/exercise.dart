import 'package:flutter/material.dart';

class ExerciseCard extends StatefulWidget {
  final String name;
  final List<String> sets;

  const ExerciseCard({super.key, required this.name, required this.sets});

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  late final List<TextEditingController> _controllers;

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
                Image.network(
                  "https://picsum.photos/250?image=9",
                  height: 100,
                  width: 140,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 16),
                Text(
                  widget.name,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 14,
                    color: Color(0xff000000),
                  ),
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
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          color: Color(0xff000000),
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
