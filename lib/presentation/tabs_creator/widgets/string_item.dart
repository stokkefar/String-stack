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
    required this.shouldRebuild, // Add this to force rebuilds
  });
  final GuitarString string;
  final Function(GuitarString, TabNote) onPlaceTab;
  final Function(GuitarString, TabNote) onRemoveTab;
  final List<TabNote> tabs;
  final dynamic shouldRebuild; // This will be watched by the parent

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: SizedBox.expand(
        child: Builder(
          builder: (stringContext) {
            return DragTarget<FretPosition>(
              onAcceptWithDetails: (details) {
                // Get drop position relative to the string
                RenderBox? box = stringContext.findRenderObject() as RenderBox?;
                if (box != null) {
                  Offset localPosition = box.globalToLocal(details.offset);
                  double dropX = localPosition.dx - 15; // Center the tab

                  // Ensure minimum position
                  dropX = dropX.clamp(0, double.infinity);

                  final fret = details.data;
                  final newTabNote = TabNote(fret, dropX);

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
                        Text(string.note.sharp),
                        const SizedBox(width: 8),
                        Expanded(
                          child: SizedBox(
                            height: 2,
                            child: DecoratedBox(
                              decoration: BoxDecoration(color: Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 24,
                          width: 2,
                          child: DecoratedBox(
                            decoration: BoxDecoration(color: Colors.black),
                          ),
                        ).padding(left: 4),
                      ],
                    ),

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

                    if (candidateData.isNotEmpty) ...[
                      Positioned(
                        top: 4,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 24,
                          decoration: BoxDecoration(
                            color: Colors.deepPurple.withAlpha(100),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
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
