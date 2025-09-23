import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:string_stack/domain/models/tuning.dart';

class TuningsWheel extends StatelessWidget {
  const TuningsWheel({
    super.key,
    required this.onTuningChanged,
    required this.tunings,
  });
  final List<Tuning> tunings;
  final Function(int) onTuningChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: double.infinity,
      child: ListWheelScrollView.useDelegate(
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: tunings.length,
          builder: (context, index) => SizedBox(
            width: double.infinity,
            child: Text(
              tunings[index].name,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
        perspective: 0.005,
        diameterRatio: 2,
        physics: FixedExtentScrollPhysics(),
        magnification: 1.1,
        overAndUnderCenterOpacity: 0.35,
        itemExtent: 30,
        squeeze: 1.1,
        onSelectedItemChanged: (value) {
          onTuningChanged(value);
          HapticFeedback.lightImpact();
        },
      ),
    );
  }
}
