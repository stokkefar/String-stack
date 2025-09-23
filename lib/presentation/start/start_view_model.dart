import 'package:injectable/injectable.dart';
import 'package:signals/signals_flutter.dart';
import 'package:string_stack/domain/models/note.dart';
import 'package:string_stack/domain/models/tuning.dart';

@injectable
class StartViewModel {
  final Signal<List<Tuning>> tunings = signal([
    StandardTuning(),
    HalfStepDownTuning(),
    DropDTuning(),
    CelticTuning(),
    OpenDTuning(),
    OpenGTuning(),
    DropCTuning(),
  ]);

  final Signal<bool> isCustomTuning = signal(false);
  final Signal<List<Note>> customTuning = signal([
    Note.e,
    Note.a,
    Note.d,
    Note.g,
    Note.b,
    Note.e,
  ]);

  late final Signal<Tuning> selectedTuning = signal(tunings.value.first);

  void onTuningChanged(int index) => selectedTuning.set(tunings.value[index]);

  void onCustomTuningChanged(int noteIndex, int tuningIndex) {
    final tuning = List<Note>.from(customTuning.value);

    tuning[tuningIndex] = Note.values[noteIndex];

    customTuning.set(tuning);
  }

  void onCustomTuningOptionTapped() =>
      isCustomTuning.set(!isCustomTuning.value);

  void saveTuning() {
    if (isCustomTuning()) {
      selectedTuning.set(CustomTuning(customTuning()));
    }
  }
}
