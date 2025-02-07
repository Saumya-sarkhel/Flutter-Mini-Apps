import 'package:flutter/material.dart';

void main() => runApp(const BMICalculator());

class BMICalculator extends StatelessWidget {
  const BMICalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const BMIHome(),
    );
  }
}

class BMIHome extends StatefulWidget {
  const BMIHome({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BMIHomeState createState() => _BMIHomeState();
}

class _BMIHomeState extends State<BMIHome> {
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  String bmiResult = '';
  String classification = '';
  Color resultColor = Colors.black;

  void calculateBMI() {
    try {
      double weight = double.parse(weightController.text);
      double heightCm = double.parse(heightController.text);

      if (weight <= 0 || heightCm <= 0) {
        throw Exception('Invalid values');
      }

      double heightM = heightCm / 100;
      double bmi = weight / (heightM * heightM);

      setState(() {
        bmiResult = bmi.toStringAsFixed(1);

        if (bmi < 18.5) {
          classification = 'Underweight';
          resultColor = Colors.red;
        } else if (bmi >= 18.5 && bmi <= 24.9) {
          classification = 'Normal weight';
          resultColor = Colors.green;
        } else if (bmi >= 25 && bmi <= 29.9) {
          classification = 'Overweight';
          resultColor = Colors.orange;
        } else {
          classification = 'Obese';
          resultColor = Colors.red;
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter valid positive numbers',
              style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Enter Your Details',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: weightController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Weight',
                          prefixIcon: Icon(Icons.line_weight),
                          suffixText: 'kg',
                          border: OutlineInputBorder(),
                          helperText: 'Enter weight in kilograms',
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: heightController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Height',
                          prefixIcon: Icon(Icons.height),
                          suffixText: 'cm',
                          border: OutlineInputBorder(),
                          helperText: 'Enter height in centimeters',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: calculateBMI,
                icon: const Icon(Icons.calculate),
                label:
                    const Text('Calculate BMI', style: TextStyle(fontSize: 16)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              if (bmiResult.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                    // ignore: deprecated_member_use
                    border: Border.all(color: resultColor.withOpacity(0.2)),
                  ),
                  child: Column(
                    children: [
                      Text('Your BMI',
                          style: Theme.of(context).textTheme.labelLarge),
                      const SizedBox(height: 8),
                      Text(bmiResult,
                          style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: resultColor)),
                      Text(classification,
                          style: TextStyle(
                              fontSize: 18,
                              color: resultColor,
                              fontWeight: FontWeight.w500)),
                      const SizedBox(height: 12),
                      Text(
                        _getHealthMessage(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _getHealthMessage() {
    switch (classification) {
      case 'Underweight':
        return 'Consider consulting a nutritionist to reach a healthy weight';
      case 'Normal weight':
        return 'Great! Maintain your healthy lifestyle';
      case 'Overweight':
        return 'Consider increasing physical activity and improving diet';
      case 'Obese':
        return 'Please consult a healthcare professional for guidance';
      default:
        return '';
    }
  }
}
