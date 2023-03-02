import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_stopwatch/extension.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Duration duration = Duration.zero;
  Timer? timer;
  List<Duration> laps = [];

  bool get isTimerActive => timer?.isActive ?? false;

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
              child: FormattedTime(time: duration),
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return const Divider();
                },
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
                GestureDetector(
                  onTap: () {
                    if (duration > Duration.zero && isTimerActive) {
                      laps.insert(0, duration);
                    } else if (duration > Duration.zero && !isTimerActive) {
                      laps = [];
                      timer?.cancel();
                      setState(() {
                        timer = null;
                        duration = Duration.zero;
                      });
                    }
                  },
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(24)),
                      color: duration < Duration.zero
                          ? Colors.black
                          : Colors.grey[200],
                    ),
                    child: Center(
                      child: Text(
                        duration > Duration.zero && !isTimerActive
                            ? 'Reset'
                            : 'Lap',
                        style: TextStyle(
                          color: duration > Duration.zero
                              ? Colors.black
                              : Colors.grey,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    if (!isTimerActive) {
                      timer = Timer.periodic(const Duration(milliseconds: 10),
                          (timer) {
                        setState(() {
                          duration += const Duration(milliseconds: 10);
                        });
                      });
                    } else {
                      timer?.cancel();
                      setState(() {
                        timer = null;
                      });
                    }
                  },
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(24)),
                      color: isTimerActive
                          ? Colors.redAccent[100]
                          : Colors.greenAccent[100],
                    ),
                    child: Center(
                      child: Text(
                        isTimerActive ? 'Stop' : 'Start',
                        style: TextStyle(
                          color: isTimerActive
                              ? Colors.redAccent[700]
                              : Colors.greenAccent[700],
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
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
