import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(StopwatchApp());
}

class StopwatchApp extends StatefulWidget {
  @override
  _StopwatchAppState createState() => _StopwatchAppState();
}

class _StopwatchAppState extends State<StopwatchApp> {
  DateTime? _startTime; // Track the start time
  Duration _elapsed = Duration.zero; // Track the elapsed time
  Timer? _timer;
  bool _isRunning = false;
  List<String> _lapTimes = []; // Store top three times

  void _startTimer() {
    _startTime = DateTime.now();
    _isRunning = true;
    _timer = Timer.periodic(Duration(milliseconds: 30), (timer) {
      setState(() {
        _elapsed = DateTime.now().difference(_startTime!);
      });
    });
  }

  void _stopTimer() {
    _isRunning = false;
    _timer?.cancel();
  }

  void _resetTimer() {
    _stopTimer();
    setState(() {
      _elapsed = Duration.zero;
    });
  }

  void _recordLap() {
    if (_lapTimes.length < 3) {
      setState(() {
        _lapTimes.add(_formatTime(_elapsed));
      });
    }
  }

  void _resetLaps() {
    setState(() {
      _lapTimes.clear();
    });
  }

  String _formatTime(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;
    final milliseconds = (duration.inMilliseconds % 1000) ~/ 10;

    return '${hours.toString().padLeft(2, '0')}:'
        '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}.'
        '${milliseconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Enhanced Stopwatch'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                _formatTime(_elapsed),
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Column(
                children: _lapTimes.asMap().entries.map((entry) {
                  return Text(
                    'Contestant ${entry.key + 1}: ${entry.value}',
                    style: TextStyle(fontSize: 20),
                  );
                }).toList(),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: _isRunning ? null : _startTimer,
                    child: Text('Start'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _isRunning ? _stopTimer : null,
                    child: Text('Stop'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _resetTimer,
                    child: Text('Reset Timer'),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed:
                        _isRunning && _lapTimes.length < 3 ? _recordLap : null,
                    child: Text('Record Lap'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _resetLaps,
                    child: Text('Reset Laps'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
