import 'package:flutter/material.dart';

void main() {
  runApp(VoterEligibilityApp());
}

class VoterEligibilityApp extends StatelessWidget {
  const VoterEligibilityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Voter Eligibility',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: VoterEligibilityScreen(),
    );
  }
}

class VoterEligibilityScreen extends StatefulWidget {
  const VoterEligibilityScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _VoterEligibilityScreenState createState() => _VoterEligibilityScreenState();
}

class _VoterEligibilityScreenState extends State<VoterEligibilityScreen> {
  final List<Map<String, dynamic>> _people = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  void _addPerson() {
    final String name = _nameController.text;
    final int? age = int.tryParse(_ageController.text);

    if (name.isNotEmpty && age != null) {
      setState(() {
        _people.add({'name': name, 'age': age});
      });
      _nameController.clear();
      _ageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final eligible = _people.where((person) => person['age'] >= 18).toList();
    final notEligible = _people.where((person) => person['age'] < 18).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Voter Eligibility Checker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addPerson,
              child: Text('Add Person'),
            ),
            SizedBox(height: 20),
            Text('Eligible to Vote:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ...eligible
                .map((person) => Text('${person['name']} (${person['age']})')),
            SizedBox(height: 20),
            Text('Not Eligible to Vote:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ...notEligible
                .map((person) => Text('${person['name']} (${person['age']})')),
          ],
        ),
      ),
    );
  }
}
