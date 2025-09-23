enum Note {
  c,
  cs,
  d,
  ds,
  df,
  e,
  ef,
  f,
  fs,
  g,
  gs,
  gf,
  a,
  as,
  af,
  b,
  bf;

  String get notation {
    switch (this) {
      case Note.cs:
        return 'C#';
      case Note.ds:
        return 'D#';
      case Note.df:
        return 'Db';
      case Note.ef:
        return 'Eb';
      case Note.fs:
        return 'F#';
      case Note.gs:
        return 'G#';
      case Note.gf:
        return 'Gb';
      case Note.as:
        return 'A#';
      case Note.af:
        return 'Ab';
      case Note.bf:
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
