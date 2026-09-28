1. Display five items using ListView

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Five Items"),
        ),
        body: ListView(
          children: [
            ListTile(title: Text("Apple")),
            ListTile(title: Text("Banana")),
            ListTile(title: Text("Mango")),
            ListTile(title: Text("Orange")),
            ListTile(title: Text("Grapes")),
          ],
        ),
      ),
    );
  }
}
2. ListTile with leading icon, title and subtitle

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("ListTile Example"),
        ),
        body: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Riya"),
              subtitle: Text("BCA Student"),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Aman"),
              subtitle: Text("B.Tech Student"),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Priya"),
              subtitle: Text("BBA Student"),
            ),
          ],
        ),
      ),
    );
  }
}
3. Display numbers 1 to 100 using ListView.builder

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Numbers 1 to 100"),
        ),
        body: ListView.builder(
          itemCount: 100,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text("Number ${index + 1}"),
            );
          },
        ),
      ),
    );
  }
}
4. List of names using ListView.builder

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<String> names = [
    "Riya",
    "Aman",
    "Rahul",
    "Priya",
    "Neha",
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Student Names"),
        ),
        body: ListView.builder(
          itemCount: names.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(Icons.person),
              title: Text(names[index]),
            );
          },
        ),
      ),
    );
  }
}
5. List with dividers using ListView.separated

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<String> items = [
    "Apple",
    "Banana",
    "Mango",
    "Orange",
    "Grapes",
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Separated List"),
        ),
        body: ListView.separated(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(items[index]),
            );
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
        ),
      ),
    );
  }
}
6. Horizontally scrolling list

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<String> items = [
    "Apple",
    "Banana",
    "Mango",
    "Orange",
    "Grapes",
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Horizontal List"),
        ),
        body: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Container(
              width: 120,
              margin: EdgeInsets.all(10),
              color: Colors.blue,
              child: Center(
                child: Text(
                  items[index],
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
7. Grid of icons using GridView.count

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<IconData> icons = [
    Icons.home,
    Icons.person,
    Icons.settings,
    Icons.favorite,
    Icons.star,
    Icons.phone,
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Icon Grid"),
        ),
        body: GridView.count(
          crossAxisCount: 2,
          children: icons.map((icon) {
            return Card(
              child: Icon(
                icon,
                size: 50,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
8. Grid of colored boxes using GridView.builder

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.yellow,
    Colors.pink,
    Colors.teal,
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Colored Grid"),
        ),
        body: GridView.builder(
          itemCount: colors.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.all(10),
              color: colors[index],
            );
          },
        ),
      ),
    );
  }
}
9. Product List using Model Class and ListView.builder

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Product {
  String name;
  double price;

  Product(this.name, this.price);
}

class MyApp extends StatelessWidget {
  final List<Product> products = [
    Product("Laptop", 50000),
    Product("Mobile", 20000),
    Product("Headphones", 2000),
    Product("Keyboard", 1500),
    Product("Mouse", 800),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Product List"),
        ),
        body: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(Icons.shopping_bag),
              title: Text(products[index].name),
              subtitle: Text("Price: ₹${products[index].price}"),
            );
          },
        ),
      ),
    );
  }
}
10. Difference between StatelessWidget and StatefulWidget

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ExampleScreen(),
    );
  }
}

class ExampleScreen extends StatefulWidget {
  @override
  State<ExampleScreen> createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stateless and Stateful"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "This text is inside a StatefulWidget",
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 20),
          Text(
            "Count: $count",
            style: TextStyle(fontSize: 25),
          ),
          ElevatedButton(
            child: Text("Change"),
            onPressed: () {
              setState(() {
                count++;
              });
            },
          ),
        ],
      ),
    );
  }
}

Difference: StatelessWidget does not change its state, while StatefulWidget can change its state using setState().

11. Counter using setState()

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CounterScreen(),
    );
  }
}

class CounterScreen extends StatefulWidget {
  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Counter"),
      ),
      body: Center(
        child: Text(
          "Count: $count",
          style: TextStyle(fontSize: 30),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            count++;
          });
        },
      ),
    );
  }
}
12. Increment, Decrement and Reset Counter

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CounterScreen(),
    );
  }
}

