import 'package:string_stack/domain/models/guitar_string.dart';
import 'package:string_stack/domain/models/note.dart';

abstract class Tuning {
  String get name;
  List<GuitarString> get strings;

  int get stringCount => strings.length;

  GuitarString getStringInfo(int stringIndex) => strings[stringIndex];

  GuitarString getStringByNumber(int stringNumber) {
    return strings.firstWhere((s) => s.stringNumber == stringNumber);
  }
}

class StandardTuning extends Tuning {
  @override
  String get name => 'Standard (EADGBE)';

  @override
  List<GuitarString> get strings => const [
    GuitarString(note: Note.e, stringNumber: 1),
    GuitarString(note: Note.b, stringNumber: 2),
    GuitarString(note: Note.g, stringNumber: 3),
    GuitarString(note: Note.d, stringNumber: 4),
    GuitarString(note: Note.a, stringNumber: 5),
    GuitarString(note: Note.e, stringNumber: 6),
  ];
}

class HalfStepDownTuning extends Tuning {
  @override
  String get name => 'Half step down (EbAbDbGbBbEb)';

  @override
  List<GuitarString> get strings => const [
    GuitarString(note: Note.ef, stringNumber: 1),
    GuitarString(note: Note.bf, stringNumber: 2),
    GuitarString(note: Note.gf, stringNumber: 3),
    GuitarString(note: Note.df, stringNumber: 4),
    GuitarString(note: Note.af, stringNumber: 5),
    GuitarString(note: Note.ef, stringNumber: 6),
  ];
}

class DropDTuning extends Tuning {
  @override
  String get name => 'Drop D (DADGBE)';

  @override
  List<GuitarString> get strings => const [
    GuitarString(note: Note.e, stringNumber: 1),
    GuitarString(note: Note.b, stringNumber: 2),
    GuitarString(note: Note.g, stringNumber: 3),
    GuitarString(note: Note.d, stringNumber: 4),
    GuitarString(note: Note.a, stringNumber: 5),
    GuitarString(note: Note.d, stringNumber: 6),
  ];
}

class OpenDTuning extends Tuning {
  @override
  String get name => 'Open D (DADF#AD)';

  @override
  List<GuitarString> get strings => const [
    GuitarString(note: Note.d, stringNumber: 1),
    GuitarString(note: Note.a, stringNumber: 2),
    GuitarString(note: Note.fs, stringNumber: 3),
    GuitarString(note: Note.d, stringNumber: 4),
    GuitarString(note: Note.a, stringNumber: 5),
    GuitarString(note: Note.d, stringNumber: 6),
  ];
}

class OpenGTuning extends Tuning {
  @override
  String get name => 'Open G (DGDGBD)';

  @override
  List<GuitarString> get strings => const [
    GuitarString(note: Note.d, stringNumber: 1),
    GuitarString(note: Note.b, stringNumber: 2),
    GuitarString(note: Note.g, stringNumber: 3),
    GuitarString(note: Note.d, stringNumber: 4),
    GuitarString(note: Note.g, stringNumber: 5),
    GuitarString(note: Note.d, stringNumber: 6),
  ];
}

class DropCTuning extends Tuning {
  @override
  String get name => 'Drop C (CGCFAD)';

  @override
  List<GuitarString> get strings => const [
    GuitarString(note: Note.d, stringNumber: 1),
    GuitarString(note: Note.a, stringNumber: 2),
    GuitarString(note: Note.f, stringNumber: 3),
    GuitarString(note: Note.c, stringNumber: 4),
    GuitarString(note: Note.g, stringNumber: 5),
    GuitarString(note: Note.c, stringNumber: 6),
  ];
}

class CelticTuning extends Tuning {
  @override
  String get name => 'Celtic (DADGAD)';

  @override
  List<GuitarString> get strings => const [
    GuitarString(note: Note.d, stringNumber: 1),
    GuitarString(note: Note.a, stringNumber: 2),
    GuitarString(note: Note.g, stringNumber: 3),
    GuitarString(note: Note.d, stringNumber: 4),
    GuitarString(note: Note.a, stringNumber: 5),
    GuitarString(note: Note.d, stringNumber: 6),
  ];
}

class CustomTuning extends Tuning {
  CustomTuning(this.notes);
  final List<Note> notes;

  @override
  String get name =>
      'Custom (${notes[0]}${notes[1]}${notes[2]}${notes[3]}${notes[4]}${notes[5]})';

  @override
  List<GuitarString> get strings => [
    GuitarString(note: notes[5], stringNumber: 1),
    GuitarString(note: notes[4], stringNumber: 2),
    GuitarString(note: notes[3], stringNumber: 3),
    GuitarString(note: notes[2], stringNumber: 4),
    GuitarString(note: notes[1], stringNumber: 5),
    GuitarString(note: notes[0], stringNumber: 6),
  ];
}
