import 'package:string_stack/domain/models/guitar_string.dart';

class FretPosition {
  const FretPosition({required this.position, this.string});
  final int position;
  final GuitarString? string;

  bool get isMute => position == -1;

  FretPosition copyWith({GuitarString? string}) =>
      FretPosition(position: position, string: string ?? this.string);

  @override
  String toString() =>
      'Fret: $position on ${string?.note}_${string?.stringNumber}';
}
