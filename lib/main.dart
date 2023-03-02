import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top),
          Container(
            height: 240,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                      ((timer?.tick ?? 0) ~/ 10000).toString().padLeft(2, '0')),
                  const Text(':'),
                  Text(((timer?.tick ?? 0) ~/ 100).toString().padLeft(2, '0')),
                  const Text('.'),
                  Text(((timer?.tick ?? 0) % 100).toString().padLeft(2, '0')),
                ],
              ),
            ),
          ),
          const Spacer(),
          Row(
            children: [
              const Spacer(),
              GestureDetector(
                onTap: () {
                  if (timer?.isActive == null) {
                    timer = Timer.periodic(const Duration(milliseconds: 10),
                        (timer) {
                      setState(() {});
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
                  color: (timer?.isActive == true)
                      ? Colors.red
                      : Colors.lightGreen,
                  child: Text((timer?.isActive == true) ? 'Stop' : 'Start'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 48),
        ],
      ),
    );
  }
}
