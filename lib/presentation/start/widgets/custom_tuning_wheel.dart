import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:string_stack/domain/models/note.dart';

class CustomTuningWheel extends StatelessWidget {
  const CustomTuningWheel({
    super.key,
    required this.onTuningChanged,
    required this.customTuning,
  });
  final Function(int, int) onTuningChanged;
  final List<Note> customTuning;

  @override
  Widget build(BuildContext context) {
    final notes = Note.values;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...customTuning.asMap().entries.map((entry) {
          final noteIndex = notes.indexOf(entry.value);
          final customTuningIndex = entry.key;

          return Flexible(
            flex: 1,
            child: SizedBox(
              height: 100,
              width: 35,
              child: ListWheelScrollView.useDelegate(
                childDelegate: ListWheelChildBuilderDelegate(
                  childCount: notes.length,
                  builder: (context, index) => SizedBox(
                    width: double.infinity,
                    child: Text(
                      notes[index].sharp,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
                useMagnifier: true,
                perspective: 0.01,
                diameterRatio: 1.5,
                controller: FixedExtentScrollController(initialItem: noteIndex),
                physics: FixedExtentScrollPhysics(),
                magnification: 1.05,
                overAndUnderCenterOpacity: 0.2,
                itemExtent: 30,
                squeeze: 1.3,
                onSelectedItemChanged: (noteIndex) {
                  onTuningChanged(noteIndex, customTuningIndex);
                  HapticFeedback.lightImpact();
                },
              ),
            ),
          );
        }),
      ],
    );
  }
}
