import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';
import 'package:string_stack/di/di_setup.dart';
import 'package:string_stack/domain/models/fret_position.dart';
import 'package:string_stack/domain/models/tuning.dart';
import 'package:string_stack/modifiers/padding.dart';
import 'package:string_stack/presentation/tabs_creator/tabs_creator_view_model.dart';
import 'package:string_stack/presentation/tabs_creator/widgets/fret_index.dart';
import 'package:string_stack/presentation/tabs_creator/widgets/tab_grid.dart';

class TabsCreatorScreen extends StatefulWidget {
  const TabsCreatorScreen({super.key, required this.tuning});
  final Tuning tuning;

  @override
  State<TabsCreatorScreen> createState() => _TabsCreatorScreenState();
}

class _TabsCreatorScreenState extends State<TabsCreatorScreen> {
  late final TabsCreatorViewModel _vm = getIt.get(param1: widget.tuning);
  late final PageController _pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Create tabs",
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 52),
            Wrap(
              alignment: WrapAlignment.start,
              spacing: 8,
              runSpacing: 8,
              children: [
                FretIndex(fret: FretPosition(position: -1)),
                ...List.generate(25, (index) {
                  return FretIndex(fret: FretPosition(position: index));
                }),
              ],
            ),

            Divider(
              radius: BorderRadius.circular(16),
              height: 1,
              endIndent: 0,
              indent: 0,
              color: Theme.of(context).colorScheme.primary.withAlpha(50),
            ).padding(vertical: 24),

            SizedBox(
              width: double.infinity,
              height: 200,
              child: PageView.builder(
                onPageChanged: (page) => _vm.onSectionChanged(page),
                itemCount: _vm.tabSections.watch(context),
                controller: _pageController,
                itemBuilder: (context, index) {
                  return TabGrid(
                    key: ValueKey('tab_grid_$index'),
                    tuning: _vm.tuning(),
                    onPlaceTab: (guitarString, tabNote) =>
                        _vm.placeTab(guitarString, tabNote),
                    onRemoveTab: (guitarString, tabNote) =>
                        _vm.removeTab(guitarString, tabNote),
                    viewModel: _vm,
                    sectionIndex: index,
                  ).padding(right: 8);
                },
              ),
            ),

            Row(
              children: [
                FloatingActionButton(
                  heroTag: 'prev',
                  mini: true,
                  onPressed: _vm.currentSection.watch(context) == 0
                      ? null
                      : () async {
                          _pageController.previousPage(
                            duration: Duration(milliseconds: 350),
                            curve: Curves.easeInOutCubic,
                          );
                        },
                  child: Icon(Icons.arrow_back, color: Colors.white),
                ),
                Spacer(),
                FloatingActionButton(
                  heroTag: 'next',
                  mini: true,
                  onPressed: () async {
                    _vm.onNextTabSection();
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 350),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Icon(Icons.arrow_forward, color: Colors.white),
                ),
              ],
            ),

            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _vm.clearTabsForSection(),
                child: Text("Clear tabs"),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: () {}, child: Text("Save tabs")),
            ),
          ],
        ).padding(horizontal: 24),
      ),
    );
  }
}
