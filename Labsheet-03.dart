1. Accept Student Name and Display It

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const StudentNamePage(),
    );
  }
}

class StudentNamePage extends StatefulWidget {
  const StudentNamePage({super.key});

  @override
  State<StudentNamePage> createState() => _StudentNamePageState();
}

class _StudentNamePageState extends State<StudentNamePage> {
  final nameController = TextEditingController();
  String name = '';

  void displayName() {
    setState(() {
      name = nameController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Name'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Enter Student Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: displayName,
              child: const Text('Display'),
            ),
            const SizedBox(height: 20),
            Text(
              'Name: $name',
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
2. Sum of Two Numbers

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SumPage(),
    );
  }
}

class SumPage extends StatefulWidget {
  const SumPage({super.key});

  @override
  State<SumPage> createState() => _SumPageState();
}

class _SumPageState extends State<SumPage> {
  final num1Controller = TextEditingController();
  final num2Controller = TextEditingController();

  double sum = 0;

  void calculateSum() {
    double num1 = double.tryParse(num1Controller.text) ?? 0;
    double num2 = double.tryParse(num2Controller.text) ?? 0;

    setState(() {
      sum = num1 + num2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sum of Two Numbers'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: num1Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'First Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: num2Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Second Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateSum,
              child: const Text('Calculate Sum'),
            ),
            const SizedBox(height: 20),
            Text(
              'Sum = $sum',
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
3. Addition, Subtraction, Multiplication and Division

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final num1Controller = TextEditingController();
  final num2Controller = TextEditingController();

  String result = '';

  void calculate(String operation) {
    double num1 = double.tryParse(num1Controller.text) ?? 0;
    double num2 = double.tryParse(num2Controller.text) ?? 0;

    double answer = 0;

    if (operation == '+') {
      answer = num1 + num2;
    } else if (operation == '-') {
      answer = num1 - num2;
    } else if (operation == '*') {
      answer = num1 * num2;
    } else if (operation == '/') {
      if (num2 == 0) {
        setState(() {
          result = 'Cannot divide by zero';
        });
        return;
      }
      answer = num1 / num2;
    }

    setState(() {
      result = 'Result = $answer';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: num1Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'First Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: num2Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Second Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => calculate('+'),
                  child: const Text('+'),
                ),
                ElevatedButton(
                  onPressed: () => calculate('-'),
                  child: const Text('-'),
                ),
                ElevatedButton(
                  onPressed: () => calculate('*'),
                  child: const Text('*'),
                ),
                ElevatedButton(
                  onPressed: () => calculate('/'),
                  child: const Text('/'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              result,
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
4. Button Changes Displayed Text

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String message = 'Hello Flutter!';

  void changeText() {
    setState(() {
      message = 'Text Changed!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Change Text'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                message,
                style: const TextStyle(fontSize: 25),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: changeText,
                child: const Text('Change Text'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
5. ElevatedButton with SnackBar

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('SnackBar Example'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Button was pressed!'),
                ),
              );
            },
            child: const Text('Show Message'),
          ),
        ),
      ),
    );
  }
}
6. Submit and Reset Buttons

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const FormPage(),
    );
  }
}

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final nameController = TextEditingController();
  String message = '';

  void submit() {
    setState(() {
      message = 'Form Submitted';
    });
  }

  void reset() {
    nameController.clear();

    setState(() {
      message = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Enter Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: submit,
                  child: const Text('Submit'),
                ),
                const SizedBox(width: 15),
                ElevatedButton(
                  onPressed: reset,
                  child: const Text('Reset'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              message,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
7. Student Name and Total Marks

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const StudentPage(),
    );
  }
}

class StudentPage extends StatefulWidget {
  const StudentPage({super.key});

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  final nameController = TextEditingController();
  final marks1Controller = TextEditingController();
  final marks2Controller = TextEditingController();
  final marks3Controller = TextEditingController();

  int total = 0;
  String name = '';

  void calculateTotal() {
    int marks1 = int.tryParse(marks1Controller.text) ?? 0;
    int marks2 = int.tryParse(marks2Controller.text) ?? 0;
    int marks3 = int.tryParse(marks3Controller.text) ?? 0;

    setState(() {
      name = nameController.text;
      total = marks1 + marks2 + marks3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Marks'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Student Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: marks1Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Subject 1 Marks',
              ),
            ),
            TextField(
              controller: marks2Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Subject 2 Marks',
              ),
            ),
            TextField(
              controller: marks3Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Subject 3 Marks',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateTotal,
              child: const Text('Calculate Total'),
            ),
            const SizedBox(height: 20),
            Text('Student: $name'),
            Text(
              'Total Marks = $total',
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
8. Percentage from Three Marks

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const PercentagePage(),
    );
  }
}

class PercentagePage extends StatefulWidget {
  const PercentagePage({super.key});

