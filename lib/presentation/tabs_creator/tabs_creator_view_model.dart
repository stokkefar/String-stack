import 'package:injectable/injectable.dart';
import 'package:signals/signals_flutter.dart';
import 'package:string_stack/domain/models/guitar_string.dart';
import 'package:string_stack/domain/models/tuning.dart';

@injectable
class TabsCreatorViewModel {
  late final Signal<Tuning> tuning = signal(_tuning);
  // Keep it simple - map of section -> string key -> tabs
  late final Signal<Map<int, Map<String, List<TabNote>>>> tabs = signal({
    0: {},
  });
  final Signal<int> tabSections = signal(1);
  final Signal<int> currentSection = signal(0);

  TabsCreatorViewModel(@factoryParam this._tuning);
  final Tuning _tuning;

  void onNextTabSection() {
    int section = currentSection.value;

    if (section == tabSections.value - 1) {
      final newTabs = Map<int, Map<String, List<TabNote>>>.from(tabs.value);
      newTabs[tabSections.value] = {};
      tabs.set(newTabs);
      tabSections.set(tabSections.value + 1);
    }
  }

  void onSectionChanged(int section) => currentSection.set(section);

  // Get tabs for specific section and string
  List<TabNote> getTabsForString(GuitarString guitarString, int sectionIndex) {
    final sectionTabs = tabs.value[sectionIndex] ?? {};
    final stringKey = _getStringKey(guitarString);
    return sectionTabs[stringKey] ?? [];
  }

  void placeTab(GuitarString guitarString, TabNote tabNote) {
    final newTabs = Map<int, Map<String, List<TabNote>>>.from(tabs.value);
    final stringKey = _getStringKey(guitarString);
    final currentSectionIndex = currentSection.value;

    // Ensure the current section exists
    if (!newTabs.containsKey(currentSectionIndex)) {
      newTabs[currentSectionIndex] = {};
    }

    // Get current tabs for this string and add the new one
    final currentStringTabs = List<TabNote>.from(
      newTabs[currentSectionIndex]![stringKey] ?? [],
    );
    currentStringTabs.add(tabNote);

    // Update the tabs - create new map to ensure signal triggers
    newTabs[currentSectionIndex] = Map<String, List<TabNote>>.from(
      newTabs[currentSectionIndex]!,
    );
    newTabs[currentSectionIndex]![stringKey] = currentStringTabs;

    tabs.set(newTabs);
  }

  void removeTab(GuitarString guitarString, TabNote tabNote) {
    final newTabs = Map<int, Map<String, List<TabNote>>>.from(tabs.value);
    final stringKey = _getStringKey(guitarString);
    final currentSectionIndex = currentSection.value;

    if (newTabs.containsKey(currentSectionIndex) &&
        newTabs[currentSectionIndex]!.containsKey(stringKey)) {
      final currentStringTabs = List<TabNote>.from(
        newTabs[currentSectionIndex]![stringKey]!,
      );
      currentStringTabs.removeWhere(
        (tab) =>
            tab.fingerPosition == tabNote.fingerPosition &&
            tab.neckPlacement == tabNote.neckPlacement,
      );

      // Create new map to ensure signal triggers
      newTabs[currentSectionIndex] = Map<String, List<TabNote>>.from(
        newTabs[currentSectionIndex]!,
      );
      newTabs[currentSectionIndex]![stringKey] = currentStringTabs;

      tabs.set(newTabs);
    }
  }

  void clearTabsForSection() {
    final newTabs = Map<int, Map<String, List<TabNote>>>.from(tabs.value);
    final currentSectionIndex = currentSection.value;

    newTabs[currentSectionIndex] = {};

    tabs.set(newTabs);
  }

  String _getStringKey(GuitarString guitarString) {
    return '${guitarString.note.toString()}_${guitarString.stringNumber}';
  }
}
