import 'package:flutter/material.dart';
import 'package:string_stack/domain/models/guitar_string.dart';
import 'package:string_stack/domain/models/tuning.dart';
import 'package:string_stack/presentation/string_item.dart';
import 'package:collection/collection.dart';

class TabGrid extends StatelessWidget {
  const TabGrid({
    super.key,
    required this.tuning,
    required this.onMoveToFret,
    required this.tabs,
    required this.onClear,
    required this.onSave,
    this.onOccupiedTabTapped,
  });
  final Function(GuitarString) onMoveToFret;
  final Tuning tuning;
  final List<GuitarString> tabs;
  final VoidCallback onClear;
  final VoidCallback onSave;
  final Function(GuitarString)? onOccupiedTabTapped;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        ...List.generate(6, (index) {
          final string = tuning.getStringInfo(index);
          return String(
            string: string,
            onPlaceTab: (stringTab) => onMoveToFret(stringTab),
            onOccupiedTabTapped: onOccupiedTabTapped,
            occupiedString: tabs.firstWhereOrNull(
              (tab) =>
                  tab.stringNumber == string.stringNumber &&
                  tab.note == string.note,
            ),
          );
        }),
        const SizedBox(height: 24),
        ElevatedButton(onPressed: onClear, child: Text("Clear tabs")),
        const SizedBox(height: 16),
        ElevatedButton(onPressed: onSave, child: Text("Save tabs")),
      ],
    );
  }
}
