import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fruit App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 68, 66, 180)),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> fruits = [
    'Apple',
    'Banana',
    'Orange',
    'Mango',
    'Grapes',
    'Pineapple',
    'Strawberry',
    'Watermelon',
    'Kiwi',
    'Peach'
  ];
  bool showFruits = false;

  void _toggleFruits() {
    setState(() {
      showFruits = !showFruits;
      if (showFruits) {
        fruits.shuffle();
      }
    });
  }

  void _navigateToSecondPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SecondPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fruit App'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _toggleFruits,
              child: Text(showFruits ? 'Hide Fruits' : 'Show Fruits'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _navigateToSecondPage(context),
              child: const Text('Tap to Second Page'),
            ),
            const SizedBox(height: 20),
            Visibility(
              visible: showFruits,
              child: Expanded(
                child: ListView.builder(
                  itemCount: fruits.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(fruits[index]),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Page'),
      ),
      body: const Center(
        child: Text(
          'Welcome to the Second Page!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
