import 'package:flutter/material.dart';
import 'package:string_stack/domain/models/fret_position.dart';
import 'package:string_stack/domain/models/guitar_string.dart';
import 'package:string_stack/presentation/chord_creator/widgets/fret_index.dart';

class String extends StatelessWidget {
  const String({
    super.key,
    required this.string,
    required this.onPlaceTab,
    this.onOccupiedTabTapped,
    this.occupiedString,
  });
  final GuitarString string;
  final Function(GuitarString) onPlaceTab;
  final Function(GuitarString)? onOccupiedTabTapped;
  final GuitarString? occupiedString;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox.expand(
            child: DragTarget<FretPosition>(
              onAcceptWithDetails: (details) {
                final fret = details.data;

                final stringTab = GuitarString(
                  note: string.note,
                  stringNumber: string.stringNumber,
                  fingerPosition: fret,
                );
                onPlaceTab(stringTab);
              },
              builder: (context, _, _) {
                return Row(
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
                  ],
                );
              },
            ),
          ),
          SizedBox(
            height: 32,
            child: occupiedString?.fingerPosition != null
                ? FretIndex(
                    fret: occupiedString!.fingerPosition!,
                    removeWhenDragging: true,
                    onTap: () => onOccupiedTabTapped?.call(occupiedString!),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
