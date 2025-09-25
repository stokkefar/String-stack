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
    // Get all tabs for this section across all strings
    final allTabsForSection = <TabNote>[];
    for (int i = 0; i < 6; i++) {
      final string = tuning.getStringInfo(i);
      allTabsForSection.addAll(
        viewModel.getTabsForString(string, sectionIndex),
      );
    }

    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        ...List.generate(6, (index) {
          final string = tuning.getStringInfo(index);

          return StringItem(
            key: ValueKey(
              '${sectionIndex}_${string.note}_${string.stringNumber}',
            ),
            string: string,
            onPlaceTab: onPlaceTab,
            onRemoveTab: onRemoveTab,
            tabs: viewModel.getTabsForString(string, sectionIndex),
            allTabs: allTabsForSection, // Pass all tabs
            shouldRebuild: viewModel.tabs.watch(context),
          );
        }),
      ],
    );
  }
}
