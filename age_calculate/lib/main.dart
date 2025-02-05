import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(const AgeCalculatorApp());

class AgeCalculatorApp extends StatelessWidget {
  const AgeCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Age Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const AgeCalculatorScreen(),
    );
  }
}

class AgeCalculatorScreen extends StatefulWidget {
  const AgeCalculatorScreen({super.key});

  @override
  AgeCalculatorScreenState createState() => AgeCalculatorScreenState();
}

class AgeCalculatorScreenState extends State<AgeCalculatorScreen> {
  final TextEditingController _dobController = TextEditingController();
  String _ageResult = '';

  void _calculateAge() {
    final dobString = _dobController.text;
    try {
      final dob = DateFormat('yyyy-MM-dd').parse(dobString);
      final now = DateTime.now();

      int years = now.year - dob.year;
      int months = now.month - dob.month;
      int days = now.day - dob.day;

      if (days < 0) {
        final previousMonth = DateTime(now.year, now.month, 0);
        days += previousMonth.day;
        months--;
      }

      if (months < 0) {
        months += 12;
        years--;
      }

      setState(() {
        _ageResult = 'Your age is: $years years, $months months, and $days days';
      });
    } catch (e) {
      setState(() {
        _ageResult = 'Invalid date format. Please use yyyy-mm-dd';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Age Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _dobController,
              decoration: const InputDecoration(
                labelText: 'Enter Date of Birth (yyyy-mm-dd)',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_today),
              ),
              keyboardType: TextInputType.datetime,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateAge,
              child: const Text('Calculate Age'),
            ),
            const SizedBox(height: 20),
            Text(
              _ageResult,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