  @override
  State<PercentagePage> createState() => _PercentagePageState();
}

class _PercentagePageState extends State<PercentagePage> {
  final marks1Controller = TextEditingController();
  final marks2Controller = TextEditingController();
  final marks3Controller = TextEditingController();

  double percentage = 0;

  void calculatePercentage() {
    double marks1 = double.tryParse(marks1Controller.text) ?? 0;
    double marks2 = double.tryParse(marks2Controller.text) ?? 0;
    double marks3 = double.tryParse(marks3Controller.text) ?? 0;

    setState(() {
      percentage = (marks1 + marks2 + marks3) / 3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Percentage Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: marks1Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Subject 1 Marks',
              ),
            ),
            TextField(
              controller: marks2Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Subject 2 Marks',
              ),
            ),
            TextField(
              controller: marks3Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Subject 3 Marks',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculatePercentage,
              child: const Text('Calculate Percentage'),
            ),
            const SizedBox(height: 20),
            Text(
              'Percentage = ${percentage.toStringAsFixed(2)}%',
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
9. Even or Odd

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const EvenOddPage(),
    );
  }
}

class EvenOddPage extends StatefulWidget {
  const EvenOddPage({super.key});

  @override
  State<EvenOddPage> createState() => _EvenOddPageState();
}

class _EvenOddPageState extends State<EvenOddPage> {
  final controller = TextEditingController();
  String result = '';

  void checkNumber() {
    int? number = int.tryParse(controller.text);

    if (number == null) {
      setState(() {
        result = 'Enter a valid number';
      });
    } else if (number % 2 == 0) {
      setState(() {
        result = 'Even Number';
      });
    } else {
      setState(() {
        result = 'Odd Number';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Even or Odd'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: checkNumber,
              child: const Text('Check'),
            ),
            const SizedBox(height: 20),
            Text(
              result,
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
10. Positive, Negative or Zero

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const NumberPage(),
    );
  }
}

class NumberPage extends StatefulWidget {
  const NumberPage({super.key});

  @override
  State<NumberPage> createState() => _NumberPageState();
}

class _NumberPageState extends State<NumberPage> {
  final controller = TextEditingController();
  String result = '';

  void checkNumber() {
    double? number = double.tryParse(controller.text);

    if (number == null) {
      setState(() {
        result = 'Enter a valid number';
      });
    } else if (number > 0) {
      setState(() {
        result = 'Positive Number';
      });
    } else if (number < 0) {
      setState(() {
        result = 'Negative Number';
      });
    } else {
      setState(() {
        result = 'Zero';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Check'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: checkNumber,
              child: const Text('Check'),
            ),
            const SizedBox(height: 20),
            Text(
              result,
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
11. Celsius to Fahrenheit

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const TemperaturePage(),
    );
  }
}

class TemperaturePage extends StatefulWidget {
  const TemperaturePage({super.key});

  @override
  State<TemperaturePage> createState() => _TemperaturePageState();
}

class _TemperaturePageState extends State<TemperaturePage> {
  final controller = TextEditingController();
  double fahrenheit = 0;

  void convertTemperature() {
    double celsius = double.tryParse(controller.text) ?? 0;

    setState(() {
      fahrenheit = (celsius * 9 / 5) + 32;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temperature Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Celsius',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: convertTemperature,
              child: const Text('Convert'),
            ),
            const SizedBox(height: 20),
            Text(
              'Fahrenheit = ${fahrenheit.toStringAsFixed(2)} °F',
              style: const TextStyle(fontSize: 22),
            ),
          ],
        ),
      ),
    );
  }
}
12. Area of Rectangle

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const RectanglePage(),
    );
  }
}

