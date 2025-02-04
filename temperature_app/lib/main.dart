import 'package:flutter/material.dart';

void main() => runApp(const TemperatureConverterApp());

class TemperatureConverterApp extends StatefulWidget {
  const TemperatureConverterApp({super.key});

  @override
  TemperatureConverterAppState createState() => TemperatureConverterAppState();
}

class TemperatureConverterAppState extends State<TemperatureConverterApp> {
  final TextEditingController _inputController = TextEditingController();
  String? _selectedInputUnit = 'Celsius';
  String? _selectedOutputUnit = 'Fahrenheit';
  String _result = '';

  final List<String> _units = ['Celsius', 'Fahrenheit', 'Kelvin'];

  void _convertTemperature() {
    final input = double.tryParse(_inputController.text);
    if (input == null) {
      setState(() => _result = 'Please enter a valid number');
      return;
    }

    double convertedValue = _convert(
      input,
      from: _selectedInputUnit!,
      to: _selectedOutputUnit!,
    );

    setState(() => _result = '${convertedValue.toStringAsFixed(2)} °${_selectedOutputUnit![0]}');
  }

  double _convert(double value, {required String from, required String to}) {
    // Convert to Celsius first
    switch (from) {
      case 'Fahrenheit':
        value = (value - 32) * 5 / 9;
        break;
      case 'Kelvin':
        value = value - 273.15;
        break;
    }

    // Convert from Celsius to target unit
    switch (to) {
      case 'Fahrenheit':
        return (value * 9 / 5) + 32;
      case 'Kelvin':
        return value + 273.15;
      default:
        return value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Temperature Converter'),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _inputController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      labelText: 'Enter Temperature',
                      floatingLabelAlignment: FloatingLabelAlignment.center,
                      labelStyle: const TextStyle(fontSize: 16),
                      border: const OutlineInputBorder(),
                      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                      errorText: _result.contains('invalid') ? _result : null,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildUnitDropdown(_selectedInputUnit!, (value) {
                        setState(() => _selectedInputUnit = value);
                      }),
                      const Icon(Icons.arrow_right_alt, size: 32),
                      _buildUnitDropdown(_selectedOutputUnit!, (value) {
                        setState(() => _selectedOutputUnit = value);
                      }),
                    ],
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.autorenew, size: 20),
                    label: const Text('CONVERT', style: TextStyle(letterSpacing: 1.2)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[800],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: _convertTemperature,
                  ),
                  const SizedBox(height: 28),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _result.replaceAll('Please enter a valid number', '').trim(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900],
                        letterSpacing: 1.1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUnitDropdown(String value, ValueChanged<String?> onChanged) {
    return Flexible(
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          iconSize: 28,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
          selectedItemBuilder: (context) => _units.map((unit) {
            return Center(
              child: Text(
                unit[0],
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            );
          }).toList(),
          items: _units.map((String unit) {
            return DropdownMenuItem<String>(
              value: unit,
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(unit),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
