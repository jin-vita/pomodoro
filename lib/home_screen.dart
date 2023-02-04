import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const timerTime = 1500;
  int totalSeconds = timerTime;
  bool isRunning = false;
  int totalCount = 0;
  Timer? timer;

  void onTick(Timer timer) {
    setState(() {});
    if (totalSeconds == 0) {
      totalCount++;
      isRunning = false;
      totalSeconds = timerTime;
      timer.cancel();
    } else {
      totalSeconds = totalSeconds - 1;
    }
  }

  void onStartPressed() {
    setState(() {});
    isRunning
        ? timer?.cancel()
        : timer = Timer.periodic(
            const Duration(seconds: 1),
            onTick,
          );
    isRunning = !isRunning;
  }

  void onRestartPressed() {
    setState(() {});

    timer?.cancel();
    totalSeconds = timerTime;
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
    );
    isRunning = true;
  }

  void restCount() {
    setState(() {});
    totalCount = 0;
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    return '$duration'.split('.').first.substring(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Flexible(
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                format(totalSeconds),
                style: TextStyle(
                    color: Theme.of(context).cardColor,
                    fontSize: 89,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 150,
                    icon: Icon(
                      isRunning
                          ? Icons.pause_circle_outline
                          : Icons.play_circle_outline,
                      color: Theme.of(context).cardColor,
                    ),
                    onPressed: onStartPressed,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  IconButton(
                    iconSize: 150,
                    icon: Icon(
                      Icons.restore_rounded,
                      color: Theme.of(context).cardColor,
                    ),
                    onPressed: onRestartPressed,
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: restCount,
                          child: Text(
                            'Pomodors',
                            style: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.color,
                            ),
                          ),
                        ),
                        Text(
                          '$totalCount',
                          style: TextStyle(
                            fontSize: 58,
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).textTheme.displayLarge?.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
