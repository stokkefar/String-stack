import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:string_stack/domain/models/fret_position.dart';
import 'package:string_stack/domain/models/guitar_string.dart';
import 'package:string_stack/modifiers/padding.dart';
import 'package:string_stack/presentation/tabs_creator/widgets/fret_index.dart';
import 'package:collection/collection.dart';

class StringItem extends StatelessWidget {
  const StringItem({
    super.key,
    required this.string,
    required this.onPlaceTab,
    required this.onRemoveTab,
    required this.tabs,
    required this.shouldRebuild,
    required this.allTabs,
  });
  final GuitarString string;
  final Function(GuitarString, TabNote) onPlaceTab;
  final Function(GuitarString, TabNote) onRemoveTab;
  final List<TabNote> tabs;
  final List<TabNote> allTabs;
  final dynamic shouldRebuild;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: SizedBox.expand(
        child: Builder(
          builder: (stringContext) {
            return DragTarget<FretPosition>(
              onAcceptWithDetails: (details) {
                RenderBox? box = stringContext.findRenderObject() as RenderBox?;
                if (box != null) {
                  Offset localPosition = box.globalToLocal(details.offset);
                  double dropX = localPosition.dx - 15;
                  dropX = dropX.clamp(0, double.infinity);

                  final fret = details.data;

                  // Check if this fret is being dragged from an existing position
                  // We need to check if it has the same position AND string (meaning it's the same tab being moved)
                  final existingTab = allTabs.firstWhereOrNull(
                    (tab) =>
                        tab.fingerPosition.position == fret.position &&
                        tab.fingerPosition.string?.stringNumber ==
                            fret.string?.stringNumber,
                  );

                  if (existingTab != null) {
                    // This is an existing tab being moved, remove it from old position
                    final oldString = existingTab.fingerPosition.string!;
                    onRemoveTab(oldString, existingTab);
                  }
                  // If existingTab is null, it's a new tab (even if same fret number)

                  // Create new tab on current string
                  FretPosition placedFretPosition = FretPosition(
                    position: fret.position,
                    string: string,
                  );
                  final newTabNote = TabNote(placedFretPosition, dropX);
                  onPlaceTab(string, newTabNote);

                  HapticFeedback.lightImpact();
                }
              },
              builder: (context, candidateData, _) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(string.note.notation),
                        const SizedBox(width: 8),
                        Expanded(
                          child: SizedBox(
                            height: 1.5,
                            child: DecoratedBox(
                              decoration: BoxDecoration(color: Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 24,
                          width: 1,
                          child: DecoratedBox(
                            decoration: BoxDecoration(color: Colors.black),
                          ),
                        ).padding(left: 4),
                      ],
                    ),

                    if (candidateData.isNotEmpty) ...[
                      Positioned(
                        top: 10,
                        left: 16,
                        right: 0,
                        child: Container(
                          height: 12,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(
                              255,
                              51,
                              25,
                              95,
                            ).withAlpha(50),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ],

                    if (tabs.isNotEmpty) ...[
                      ...tabs.map((tabNote) {
                        return Positioned(
                          left: tabNote.neckPlacement.clamp(0, double.infinity),
                          child: FretIndex(
                            fret: tabNote.fingerPosition,
                            removeWhenDragging: true,
                            onTap: () {
                              HapticFeedback.mediumImpact();
                              onRemoveTab(string, tabNote);
                            },
                          ),
                        );
                      }),
                    ],
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
