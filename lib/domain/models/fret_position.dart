import 'package:string_stack/domain/models/note.dart';

class FretPosition {
  const FretPosition({required this.position, this.note});
  final int position;
  final Note? note;

  bool get isMute => position == -1;

  FretPosition copyWith({Note? note}) =>
      FretPosition(position: position, note: note ?? this.note);
}
