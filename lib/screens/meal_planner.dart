import 'package:flutter/material.dart';

class MealPlanner extends StatefulWidget {
  const MealPlanner({super.key});

  @override
  _MealPlannerState createState() => _MealPlannerState();
}

class _MealPlannerState extends State<MealPlanner> {
  final TextEditingController _bmiController = TextEditingController();
  String? _bmiCategory;
  Map<String, Map<String, String>> _mealPlan = {};

  // Function to determine BMI category
  void _calculateBMICategory(double bmi) {
    if (bmi < 18.5) {
      _bmiCategory = 'Underweight';
      _mealPlan = _underweightMealPlan;
    } else if (bmi >= 18.5 && bmi < 24.9) {
      _bmiCategory = 'Normal weight';
      _mealPlan = _normalMealPlan;
    } else if (bmi >= 25 && bmi < 29.9) {
      _bmiCategory = 'Overweight';
      _mealPlan = _overweightMealPlan;
    } else {
      _bmiCategory = 'Obesity';
      _mealPlan = _obesityMealPlan;
    }
  }

  // Sample meal plans for different BMI categories, covering all days of the week
  final Map<String, Map<String, String>> _underweightMealPlan = {
    'Monday': {'Breakfast': 'Peanut butter toast', 'Lunch': 'Chicken and rice', 'Dinner': 'Salmon with sweet potato'},
    'Tuesday': {'Breakfast': 'Oatmeal with nuts', 'Lunch': 'Turkey sandwich', 'Dinner': 'Pasta with meat sauce'},
    'Wednesday': {'Breakfast': 'Avocado toast', 'Lunch': 'Quinoa bowl', 'Dinner': 'Grilled chicken with vegetables'},
    'Thursday': {'Breakfast': 'Scrambled eggs', 'Lunch': 'Chicken wrap', 'Dinner': 'Beef stir-fry'},
    'Friday': {'Breakfast': 'Yogurt with granola', 'Lunch': 'Tuna sandwich', 'Dinner': 'Grilled shrimp with rice'},
    'Saturday': {'Breakfast': 'Smoothie bowl', 'Lunch': 'Veggie burger', 'Dinner': 'Chicken Alfredo pasta'},
    'Sunday': {'Breakfast': 'French toast', 'Lunch': 'Pasta salad', 'Dinner': 'Roasted lamb with potatoes'},
  };

  final Map<String, Map<String, String>> _normalMealPlan = {
    'Monday': {'Breakfast': 'Smoothie bowl', 'Lunch': 'Grilled chicken salad', 'Dinner': 'Stir-fried tofu with veggies'},
    'Tuesday': {'Breakfast': 'Yogurt and berries', 'Lunch': 'Quinoa salad', 'Dinner': 'Roasted chicken with vegetables'},
    'Wednesday': {'Breakfast': 'Egg white omelet', 'Lunch': 'Turkey sandwich', 'Dinner': 'Beef and broccoli stir-fry'},
    'Thursday': {'Breakfast': 'Oatmeal with fruits', 'Lunch': 'Lentil soup', 'Dinner': 'Shrimp stir-fry with quinoa'},
    'Friday': {'Breakfast': 'Greek yogurt parfait', 'Lunch': 'Veggie wrap', 'Dinner': 'Grilled salmon with asparagus'},
    'Saturday': {'Breakfast': 'Avocado toast', 'Lunch': 'Cobb salad', 'Dinner': 'Roasted pork with sweet potatoes'},
    'Sunday': {'Breakfast': 'Whole grain pancakes', 'Lunch': 'Chicken Caesar salad', 'Dinner': 'Vegetable lasagna'},
  };

  final Map<String, Map<String, String>> _overweightMealPlan = {
    'Monday': {'Breakfast': 'Veggie omelet', 'Lunch': 'Tuna salad', 'Dinner': 'Grilled fish with steamed broccoli'},
    'Tuesday': {'Breakfast': 'Green smoothie', 'Lunch': 'Turkey and veggie wrap', 'Dinner': 'Baked chicken with asparagus'},
    'Wednesday': {'Breakfast': 'Fruit and nut parfait', 'Lunch': 'Lentil and veggie salad', 'Dinner': 'Zucchini noodles with marinara'},
    'Thursday': {'Breakfast': 'Scrambled eggs and spinach', 'Lunch': 'Chickpea wrap', 'Dinner': 'Stuffed bell peppers'},
    'Friday': {'Breakfast': 'Oatmeal with berries', 'Lunch': 'Quinoa and kale salad', 'Dinner': 'Grilled shrimp with sautéed veggies'},
    'Saturday': {'Breakfast': 'Low-fat yogurt', 'Lunch': 'Chicken and avocado salad', 'Dinner': 'Turkey meatballs with spaghetti squash'},
    'Sunday': {'Breakfast': 'Chia seed pudding', 'Lunch': 'Veggie wrap', 'Dinner': 'Vegetable stir-fry with tofu'},
  };

  final Map<String, Map<String, String>> _obesityMealPlan = {
    'Monday': {'Breakfast': 'Fruit smoothie', 'Lunch': 'Kale and bean salad', 'Dinner': 'Lentil soup'},
    'Tuesday': {'Breakfast': 'Greek yogurt', 'Lunch': 'Salmon and veggie salad', 'Dinner': 'Grilled chicken with mixed greens'},
    'Wednesday': {'Breakfast': 'Chia pudding', 'Lunch': 'Zucchini noodles with pesto', 'Dinner': 'Vegetable soup'},
    'Thursday': {'Breakfast': 'Green juice', 'Lunch': 'Vegetable stir-fry', 'Dinner': 'Roasted vegetables with tofu'},
    'Friday': {'Breakfast': 'Berry parfait', 'Lunch': 'Spinach salad with beans', 'Dinner': 'Baked fish with asparagus'},
    'Saturday': {'Breakfast': 'Avocado and egg', 'Lunch': 'Quinoa and kale salad', 'Dinner': 'Stuffed bell peppers'},
    'Sunday': {'Breakfast': 'Smoothie with protein powder', 'Lunch': 'Cauliflower rice stir-fry', 'Dinner': 'Vegetable curry'},
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meal Planner"),
        backgroundColor: Colors.red[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // BMI Input Field
            TextField(
              controller: _bmiController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter your BMI',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final bmi = double.tryParse(_bmiController.text);
                if (bmi != null) {
                  setState(() {
                    _calculateBMICategory(bmi);
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please enter a valid BMI")),
                  );
                }
              },
              child: const Text("Get Meal Plan"),
            ),
            const SizedBox(height: 20),

            // Display Meal Plan based on BMI
            if (_bmiCategory != null)
              Expanded(
                child: ListView.builder(
                  itemCount: _mealPlan.length,
                  itemBuilder: (context, index) {
                    String day = _mealPlan.keys.elementAt(index);
                    Map<String, String> dayMeals = _mealPlan[day]!;

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      child: ExpansionTile(
                        title: Text(
                          "$day - $_bmiCategory",
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        children: dayMeals.entries.map((meal) {
                          return ListTile(
                            title: Text(
                              meal.key,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(meal.value),
                            leading: Icon(
                              meal.key == 'Breakfast'
                                  ? Icons.breakfast_dining
                                  : meal.key == 'Lunch'
                                      ? Icons.lunch_dining
                                      : Icons.dinner_dining,
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
