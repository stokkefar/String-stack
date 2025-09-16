enum Note {
  c,
  cs,
  d,
  ds,
  e,
  f,
  fs,
  g,
  gs,
  a,
  as,
  b;

  // Sharp notation
  String get sharp {
    switch (this) {
      case Note.cs:
        return 'C#';
      case Note.ds:
        return 'D#';
      case Note.fs:
        return 'F#';
      case Note.gs:
        return 'G#';
      case Note.as:
        return 'A#';
      default:
        return name.toUpperCase();
    }
  }

  // Flat notation
  String get flat {
    switch (this) {
      case Note.cs:
        return 'Db';
      case Note.ds:
        return 'Eb';
      case Note.fs:
        return 'Gb';
      case Note.gs:
        return 'Ab';
      case Note.as:
        return 'Bb';
      default:
        return name.toUpperCase();
    }
  }

  // Get note at semitone distance
  Note transpose(int semitones) {
    final currentIndex = Note.values.indexOf(this);
    final newIndex = (currentIndex + semitones) % 12;
    return Note.values[newIndex < 0 ? newIndex + 12 : newIndex];
  }

  // Calculate semitone distance to another note
  int semitonesTo(Note other) {
    final thisIndex = Note.values.indexOf(this);
    final otherIndex = Note.values.indexOf(other);
    return (otherIndex - thisIndex) % 12;
  }
}
