import 'package:flutter/material.dart';
import 'package:string_stack/domain/models/guitar_string.dart';
import 'package:string_stack/domain/models/tuning.dart';
import 'package:string_stack/presentation/tabs_creator/widgets/string_item.dart';
import 'package:collection/collection.dart';

class TabGrid extends StatelessWidget {
  const TabGrid({
    super.key,
    required this.tuning,
    required this.onPlaceTab,
    required this.onRemoveTab,
    required this.tabs,
  });
  final Function(GuitarString) onPlaceTab;
  final Function(GuitarString) onRemoveTab;
  final Tuning tuning;
  final List<GuitarString> tabs;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        ...List.generate(6, (index) {
          final string = tuning.getStringInfo(index);
          final stringTabs = tabs
              .firstWhereOrNull(
                (tab) =>
                    tab.note == string.note &&
                    tab.stringNumber == string.stringNumber,
              )
              ?.tabs;

          return StringItem(
            string: string,
            onPlaceTab: (stringTab) => onPlaceTab(stringTab),
            onRemoveTab: (stringTab) => onRemoveTab(stringTab),
            tabs: stringTabs ?? [],
          );
        }),
      ],
    );
  }
}
