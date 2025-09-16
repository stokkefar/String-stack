import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';
import 'package:string_stack/di/di_setup.dart';
import 'package:string_stack/modifiers/padding.dart';
import 'package:string_stack/presentation/start/start_view_model.dart';
import 'package:string_stack/presentation/start/widgets/tunings_wheel.dart';
import 'package:string_stack/presentation/chord_creator/chord_creator_screen.dart';

class StartScreen extends StatelessWidget {
  StartScreen({super.key});
  late final StartViewModel vm = getIt.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Create song tabs",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 24),
            Text(
              "Select your tuning and get started on creating tabs for your song",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Tuning", style: Theme.of(context).textTheme.titleLarge),
                Text(
                  "Custom",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),

            TuningsWheel(
              onTuningChanged: (index) => vm.onTuningChanged(index),
              tunings: vm.tunings.value,
            ).padding(vertical: 24),

            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChordCreatorScreen(
                        tuning: vm.selectedTuning.watch(context),
                      ),
                    ),
                  );
                },

                child: Text("Next"),
              ),
            ),
          ],
        ).padding(horizontal: 24),
      ),
    );
  }
}
