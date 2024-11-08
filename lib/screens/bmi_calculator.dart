import 'package:flutter/material.dart';

class BMICalculatorScreen extends StatefulWidget {
  const BMICalculatorScreen({super.key});

  @override
  _BMICalculatorScreenState createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  String _bmiResult = "";
  String _bmiCategory = "";

  // List to store saved BMI progress
  List<Map<String, dynamic>> _savedProgress = [];

  void _calculateBMI() {
    final height = double.parse(_heightController.text) / 100;
    final weight = double.parse(_weightController.text);
    final bmi = weight / (height * height);

    // Determine BMI category
    String category = "";
    if (bmi < 18.5) {
      category = "Underweight";
    } else if (bmi >= 18.5 && bmi < 24.9) {
      category = "Normal weight";
    } else if (bmi >= 25 && bmi < 29.9) {
      category = "Overweight";
    } else {
      category = "Obese";
    }

    setState(() {
      _bmiResult = "Your BMI: ${bmi.toStringAsFixed(2)}";
      _bmiCategory = "Category: $category";
    });
  }

  // Function to save the progress
  void _saveProgress() {
    final now = DateTime.now();
    final formattedDate = "${now.day}-${now.month}-${now.year} ${now.hour}:${now.minute}";

    // Save the progress data
    setState(() {
      _savedProgress.add({
        'height': _heightController.text,
        'weight': _weightController.text,
        'bmi': _bmiResult,
        'category': _bmiCategory,
        'dateTime': formattedDate,
      });
    });

    // Clear the inputs after saving
    _heightController.clear();
    _weightController.clear();
    _bmiResult = "";
    _bmiCategory = "";

    // Show confirmation snack bar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Data Saved!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BMI Calculator"),
        centerTitle: true,
        backgroundColor: Colors.orange[300],
      ),
      body: Stack(
        children: [
          // Main body content
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange[100]!, Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: _heightController,
                      decoration: InputDecoration(
                        labelText: "Height (cm)",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _weightController,
                      decoration: InputDecoration(
                        labelText: "Weight (kg)",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _calculateBMI,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        backgroundColor: Colors.orange[300],
                      ),
                      child: const Text("Calculate BMI", style: TextStyle(fontSize: 16)),
                    ),
                    const SizedBox(height: 20),
                    if (_bmiResult.isNotEmpty)
                      Text(
                        _bmiResult,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
                        textAlign: TextAlign.center,
                      ),
                    const SizedBox(height: 10),
                    if (_bmiCategory.isNotEmpty)
                      Text(
                        _bmiCategory,
                        style: const TextStyle(fontSize: 20, color: Colors.black87),
                        textAlign: TextAlign.center,
                      ),
                  ],
                ),
              ),
            ),
          ),
          
          // Save Progress button in the bottom-right corner
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: _saveProgress,
              backgroundColor: Colors.orange[300],
              child: const Icon(Icons.save),
            ),
          ),
        ],
      ),
    );
  }
}
