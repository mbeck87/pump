import 'dart:io';

import 'package:flutter/material.dart';

class ExerciseCard extends StatefulWidget {
  final String name;
  final String pic;
  final List<String> sets;
  final bool Function(String name, List<String> sets)? onApply;

  const ExerciseCard({
    super.key,
    required this.name,
    required this.sets,
    this.onApply,
  }) : pic = 'images/$name.png';

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
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      margin: const EdgeInsets.all(8),
      color: colorScheme.surface,
      shadowColor: colorScheme.shadow,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(color: colorScheme.outline, width: 1),
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
                  widget.pic.toLowerCase(),
                  height: 100,
                  width: 100,
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
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 18,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: 100,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 6,
                        ),
                        onPressed: () {
                          _setSets();
                          final bool confirm = widget.onApply?.call(widget.name, widget.sets) ?? false;
                          if (confirm) {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                content: Text('Erfolgreich gespeichert!'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        child: Text(
                          "OK",
                          style: textTheme.labelLarge?.copyWith(
                            color: colorScheme.primary,
                          ),
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
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurface,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: colorScheme.outline,
                            width: 1,
                          ),
                        ),
                        filled: true,
                        fillColor: colorScheme.surfaceContainerHighest,
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
