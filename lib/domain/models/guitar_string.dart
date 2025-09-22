import 'package:string_stack/domain/models/fret_position.dart';
import 'package:string_stack/domain/models/note.dart';

class GuitarString {
  const GuitarString({
    required this.note,
    required this.stringNumber,
    this.tabs = const [],
  });

  final Note note;
  final int stringNumber;
  final List<TabNote> tabs;

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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GuitarString &&
          runtimeType == other.runtimeType &&
          note == other.note &&
          stringNumber == other.stringNumber;

  @override
  int get hashCode => note.hashCode ^ stringNumber.hashCode;

  GuitarString copyWith({Note? note}) =>
      GuitarString(note: note ?? this.note, stringNumber: stringNumber);
}

class TabNote {
  final FretPosition fingerPosition;
  final double neckPlacement;

  TabNote(this.fingerPosition, this.neckPlacement);
}
