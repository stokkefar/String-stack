import 'package:injectable/injectable.dart';
import 'package:signals/signals_flutter.dart';
import 'package:string_stack/domain/models/guitar_string.dart';
import 'package:string_stack/domain/models/tuning.dart';

@injectable
class TabsCreatorViewModel {
  late final Signal<Tuning> tuning = signal(_tuning);
  late final Signal<List<List<GuitarString>>> tabs = signal([[]]);
  final Signal<int> tabSections = signal(1);
  final Signal<int> currentSection = signal(0);

  TabsCreatorViewModel(@factoryParam this._tuning);
  final Tuning _tuning;

  void onNextTabSection() {
    int section = currentSection.value;

    if (section == tabSections.value - 1) {
      tabs.value.add([]);
      tabSections.set(tabSections.value + 1);
    }
  }

  void onSectionChanged(int section) => currentSection.set(section);

  List<GuitarString> get currentTab => tabs.value[currentSection.value];

  void placeTab(GuitarString tab) {
    final newTabs = List<List<GuitarString>>.from(tabs.value);

    newTabs[currentSection.value].add(tab);

    tabs.set(newTabs);
  }

  void removeTab(GuitarString tab) {
    final newTabs = List<List<GuitarString>>.from(tabs.value);

    newTabs[currentSection.value].remove(tab);

    tabs.set(newTabs);
  }
}
