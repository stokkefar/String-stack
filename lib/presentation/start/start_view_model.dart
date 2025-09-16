import 'package:injectable/injectable.dart';
import 'package:signals/signals_flutter.dart';
import 'package:string_stack/domain/models/tuning.dart';

@injectable
class StartViewModel {
  final Signal<List<Tuning>> tunings = signal([
    StandardTuning(),
    DropDTuning(),
    OpenDTuning(),
    OpenGTuning(),
    DropCTuning(),
  ]);

  late final Signal<Tuning> selectedTuning = signal(tunings.value.first);

  void onTuningChanged(int index) => selectedTuning.set(tunings.value[index]);
}
