import 'package:injectable/injectable.dart';
import 'package:signals/signals_flutter.dart';
import 'package:string_stack/domain/models/fret_position.dart';
import 'package:string_stack/domain/models/guitar_string.dart';
import 'package:string_stack/domain/models/tuning.dart';

@injectable
class ChordCreatorViewModel {
  final Signal<Tuning> tuning = signal(StandardTuning());
  final Signal<List<GuitarString>> tabs = signal([]);

  ChordCreatorViewModel(@factoryParam this._tuning);
  final Tuning _tuning;

  @postConstruct
  void init() {
    tuning.set(_tuning);
    tabs.set(tuning.value.strings.reversed.toList());
  }

  void onPlaceTab(GuitarString incomingStringTab) {
    final currentTabs = List<GuitarString>.from(tabs.value);

    // Create the occupied finger position
    FretPosition? fingerPosition = incomingStringTab.fingerPosition?.copyWith(
      note: incomingStringTab.note,
    );

    // Create the updated tab with finger position to be set at the end
    final updatedString = incomingStringTab.copyWith(
      fingerPosition: fingerPosition,
    );

    // Check if incoming tab already is occupied
    if (incomingStringTab.fingerPosition?.note == null) {
      // If not we update the list by index so the string is still positioned correctly
      final index = currentTabs.indexWhere(
        (tab) =>
            tab.note == incomingStringTab.note &&
            tab.stringNumber == incomingStringTab.stringNumber,
      );
      if (index != -1) {
        currentTabs[index] = updatedString;
      }
    } else {
      // If incoming tab has a note we remove the position from the
      // previous string and place it on the new (incoming) string
      final indexOldString = currentTabs.indexWhere(
        (tab) => tab.note == incomingStringTab.fingerPosition?.note,
      );

      if (indexOldString != -1) {
        currentTabs[indexOldString] = currentTabs[indexOldString].copyWith(
          fingerPosition: null,
        );
      }

      final indexIncoming = currentTabs.indexWhere(
        (tab) =>
            tab.note == incomingStringTab.note &&
            tab.stringNumber == incomingStringTab.stringNumber,
      );

      if (indexIncoming != -1) {
        currentTabs[indexIncoming] = updatedString;
      }
    }
    tabs.set(currentTabs);
  }

  void removeStringTab(GuitarString stringTab) {
    final currentTabs = List<GuitarString>.from(tabs.value);

    final index = currentTabs.indexWhere(
      (tab) =>
          tab.note == stringTab.note &&
          tab.stringNumber == stringTab.stringNumber,
    );

    currentTabs[index] = currentTabs[index].copyWith(fingerPosition: null);

    tabs.set(currentTabs);
  }

  void handlePlaceTabOnTap(FretPosition fret) {
    for (GuitarString string in tabs.value) {
      if (string.fingerPosition == null) {
        onPlaceTab(string.copyWith(fingerPosition: fret));
        return;
      }
    }
  }

  void clearTabs() {
    tabs.set(tuning.value.strings.reversed.toList());
  }
}