class CounterScreen extends StatefulWidget {
  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Counter App"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$count",
            style: TextStyle(fontSize: 40),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            child: Text("Increment"),
            onPressed: () {
              setState(() {
                count++;
              });
            },
          ),
          ElevatedButton(
            child: Text("Decrement"),
            onPressed: () {
              setState(() {
                count--;
              });
            },
          ),
          ElevatedButton(
            child: Text("Reset"),
            onPressed: () {
              setState(() {
                count = 0;
              });
            },
          ),
        ],
      ),
    );
  }
}
13. Add new item to a list

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController controller = TextEditingController();

  List<String> items = [
    "Apple",
    "Banana",
    "Mango",
  ];

  void addItem() {
    if (controller.text.isNotEmpty) {
      setState(() {
        items.add(controller.text);
        controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Add Items"),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: "Enter item",
                ),
              ),
            ),
            ElevatedButton(
              child: Text("Add"),
              onPressed: addItem,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(items[index]),
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
14. Delete item using delete icon

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> items = [
    "Apple",
    "Banana",
    "Mango",
    "Orange",
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Delete Items"),
        ),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(items[index]),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    items.removeAt(index);
                  });
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
15. Remove items using Dismissible

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> items = [
    "Apple",
    "Banana",
    "Mango",
    "Orange",
    "Grapes",
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Swipe to Delete"),
        ),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: Key(items[index]),
              onDismissed: (direction) {
                setState(() {
                  items.removeAt(index);
                });
              },
              background: Container(
                color: Colors.red,
              ),
              child: ListTile(
                title: Text(items[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}
16. Filter names using Search TextField

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> names = [
    "Riya",
    "Rahul",
    "Aman",
    "Priya",
    "Neha",
    "Rohan",
  ];

  List<String> filteredNames = [];

  @override
  void initState() {
    super.initState();
    filteredNames = names;
  }

  void searchName(String value) {
    setState(() {
      filteredNames = names
          .where((name) =>
              name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Search Names"),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                onChanged: searchName,
                decoration: InputDecoration(
                  labelText: "Search Name",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredNames.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.person),
                    title: Text(filteredNames[index]),
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
17. Student Record List Application

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Student {
  String name;
  String rollNumber;
  String course;

  Student(this.name, this.rollNumber, this.course);
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController rollController = TextEditingController();
  TextEditingController courseController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  List<Student> students = [];

  List<Student> filteredStudents = [];

  @override
  void initState() {
    super.initState();
    filteredStudents = students;
  }

  void addStudent() {
    if (nameController.text.isNotEmpty &&
        rollController.text.isNotEmpty &&
        courseController.text.isNotEmpty) {
      setState(() {
        students.add(
          Student(
            nameController.text,
            rollController.text,
            courseController.text,
          ),
        );

        filteredStudents = students;

        nameController.clear();
        rollController.clear();
        courseController.clear();
      });
    }
  }

  void searchStudent(String value) {
    setState(() {
      filteredStudents = students
          .where((student) =>
              student.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  void deleteStudent(int index) {
    setState(() {
      Student student = filteredStudents[index];
      students.remove(student);
      filteredStudents.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Student Management"),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Student Name",
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: rollController,
                decoration: InputDecoration(
                  labelText: "Roll Number",
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: courseController,
                decoration: InputDecoration(
                  labelText: "Course",
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            ElevatedButton(
              child: Text("Add Student"),
              onPressed: addStudent,
            ),

            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: searchController,
                onChanged: searchStudent,
                decoration: InputDecoration(
                  labelText: "Search by Name",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: filteredStudents.length,
                itemBuilder: (context, index) {
                  Student student = filteredStudents[index];

                  return ListTile(
                    leading: Icon(Icons.person),
                    title: Text(student.name),
                    subtitle: Text(
                      "Roll No: ${student.rollNumber}\n"
                      "Course: ${student.course}",
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        deleteStudent(index);
                      },
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