class RectanglePage extends StatefulWidget {
  const RectanglePage({super.key});

  @override
  State<RectanglePage> createState() => _RectanglePageState();
}

class _RectanglePageState extends State<RectanglePage> {
  final lengthController = TextEditingController();
  final widthController = TextEditingController();

  double area = 0;

  void calculateArea() {
    double length = double.tryParse(lengthController.text) ?? 0;
    double width = double.tryParse(widthController.text) ?? 0;

    setState(() {
      area = length * width;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Area of Rectangle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: lengthController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Length',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: widthController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Width',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateArea,
              child: const Text('Calculate Area'),
            ),
            const SizedBox(height: 20),
            Text(
              'Area = $area',
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
13. BMI Calculator

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const BMIPage(),
    );
  }
}

class BMIPage extends StatefulWidget {
  const BMIPage({super.key});

  @override
  State<BMIPage> createState() => _BMIPageState();
}

class _BMIPageState extends State<BMIPage> {
  final heightController = TextEditingController();
  final weightController = TextEditingController();

  double bmi = 0;

  void calculateBMI() {
    double heightCm = double.tryParse(heightController.text) ?? 0;
    double weight = double.tryParse(weightController.text) ?? 0;

    if (heightCm > 0 && weight > 0) {
      double heightMeter = heightCm / 100;

      setState(() {
        bmi = weight / (heightMeter * heightMeter);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Height in cm',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Weight in kg',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateBMI,
              child: const Text('Calculate BMI'),
            ),
            const SizedBox(height: 20),
            Text(
              'BMI = ${bmi.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
14. Checkbox for Terms and Conditions

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool agreed = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Terms and Conditions'),
        ),
        body: Center(
          child: CheckboxListTile(
            title: const Text(
              'I agree to the Terms and Conditions',
            ),
            value: agreed,
            onChanged: (value) {
              setState(() {
                agreed = value ?? false;
              });
            },
          ),
        ),
      ),
    );
  }
}
15. Radio Buttons for Gender

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String gender = 'Male';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Select Gender'),
        ),
        body: Column(
          children: [
            RadioListTile<String>(
              title: const Text('Male'),
              value: 'Male',
              groupValue: gender,
              onChanged: (value) {
                setState(() {
                  gender = value!;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Female'),
              value: 'Female',
              groupValue: gender,
              onChanged: (value) {
                setState(() {
                  gender = value!;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Other'),
              value: 'Other',
              groupValue: gender,
              onChanged: (value) {
                setState(() {
                  gender = value!;
                });
              },
            ),
            Text(
              'Selected Gender: $gender',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
16. Radio Buttons for Course

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String course = 'BCA';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Select Course'),
        ),
        body: Column(
          children: [
            RadioListTile<String>(
              title: const Text('BCA'),
              value: 'BCA',
              groupValue: course,
              onChanged: (value) {
                setState(() {
                  course = value!;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('BBA'),
              value: 'BBA',
              groupValue: course,
              onChanged: (value) {
                setState(() {
                  course = value!;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('B.Tech'),
              value: 'B.Tech',
              groupValue: course,
              onChanged: (value) {
                setState(() {
                  course = value!;
                });
              },
            ),
            Text(
              'Selected Course: $course',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
17. DropdownButton for Semester
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String semester = 'Semester 1';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Select Semester'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: DropdownButton<String>(
            value: semester,
            isExpanded: true,
            items: [
              'Semester 1',
              'Semester 2',
              'Semester 3',
              'Semester 4',
              'Semester 5',
              'Semester 6',
            ].map((item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                semester = value!;
              });
            },
          ),
        ),
      ),
    );
  }
}
18. DropdownButton for Department

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String department = 'Computer Science';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Select Department'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: DropdownButton<String>(
            value: department,
            isExpanded: true,
            items: [
              'Computer Science',
              'Management',
              'Electronics',
            ].map((item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                department = value!;
              });
            },
          ),
        ),
      ),
    );
  }
}
19. Switch ON and OFF

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isOn = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Switch Example'),
        ),
        body: Center(
          child: SwitchListTile(
            title: Text(
              isOn ? 'Setting is ON' : 'Setting is OFF',
            ),
            value: isOn,
            onChanged: (value) {
              setState(() {
                isOn = value;
              });
            },
          ),
        ),
      ),
    );
  }
}
20. Checkbox + Radio + Dropdown + Switch

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool agreed = false;
  String gender = 'Male';
  String course = 'BCA';
  bool notifications = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Widgets'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            CheckboxListTile(
              title: const Text('I Agree to Terms'),
              value: agreed,
              onChanged: (value) {
                setState(() {
                  agreed = value ?? false;
                });
              },
            ),

            const Divider(),

            const Text(
              'Gender',
              style: TextStyle(fontSize: 18),
            ),

            RadioListTile<String>(
              title: const Text('Male'),
              value: 'Male',
              groupValue: gender,
              onChanged: (value) {
                setState(() {
                  gender = value!;
                });
              },
            ),

            RadioListTile<String>(
              title: const Text('Female'),
              value: 'Female',
              groupValue: gender,
              onChanged: (value) {
                setState(() {
                  gender = value!;
                });
              },
            ),

            const Divider(),

            const Text(
              'Course',
              style: TextStyle(fontSize: 18),
            ),

            DropdownButton<String>(
              value: course,
              isExpanded: true,
              items: ['BCA', 'BBA', 'B.Tech'].map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  course = value!;
                });
              },
            ),

            const Divider(),

            SwitchListTile(
              title: const Text('Notifications'),
              value: notifications,
              onChanged: (value) {
                setState(() {
                  notifications = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
21. Login Form UI

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void login() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Login button pressed'),
      ),
    );
  }

  void reset() {
    usernameController.clear();
    passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: login,
                  child: const Text('Login'),
                ),
                const SizedBox(width: 15),
                ElevatedButton(
                  onPressed: reset,
                  child: const Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
22. Registration Form UI

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const RegistrationPage(),
    );
  }
}

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String gender = 'Male';
  String course = 'BCA';

  void register() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Registration Successful'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration Form'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 15),

          const Text(
            'Gender',
            style: TextStyle(fontSize: 18),
          ),

          RadioListTile<String>(
            title: const Text('Male'),
            value: 'Male',
            groupValue: gender,
            onChanged: (value) {
              setState(() {
                gender = value!;
              });
            },
          ),

          RadioListTile<String>(
            title: const Text('Female'),
            value: 'Female',
            groupValue: gender,
            onChanged: (value) {
              setState(() {
                gender = value!;
              });
            },
          ),

          const SizedBox(height: 10),

          const Text(
            'Course',
            style: TextStyle(fontSize: 18),
          ),

          DropdownButton<String>(
            value: course,
            isExpanded: true,
            items: ['BCA', 'BBA', 'B.Tech'].map((item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                course = value!;
              });
            },
          ),

          const SizedBox(height: 15),

          ElevatedButton(
            onPressed: register,
            child: const Text('Register'),
          ),
        ],
      ),
    );
  }
}
23. Student Feedback Form

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const FeedbackPage(),
    );
  }
}

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final nameController = TextEditingController();
  final feedbackController = TextEditingController();

  int rating = 3;

  void submitFeedback() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Feedback Submitted'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Feedback'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 15),

          const Text(
            'Rating',
            style: TextStyle(fontSize: 18),
          ),

          RadioListTile<int>(
            title: const Text('1 - Poor'),
            value: 1,
            groupValue: rating,
            onChanged: (value) {
              setState(() {
                rating = value!;
              });
            },
          ),

          RadioListTile<int>(
            title: const Text('2 - Average'),
            value: 2,
            groupValue: rating,
            onChanged: (value) {
              setState(() {
                rating = value!;
              });
            },
          ),

          RadioListTile<int>(
            title: const Text('3 - Good'),
            value: 3,
            groupValue: rating,
            onChanged: (value) {
              setState(() {
                rating = value!;
              });
            },
          ),

          RadioListTile<int>(
            title: const Text('4 - Very Good'),
            value: 4,
            groupValue: rating,
            onChanged: (value) {
              setState(() {
                rating = value!;
              });
            },
          ),

          RadioListTile<int>(
            title: const Text('5 - Excellent'),
            value: 5,
            groupValue: rating,
            onChanged: (value) {
              setState(() {
                rating = value!;
              });
            },
          ),

          const SizedBox(height: 10),

          TextField(
            controller: feedbackController,
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: 'Feedback',
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: submitFeedback,
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
24. Simple Calculator

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({super.key});

  @override
  State<SimpleCalculator> createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  final firstController = TextEditingController();
  final secondController = TextEditingController();

  String result = '';

  void calculate(String operator) {
    double a = double.tryParse(firstController.text) ?? 0;
    double b = double.tryParse(secondController.text) ?? 0;

    double answer = 0;

    if (operator == '+') {
      answer = a + b;
    } else if (operator == '-') {
      answer = a - b;
    } else if (operator == '*') {
      answer = a * b;
    } else if (operator == '/') {
      if (b == 0) {
        setState(() {
          result = 'Cannot divide by zero';
        });
        return;
      }
      answer = a / b;
    }

    setState(() {
      result = 'Result = $answer';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: firstController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'First Number',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: secondController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Second Number',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            Wrap(
              spacing: 10,
              children: [
                ElevatedButton(
                  onPressed: () => calculate('+'),
                  child: const Text('+'),
                ),
                ElevatedButton(
                  onPressed: () => calculate('-'),
                  child: const Text('-'),
                ),
                ElevatedButton(
                  onPressed: () => calculate('*'),
                  child: const Text('*'),
                ),
                ElevatedButton(
                  onPressed: () => calculate('/'),
                  child: const Text('/'),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Text(
              result,
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
25. Student Result Application

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const StudentResultPage(),
    );
  }
}

class StudentResultPage extends StatefulWidget {
  const StudentResultPage({super.key});

  @override
  State<StudentResultPage> createState() => _StudentResultPageState();
}

class _StudentResultPageState extends State<StudentResultPage> {
  final nameController = TextEditingController();
  final marks1Controller = TextEditingController();
  final marks2Controller = TextEditingController();
  final marks3Controller = TextEditingController();

  int total = 0;
  double percentage = 0;
  String result = '';

  void calculateResult() {
    int marks1 = int.tryParse(marks1Controller.text) ?? 0;
    int marks2 = int.tryParse(marks2Controller.text) ?? 0;
    int marks3 = int.tryParse(marks3Controller.text) ?? 0;

    int totalMarks = marks1 + marks2 + marks3;
    double percent = totalMarks / 3;

    setState(() {
      total = totalMarks;
      percentage = percent;

      if (marks1 >= 33 && marks2 >= 33 && marks3 >= 33) {
        result = 'Pass';
      } else {
        result = 'Fail';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Result'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Student Name',
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 12),

          TextField(
            controller: marks1Controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Subject 1 Marks',
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 12),

          TextField(
            controller: marks2Controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Subject 2 Marks',
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 12),

          TextField(
            controller: marks3Controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Subject 3 Marks',
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: calculateResult,
            child: const Text('Calculate Result'),
          ),

          const SizedBox(height: 20),

          Text(
            'Student Name: ${nameController.text}',
            style: const TextStyle(fontSize: 18),
          ),

          Text(
            'Total Marks: $total',
            style: const TextStyle(fontSize: 20),
          ),

          Text(
            'Percentage: ${percentage.toStringAsFixed(2)}%',
            style: const TextStyle(fontSize: 20),
          ),

          Text(
            'Result: $result',
            style: const TextStyle(fontSize: 22),
          ),
        ],
      ),
    );
  }
}