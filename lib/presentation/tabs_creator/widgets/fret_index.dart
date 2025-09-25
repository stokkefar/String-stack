import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:string_stack/domain/models/fret_position.dart';
import 'package:string_stack/domain/models/guitar_string.dart';

class FretIndex extends StatelessWidget {
  const FretIndex({
    required this.fret,
    this.removeWhenDragging = false,
    this.onTap,
    this.existingTabNote,
    super.key,
  });
  final FretPosition fret;
  final bool removeWhenDragging;
  final VoidCallback? onTap;
  final TabNote? existingTabNote;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Draggable<DragData>(
        onDragStarted: () => HapticFeedback.lightImpact(),
        childWhenDragging: removeWhenDragging ? const SizedBox.shrink() : null,
        data: DragData(fret, existingTabNote),
        feedback: _Fret(fret),
        child: _Fret(fret),
      ),
    );
  }
}

class _Fret extends StatelessWidget {
  const _Fret(this.fret);
  final FretPosition fret;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Color(0xFF03071e),
        shape: BoxShape.circle,
      ),
      child: SizedBox(
        height: 32,
        width: 32,
        child: Center(
          child: Text(
            fret.isMute ? 'X' : '${fret.position}',
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class DragData {
  final FretPosition fret;
  final TabNote? existingTab; // null for new tabs from palette

  DragData(this.fret, [this.existingTab]);
}
