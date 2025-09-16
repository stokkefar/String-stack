import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';
import 'package:string_stack/di/di_setup.dart';
import 'package:string_stack/domain/models/fret_position.dart';
import 'package:string_stack/modifiers/padding.dart';
import 'package:string_stack/presentation/fret_index.dart';
import 'package:string_stack/presentation/tab_grid.dart';
import 'package:string_stack/presentation/tab_view_model.dart';

class TabScreen extends StatelessWidget {
  TabScreen({super.key});
  late final TabViewModel vm = getIt.get();

  @override
  Widget build(BuildContext context) {
    final tuning = vm.tuning.value;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Create a chord",
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 64),
            Wrap(
              alignment: WrapAlignment.start,
              spacing: 8,
              runSpacing: 8,
              children: [
                FretIndex(
                  fret: FretPosition(position: -1),
                  onTap: () =>
                      vm.handlePlaceTabOnTap(FretPosition(position: -1)),
                ),
                ...List.generate(22, (index) {
                  final fret = FretPosition(position: index);

                  return FretIndex(
                    fret: fret,
                    onTap: () => vm.handlePlaceTabOnTap(fret),
                  );
                }),
              ],
            ),
            Spacer(),
            TabGrid(
              tuning: tuning,
              onMoveToFret: (stringTab) => vm.onPlaceTab(stringTab),
              onOccupiedTabTapped: (stringTab) => vm.removeStringTab(stringTab),
              tabs: vm.tabs.watch(context),
              onClear: () => vm.clearTabs(),
              onSave: () {},
            ),
            Spacer(),
          ],
        ).padding(horizontal: 24),
      ),
    );
  }
}
