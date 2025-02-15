import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const StopwatchApp());
}

class StopwatchApp extends StatelessWidget {
  const StopwatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stopwatch',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 5, 54, 94),
      ),
      home: const StopwatchScreen(),
    );
  }
}

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StopwatchScreenState createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  bool _isRunning = false;
  int _milliseconds = 0;
  late Timer _timer;
  DateTime? _startTime;

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  void _startStopwatch() {
    setState(() {
      _isRunning = true;
      _startTime = DateTime.now();
    });
    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {
        _milliseconds = DateTime.now().difference(_startTime!).inMilliseconds;
      });
    });
  }

  void _stopStopwatch() {
    setState(() {
      _isRunning = false;
    });
    _timer.cancel(); // Stop the timer
  }

  void _resetStopwatch() {
    setState(() {
      _isRunning = false;
      _milliseconds = 0;
    });
    _timer.cancel(); // Reset the timer
  }

  String _formatTime(int milliseconds) {
    final duration = Duration(milliseconds: milliseconds);
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    final hundredths = (duration.inMilliseconds.remainder(1000) ~/ 10)
        .toString()
        .padLeft(2, '0');
    return '$minutes:$seconds.$hundredths';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stopwatch'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              decoration: const ShapeDecoration(
                shape: CircleBorder(
                  side: BorderSide(width: 4, color: Colors.black),
                ),
              ),
              padding: const EdgeInsets.all(60.0),
              child: Text(
                _formatTime(_milliseconds),
                style: const TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _isRunning ? null : _startStopwatch,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    shape: const CircleBorder(),
                  ),
                  child: const Icon(Icons.play_arrow, size: 30),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _isRunning ? _stopStopwatch : null,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    shape: const CircleBorder(),
                  ),
                  child: const Icon(Icons.pause, size: 30),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: !_isRunning ? _resetStopwatch : null,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    shape: const CircleBorder(),
                  ),
                  child: const Icon(Icons.refresh, size: 30),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
