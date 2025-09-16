import 'package:flutter/material.dart';
import 'package:string_stack/domain/models/fret_position.dart';

class FretIndex extends StatefulWidget {
  const FretIndex({
    required this.fret,
    this.removeWhenDragging = false,
    this.onTap,
    super.key,
  });
  final FretPosition fret;
  final bool removeWhenDragging;
  final VoidCallback? onTap;

  @override
  State<FretIndex> createState() => _FretIndexState();
}

class _FretIndexState extends State<FretIndex> {
  late FretPosition _fret;

  @override
  void initState() {
    _fret = widget.fret;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Draggable<FretPosition>(
        childWhenDragging: widget.removeWhenDragging
            ? const SizedBox.shrink()
            : null,
        data: _fret,
        feedback: _Fret(_fret),
        child: _Fret(_fret),
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
