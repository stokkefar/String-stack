import 'package:string_stack/domain/models/fret_position.dart';
import 'package:string_stack/domain/models/note.dart';

class GuitarString {
  const GuitarString({
    required this.note,
    required this.stringNumber,
    this.fingerPosition,
  });

  final Note note;
  final int stringNumber;
  final FretPosition? fingerPosition;

  String get stringName =>
      '$stringNumber${_getOrdinalSuffix(stringNumber)} string';

  String _getOrdinalSuffix(int number) {
    switch (number) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  GuitarString copyWith({Note? note, Object? fingerPosition = _sentinel}) =>
      GuitarString(
        note: note ?? this.note,
        fingerPosition: fingerPosition == _sentinel
            ? this.fingerPosition
            : fingerPosition as FretPosition?,
        stringNumber: stringNumber,
      );

  static const Object _sentinel = Object();

  @override
  String toString() =>
      '${note.sharp} position: ${fingerPosition?.position ?? 'empty'}';
}
