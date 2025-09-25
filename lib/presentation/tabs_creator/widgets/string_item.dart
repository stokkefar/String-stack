import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:string_stack/domain/models/fret_position.dart';
import 'package:string_stack/domain/models/guitar_string.dart';
import 'package:string_stack/modifiers/padding.dart';
import 'package:string_stack/presentation/tabs_creator/widgets/fret_index.dart';

class StringItem extends StatelessWidget {
  const StringItem({
    super.key,
    required this.string,
    required this.onPlaceTab,
    required this.onRemoveTab,
    required this.tabs,
    required this.shouldRebuild,
    required this.onMoveTab,
  });
  final GuitarString string;
  final Function(GuitarString, TabNote) onPlaceTab;
  final Function(GuitarString, TabNote) onRemoveTab;
  final Function(GuitarString, GuitarString, TabNote, double) onMoveTab;
  final List<TabNote> tabs;
  final dynamic shouldRebuild;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: SizedBox.expand(
        child: Builder(
          builder: (stringContext) {
            return DragTarget<DragData>(
              onAcceptWithDetails: (details) {
                RenderBox? box = stringContext.findRenderObject() as RenderBox?;
                if (box != null) {
                  Offset localPosition = box.globalToLocal(details.offset);
                  double dropX = localPosition.dx - 15;
                  dropX = dropX.clamp(0, double.infinity);

                  final dragData = details.data;
                  final fret = dragData.fret;
                  final existingTab = dragData.existingTab;

                  if (existingTab != null) {
                    // This is an existing tab being moved - use moveTab
                    final oldString = existingTab.fingerPosition.string!;
                    onMoveTab(oldString, string, existingTab, dropX);
                  } else {
                    // Create new tab from palette
                    FretPosition placedFretPosition = FretPosition(
                      position: fret.position,
                      string: string,
                    );
                    final newTabNote = TabNote(placedFretPosition, dropX);
                    onPlaceTab(string, newTabNote);
                  }

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
                            existingTabNote: tabNote,
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
