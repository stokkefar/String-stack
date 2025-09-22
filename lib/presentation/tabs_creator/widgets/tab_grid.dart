import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';
import 'package:string_stack/domain/models/guitar_string.dart';
import 'package:string_stack/domain/models/tuning.dart';
import 'package:string_stack/presentation/tabs_creator/tabs_creator_view_model.dart';
import 'package:string_stack/presentation/tabs_creator/widgets/string_item.dart';

class TabGrid extends StatelessWidget {
  const TabGrid({
    super.key,
    required this.tuning,
    required this.onPlaceTab,
    required this.onRemoveTab,
    required this.viewModel,
    required this.sectionIndex,
  });

  final Function(GuitarString, TabNote) onPlaceTab;
  final Function(GuitarString, TabNote) onRemoveTab;
  final TabsCreatorViewModel viewModel;
  final Tuning tuning;
  final int sectionIndex;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        ...List.generate(6, (index) {
          final string = tuning.getStringInfo(index);

          return StringItem(
            key: ValueKey(
              '${sectionIndex}_${string.note}_${string.stringNumber}',
            ), // Use sectionIndex, not currentSection
            string: string,
            onPlaceTab: onPlaceTab,
            onRemoveTab: onRemoveTab,
            tabs: viewModel.getTabsForString(
              string,
              sectionIndex,
            ), // Pass specific section
            shouldRebuild: viewModel.tabs.watch(context), // Watch the signal
          );
        }),
      ],
    );
  }
}
