import 'package:string_stack/domain/models/guitar_string.dart';
import 'package:string_stack/domain/models/note.dart';

abstract class Tuning {
  String get name;
  List<GuitarString> get strings; // From high to low (1st string to 6th string)

  int get stringCount => strings.length;

  GuitarString getStringInfo(int stringIndex) => strings[stringIndex];

  // Get string by string number (1-6)
  GuitarString getStringByNumber(int stringNumber) {
    return strings.firstWhere((s) => s.stringNumber == stringNumber);
  }
}

class StandardTuning extends Tuning {
  @override
  String get name => 'Standard (EADGBE)';

  @override
  List<GuitarString> get strings => const [
    GuitarString(note: Note.e, stringNumber: 1), // High E
    GuitarString(note: Note.b, stringNumber: 2), // B
    GuitarString(note: Note.g, stringNumber: 3), // G
    GuitarString(note: Note.d, stringNumber: 4), // D
    GuitarString(note: Note.a, stringNumber: 5), // A
    GuitarString(note: Note.e, stringNumber: 6), // Low E
  ];
}

class DropDTuning extends Tuning {
  @override
  String get name => 'Drop D (DADGBE)';

  @override
  List<GuitarString> get strings => const [
    GuitarString(note: Note.e, stringNumber: 1), // High E
    GuitarString(note: Note.b, stringNumber: 2), // B
    GuitarString(note: Note.g, stringNumber: 3), // G
    GuitarString(note: Note.d, stringNumber: 4), // D
    GuitarString(note: Note.a, stringNumber: 5), // A
    GuitarString(note: Note.d, stringNumber: 6), // Dropped D
  ];
}

class OpenDTuning extends Tuning {
  @override
  String get name => 'Open D (DADF#AD)';

  @override
  List<GuitarString> get strings => const [
    GuitarString(note: Note.d, stringNumber: 1), // High E
    GuitarString(note: Note.a, stringNumber: 2), // B
    GuitarString(note: Note.fs, stringNumber: 3), // G
    GuitarString(note: Note.d, stringNumber: 4), // D
    GuitarString(note: Note.a, stringNumber: 5), // A
    GuitarString(note: Note.d, stringNumber: 6), // Dropped D
  ];
}

class OpenGTuning extends Tuning {
  @override
  String get name => 'Open G (DGDGBD)';

  @override
  List<GuitarString> get strings => const [
    GuitarString(note: Note.d, stringNumber: 1), // High E
    GuitarString(note: Note.b, stringNumber: 2), // B
    GuitarString(note: Note.g, stringNumber: 3), // G
    GuitarString(note: Note.d, stringNumber: 4), // D
    GuitarString(note: Note.g, stringNumber: 5), // A
    GuitarString(note: Note.d, stringNumber: 6), // Dropped D
  ];
}

class DropCTuning extends Tuning {
  @override
  String get name => 'Drop C (CGCFAD)';

  @override
  List<GuitarString> get strings => const [
    GuitarString(note: Note.d, stringNumber: 1), // High E
    GuitarString(note: Note.a, stringNumber: 2), // B
    GuitarString(note: Note.f, stringNumber: 3), // G
    GuitarString(note: Note.c, stringNumber: 4), // D
    GuitarString(note: Note.g, stringNumber: 5), // A
    GuitarString(note: Note.c, stringNumber: 6), // Dropped D
  ];
}
