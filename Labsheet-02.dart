1. Hello Flutter

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Hello Flutter')),
        body: const Center(
          child: Text('Hello Flutter', style: TextStyle(fontSize: 30)),
        ),
      ),
    );
  }
}
2. Name, Course, Semester and College

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Student Details')),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Name: Ritiksha Chauhan', style: TextStyle(fontSize: 20)),
              Text('Course: BCA', style: TextStyle(fontSize: 20)),
              Text('Semester: 4th', style: TextStyle(fontSize: 20)),
              Text(
                'College: COER University',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
3. Different Text Styles

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Text Styles')),
        body: const Column(
          children: [
            Text(
              'Bold Text',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Text(
              'Italic Text',
              style: TextStyle(fontSize: 22, fontStyle: FontStyle.italic),
            ),
            Text(
              'Large Text',
              style: TextStyle(fontSize: 35),
            ),
            Text(
              'Small Text',
              style: TextStyle(fontSize: 15),
            ),
            Text(
              'Centered Text',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
4. Display an Image

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Image Widget')),
        body: Center(
          child: Image.network(
            'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
            width: 250,
          ),
        ),
      ),
    );
  }
}
5. Different Icons

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Icons')),
        body: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.home, size: 50),
            Icon(Icons.favorite, size: 50),
            Icon(Icons.star, size: 50),
            Icon(Icons.settings, size: 50),
          ],
        ),
      ),
    );
  }
}
6. Text, Image and Icon

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Text Image Icon')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Flutter Application',
                style: TextStyle(fontSize: 25),
              ),
              const SizedBox(height: 20),
              Image.network(
                'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                width: 150,
              ),
              const SizedBox(height: 20),
              const Icon(Icons.flutter_dash, size: 50),
            ],
          ),
        ),
      ),
    );
  }
}
7. Container Widget

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Container')),
        body: Center(
          child: Container(
            height: 200,
            width: 300,
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              border: Border.all(width: 2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Center(
              child: Text(
                'Flutter Container',
                style: TextStyle(fontSize: 25),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
8. Row Widget

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Row Widget')),
        body: const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Home', style: TextStyle(fontSize: 20)),
              Text('About', style: TextStyle(fontSize: 20)),
              Text('Contact', style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }
}
9. Column Widget

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Column Widget')),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Name', style: TextStyle(fontSize: 22)),
              Text('Course', style: TextStyle(fontSize: 22)),
              Text('Semester', style: TextStyle(fontSize: 22)),
            ],
          ),
        ),
      ),
    );
  }
}
10. Submit, Reset and Cancel Buttons

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Buttons')),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text('Submit'),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Reset'),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Cancel'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
11. Student Profile Card

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Student Profile')),
        body: Center(
          child: Container(
            width: 300,
            padding: const EdgeInsets.all(20),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.network(
                      'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                      width: 100,
                      height: 100,
                    ),
                    const Text(
                      'Ritiksha Chauhan',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text('BCA Student'),
                    const Text('COER University'),
                    const Icon(Icons.school, size: 30),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
12. Business Card

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Business Card')),
        body: Center(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.network(
                    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                    width: 120,
                    height: 120,
                  ),
                  const Text(
                    'Ritiksha Chauhan',
                    style: TextStyle(fontSize: 24),
                  ),
                  const Text('Phone: 9876543210'),
                  const Text('Email: ritiksha@example.com'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
13. Login Screen

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Login')),
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              Image.network(
                'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                width: 100,
                height: 100,
              ),
              const Text(
                'Login',
                style: TextStyle(fontSize: 30),
              ),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
14. Registration Screen

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Registration')),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text(
                'Registration Form',
                style: TextStyle(fontSize: 28),
              ),
              const SizedBox(height: 20),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
15. College Home Screen

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('College Home')),
        body: Column(
          children: [
            const SizedBox(height: 20),
            const Icon(Icons.school, size: 100),
            const Text(
              'COER University',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Courses'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Students'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.contact_page),
              title: const Text('Contact'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
16. Multiple Products using Container and Card

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Products')),
        body: ListView(
          children: [
            Card(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: const ListTile(
                  leading: Icon(Icons.phone_android, size: 40),
                  title: Text('Smartphone'),
                  subtitle: Text('Price: ₹20,000'),
                ),
              ),
            ),
            Card(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: const ListTile(
                  leading: Icon(Icons.laptop, size: 40),
                  title: Text('Laptop'),
                  subtitle: Text('Price: ₹50,000'),
                ),
              ),
            ),
            Card(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: const ListTile(
                  leading: Icon(Icons.headphones, size: 40),
                  title: Text('Headphones'),
                  subtitle: Text('Price: ₹2,000'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
17. Student Information using Card

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Student Information')),
        body: Center(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    'Student Information',
                    style: TextStyle(fontSize: 25),
                  ),
                  SizedBox(height: 15),
                  Text('Name: Ritiksha Chauhan'),
                  Text('Roll Number: 101'),
                  Text('Course: BCA'),
                  Text('Semester: 4th'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
18. Padding and Margin

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Padding and Margin')),
        body: Container(
          margin: const EdgeInsets.all(30),
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            border: Border.all(width: 2),
          ),
          child: const Text(
            'This Text has Padding and the Container has Margin.',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
19. Center and Align

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Alignment')),
        body: Column(
          children: [
            const SizedBox(height: 30),
            const Center(
              child: Text(
                'Centered Text',
                style: TextStyle(fontSize: 25),
              ),
            ),
            const SizedBox(height: 50),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.all(15),
                child: const Text('Left Aligned'),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.all(15),
                child: const Text('Right Aligned'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
20. Food Menu

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Food Menu')),
        body: ListView(
          children: [
            Card(
              child: ListTile(
                leading: const Icon(Icons.local_pizza, size: 40),
                title: const Text('Pizza'),
                subtitle: const Text('₹250'),
                trailing: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Order'),
                ),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.lunch_dining, size: 40),
                title: const Text('Burger'),
                subtitle: const Text('₹150'),
                trailing: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Order'),
                ),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.icecream, size: 40),
                title: const Text('Ice Cream'),
                subtitle: const Text('₹100'),
                trailing: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Order'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
21. Simple Calculator Interface

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Calculator')),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Number',
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed: () {}, child: const Text('7')),
                  ElevatedButton(onPressed: () {}, child: const Text('8')),
                  ElevatedButton(onPressed: () {}, child: const Text('9')),
                  ElevatedButton(onPressed: () {}, child: const Text('/')),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed: () {}, child: const Text('4')),
                  ElevatedButton(onPressed: () {}, child: const Text('5')),
                  ElevatedButton(onPressed: () {}, child: const Text('6')),
                  ElevatedButton(onPressed: () {}, child: const Text('*')),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed: () {}, child: const Text('1')),
                  ElevatedButton(onPressed: () {}, child: const Text('2')),
                  ElevatedButton(onPressed: () {}, child: const Text('3')),
                  ElevatedButton(onPressed: () {}, child: const Text('-')),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed: () {}, child: const Text('0')),
                  ElevatedButton(onPressed: () {}, child: const Text('C')),
                  ElevatedButton(onPressed: () {}, child: const Text('=')),
                  ElevatedButton(onPressed: () {}, child: const Text('+')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
22. Weather Information Screen

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Weather')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.location_on, size: 50),
              Text(
                'Haridwar',
                style: TextStyle(fontSize: 30),
              ),
              Icon(Icons.wb_sunny, size: 100),
              Text(
                '30°C',
                style: TextStyle(fontSize: 45),
              ),
              Text('Sunny'),
              SizedBox(height: 20),
              Text('Humidity: 60%'),
              Text('Wind Speed: 12 km/h'),
            ],
          ),
        ),
      ),
    );
  }
}
23. Shopping Product Screen

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Shopping Product')),
        body: Center(
          child: Card(
            margin: const EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.network(
                    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                    width: 180,
                    height: 180,
                  ),
                  const Text(
                    'Smart Product',
                    style: TextStyle(fontSize: 25),
                  ),
                  const Text(
                    '₹2,999',
                    style: TextStyle(fontSize: 20),
                  ),
                  const Icon(Icons.star, size: 30),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Add to Cart'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
24. Student Dashboard

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Student Dashboard')),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 45,
                child: Icon(Icons.person, size: 50),
              ),
              const SizedBox(height: 10),
              const Text(
                'Ritiksha Chauhan',
                style: TextStyle(fontSize: 24),
              ),
              const Text('BCA Student'),
              const SizedBox(height: 25),
              Row(
                children: [
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: const [
                            Icon(Icons.book, size: 40),
                            Text('Courses'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: const [
                            Icon(Icons.assignment, size: 40),
                            Text('Assignments'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: const [
                            Icon(Icons.grade, size: 40),
                            Text('Results'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: const [
                            Icon(Icons.schedule, size: 40),
                            Text('Timetable'),
                          ],
                        ),
                      ),
                    ),
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
25. Personal Profile/Home Screen

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('My Profile'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Image
              const CircleAvatar(
                radius: 60,
                child: Icon(
                  Icons.person,
                  size: 70,
                ),
              ),

              const SizedBox(height: 15),

              // Text
              const Text(
                'Ritiksha Chauhan',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const Text(
                'BCA Student',
                style: TextStyle(fontSize: 18),
              ),

              const SizedBox(height: 20),

              // Container
              Container(
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'I am a BCA student interested in programming '
                  'and modern technologies.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17),
                ),
              ),

              // Row with Icons
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.email, size: 35),
                  Icon(Icons.phone, size: 35),
                  Icon(Icons.location_on, size: 35),
                ],
              ),

              const SizedBox(height: 20),

              // Cards
              Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  leading: const Icon(Icons.school),
                  title: const Text('Education'),
                  subtitle: const Text('BCA - COER University'),
                ),
              ),

              Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  leading: const Icon(Icons.code),
                  title: const Text('Skills'),
                  subtitle: const Text('C, C++, Python, Flutter'),
                ),
              ),

              const SizedBox(height: 10),

              // Button
              ElevatedButton(
                onPressed: () {},
                child: const Text('Contact Me'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
