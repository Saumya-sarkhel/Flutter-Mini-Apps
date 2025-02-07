import 'package:flutter/material.dart';

void main() {
  runApp(CurrencyConverterApp());
}

class CurrencyConverterApp extends StatelessWidget {
  const CurrencyConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CurrencyConverterScreen(),
    );
  }
}

class CurrencyConverterScreen extends StatefulWidget {
  const CurrencyConverterScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CurrencyConverterScreenState createState() =>
      _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  final TextEditingController _amountController = TextEditingController();
  String _fromCurrency = 'USD';
  String _toCurrency = 'EUR';
  double _convertedAmount = 0.0;

  final Map<String, double> _exchangeRates = {
    'USD': 1.0,
    'EUR': 0.85,
    'JPY': 110.0,
    'GBP': 0.75,
    'INR': 74.0,
  };

  void _convertCurrency() {
    final double? amount = double.tryParse(_amountController.text);
    if (amount != null) {
      setState(() {
        double fromRate = _exchangeRates[_fromCurrency]!;
        double toRate = _exchangeRates[_toCurrency]!;
        _convertedAmount = (amount / fromRate) * toRate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: _fromCurrency,
                  onChanged: (String? newValue) {
                    setState(() {
                      _fromCurrency = newValue!;
                    });
                  },
                  items: _exchangeRates.keys
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                Text('to'),
                DropdownButton<String>(
                  value: _toCurrency,
                  onChanged: (String? newValue) {
                    setState(() {
                      _toCurrency = newValue!;
                    });
                  },
                  items: _exchangeRates.keys
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convertCurrency,
              child: Text('Convert'),
            ),
            SizedBox(height: 20),
            Text(
              'Converted Amount: ${_convertedAmount.toStringAsFixed(2)} $_toCurrency',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
