import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_stopwatch/extension.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// Current elapsed time of the stopwatch
  Duration elapsedTime = Duration.zero;

  /// All the recorded laps
  List<Duration> laps = [];

  /// [Timer] that can be used to add time to [elapsedTime]
  Timer? timer;

  /// Checks if the [timer] is active. Set to `false` if [timer] is null
  bool get isTimerActive => timer?.isActive ?? false;

  /// If the elapsed time is more than 0 AND the timer is active, we record a
  /// new lap. If the elapsed time is more than 0 AND the timer is not active,
  /// we reset everything (set [elapsedTime] to zero, [laps] to empty list, and
  /// cancel and get rid of the [timer])
  void recordLapsOrReset() {
    if (elapsedTime > Duration.zero && isTimerActive) {
      laps.insert(0, elapsedTime);
    } else if (elapsedTime > Duration.zero && !isTimerActive) {
      setState(() {
        laps = [];
        timer?.cancel();
        timer = null;
        elapsedTime = Duration.zero;
      });
    }
  }

  /// If the [timer] is active, cancel and remove it, and if the [timer] is not
  /// active, initialize a new [Timer]
  void startOrStop() {
    if (isTimerActive) {
      setState(() {
        timer?.cancel();
        timer = null;
      });
    } else {
      timer = Timer.periodic(
        const Duration(milliseconds: 10),
        (_) {
          setState(() {
            elapsedTime += const Duration(milliseconds: 10);
          });
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          24,
          MediaQuery.of(context).padding.top + 48,
          24,
          MediaQuery.of(context).padding.bottom + 24,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadius.all(Radius.circular(16)),
              ),
              height: 240,
              child: FormattedTime(time: elapsedTime),
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (_, __) => const Divider(),
                shrinkWrap: true,
                itemCount: laps.length,
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemBuilder: (context, index) {
                  final lap = laps[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Text('Lap ${laps.length - index}'),
                        const Spacer(),
                        FormattedTime(time: lap, fontSize: 14),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              children: [
                CustomButton(
                  onTap: recordLapsOrReset,
                  label: elapsedTime > Duration.zero && !isTimerActive
                      ? 'Reset'
                      : 'Lap',
                  backgroundColor: elapsedTime < Duration.zero
                      ? Colors.black
                      : Colors.grey[200],
                  labelColor:
                      elapsedTime > Duration.zero ? Colors.black : Colors.grey,
                ),
                const Spacer(),
                CustomButton(
                  onTap: startOrStop,
                  label: isTimerActive ? 'Stop' : 'Start',
                  backgroundColor: isTimerActive
                      ? Colors.redAccent[100]
                      : Colors.greenAccent[100],
                  labelColor: isTimerActive
                      ? Colors.redAccent[700]
                      : Colors.greenAccent[700],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.onTap,
    required this.label,
    this.backgroundColor,
    this.labelColor,
    super.key,
  });

  final VoidCallback onTap;
  final String label;
  final Color? backgroundColor;
  final Color? labelColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(36)),
          color: backgroundColor,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(color: labelColor, fontSize: 24),
          ),
        ),
      ),
    );
  }
}

class FormattedTime extends StatelessWidget {
  const FormattedTime({
    required this.time,
    this.fontSize = 56,
    super.key,
  });

  final Duration time;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(
        color: Colors.black,
        fontSize: fontSize,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: fontSize * 1.33,
            child: Center(
              child: Text(time.formattedMinutes),
            ),
          ),
          const Text(':'),
          SizedBox(
            width: fontSize * 1.33,
            child: Center(
              child: Text(time.formattedSeconds),
            ),
          ),
          const Text('.'),
          SizedBox(
            width: fontSize * 1.33,
            child: Center(
              child: Text(time.formattedMilliseconds),
            ),
          ),
        ],
      ),
    );
  }
}
