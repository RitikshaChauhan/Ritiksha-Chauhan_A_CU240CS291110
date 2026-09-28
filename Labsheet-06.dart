1. Store Student Details in a Map
void main() {
  Map<String, String> student = {
    "Name": "Ritiksha",
    "Roll Number": "101",
    "Course": "BCA",
  };

  student.forEach((key, value) {
    print("$key: $value");
  });
}

2. Student Object to Map and Map to Student Object

class Student {
  String name;
  String rollNumber;
  String course;

  Student(this.name, this.rollNumber, this.course);

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "rollNumber": rollNumber,
      "course": course,
    };
  }

  Student.fromMap(Map<String, dynamic> map)
      : name = map["name"],
        rollNumber = map["rollNumber"],
        course = map["course"];
}

void main() {
  Student student = Student("Ritiksha", "101", "BCA");

  Map<String, dynamic> studentMap = student.toMap();

  print("Student to Map:");
  print(studentMap);

  Student newStudent = Student.fromMap(studentMap);

  print("\nMap to Student:");
  print("Name: ${newStudent.name}");
  print("Roll Number: ${newStudent.rollNumber}");
  print("Course: ${newStudent.course}");
}

3. Map to JSON and JSON to Map

import 'dart:convert';

void main() {
  Map<String, dynamic> student = {
    "name": "Ritiksha",
    "rollNumber": 101,
    "course": "BCA",
  };

  String jsonString = jsonEncode(student);

  print("Map to JSON:");
  print(jsonString);

  Map<String, dynamic> newMap = jsonDecode(jsonString);

  print("\nJSON to Map:");
  print(newMap);
}

4. Save User Name using SharedPreferences

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NameScreen(),
    );
  }
}

class NameScreen extends StatefulWidget {
  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  TextEditingController nameController = TextEditingController();
  String savedName = "";

  @override
  void initState() {
    super.initState();
    loadName();
  }

  Future<void> saveName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString("name", nameController.text);

    setState(() {
      savedName = nameController.text;
    });
  }

  Future<void> loadName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      savedName = prefs.getString("name") ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Save Name"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Enter Name",
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveName,
              child: Text("Save"),
            ),
            SizedBox(height: 20),
            Text(
              "Saved Name: $savedName",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
5. Store and Retrieve Counter using SharedPreferences

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  int counter = 0;

  @override
  void initState() {
    super.initState();
    loadCounter();
  }

  Future<void> loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      counter = prefs.getInt("counter") ?? 0;
    });
  }

  Future<void> increaseCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      counter++;
    });

    await prefs.setInt("counter", counter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Saved Counter"),
      ),
      body: Center(
        child: Text(
          "Counter: $counter",
          style: TextStyle(fontSize: 30),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: increaseCounter,
        child: Icon(Icons.add),
      ),
    );
  }
}
6. Dark Mode using Switch and SharedPreferences

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool darkMode = false;

  @override
  void initState() {
    super.initState();
    loadMode();
  }

  Future<void> loadMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      darkMode = prefs.getBool("darkMode") ?? false;
    });
  }

  Future<void> changeMode(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      darkMode = value;
    });

    await prefs.setBool("darkMode", value);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: darkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Dark Mode"),
        ),
        body: Center(
          child: SwitchListTile(
            title: Text("Dark Mode"),
            value: darkMode,
            onChanged: changeMode,
          ),
        ),
      ),
    );
  }
}
7. Remember Me using SharedPreferences

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();

  bool rememberMe = false;

  @override
  void initState() {
    super.initState();
    loadLogin();
  }

  Future<void> loadLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      rememberMe = prefs.getBool("rememberMe") ?? false;

      if (rememberMe) {
        usernameController.text =
            prefs.getString("username") ?? "";
      }
    });
  }

  Future<void> login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (rememberMe) {
      await prefs.setString(
        "username",
        usernameController.text,
      );
      await prefs.setBool("rememberMe", true);
    } else {
      await prefs.remove("username");
      await prefs.setBool("rememberMe", false);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Login Successful")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: "Username",
              ),
            ),
            CheckboxListTile(
              title: Text("Remember Me"),
              value: rememberMe,
              onChanged: (value) {
                setState(() {
                  rememberMe = value!;
                });
              },
            ),
            ElevatedButton(
              onPressed: login,
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
8. Save Name, Email and Age

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserScreen(),
    );
  }
}

class UserScreen extends StatefulWidget {
  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  String displayData = "";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString("name", nameController.text);
    await prefs.setString("email", emailController.text);
    await prefs.setInt(
      "age",
      int.tryParse(ageController.text) ?? 0,
    );

    loadData();
  }

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String name = prefs.getString("name") ?? "";
    String email = prefs.getString("email") ?? "";
    int age = prefs.getInt("age") ?? 0;

    setState(() {
      displayData =
          "Name: $name\nEmail: $email\nAge: $age";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Information"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: ageController,
              decoration: InputDecoration(labelText: "Age"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveData,
              child: Text("Save"),
            ),
            SizedBox(height: 20),
            Text(
              displayData,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
9. Store List of Strings using SharedPreferences

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> subjects = [
    "Flutter",
    "Dart",
    "Java",
    "Database",
    "Python",
  ];

  List<String> savedSubjects = [];

  @override
  void initState() {
    super.initState();
    loadSubjects();
  }

  Future<void> saveSubjects() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setStringList("subjects", subjects);

    loadSubjects();
  }

  Future<void> loadSubjects() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      savedSubjects =
          prefs.getStringList("subjects") ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favourite Subjects"),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: saveSubjects,
            child: Text("Save Subjects"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: savedSubjects.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(savedSubjects[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
10. Clear SharedPreferences Data

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StorageScreen(),
    );
  }
}

class StorageScreen extends StatefulWidget {
  @override
  State<StorageScreen> createState() => _StorageScreenState();
}

class _StorageScreenState extends State<StorageScreen> {
  String name = "";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString("name", "Ritiksha");

    loadData();
  }

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      name = prefs.getString("name") ?? "No data";
    });
  }

  Future<void> clearData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.clear();

    setState(() {
      name = "No data";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SharedPreferences"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Name: $name",
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveData,
              child: Text("Save Data"),
            ),
            ElevatedButton(
              onPressed: clearData,
              child: Text("Clear Data"),
            ),
          ],
        ),
      ),
    );
  }
}
11. Welcome Screen Only on First Launch

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StartScreen(),
    );
  }
}

class StartScreen extends StatefulWidget {
  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    super.initState();
    checkFirstLaunch();
  }

  Future<void> checkFirstLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool firstLaunch = prefs.getBool("firstLaunch") ?? true;

    if (firstLaunch) {
      await prefs.setBool("firstLaunch", false);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => WelcomeScreen(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Welcome to the App!",
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Home Screen",
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}
12. Write Text into a File using path_provider

main.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FileScreen(),
    );
  }
}

class FileScreen extends StatefulWidget {
  @override
  State<FileScreen> createState() => _FileScreenState();
}

class _FileScreenState extends State<FileScreen> {
  TextEditingController controller = TextEditingController();

  Future<void> saveFile() async {
    Directory directory =
        await getApplicationDocumentsDirectory();

    File file = File("${directory.path}/myfile.txt");

    await file.writeAsString(controller.text);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("File saved successfully")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Write File"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: "Enter text",
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveFile,
              child: Text("Save to File"),
            ),
          ],
        ),
      ),
    );
  }
}
13. Read Text from Stored File

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ReadFileScreen(),
    );
  }
}

class ReadFileScreen extends StatefulWidget {
  @override
  State<ReadFileScreen> createState() => _ReadFileScreenState();
}

class _ReadFileScreenState extends State<ReadFileScreen> {
  String text = "No file data";

  Future<void> readFile() async {
    Directory directory =
        await getApplicationDocumentsDirectory();

    File file = File("${directory.path}/myfile.txt");

    if (await file.exists()) {
      String data = await file.readAsString();

      setState(() {
        text = data;
      });
    } else {
      setState(() {
        text = "File does not exist";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Read File"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: readFile,
              child: Text("Read File"),
            ),
          ],
        ),
      ),
    );
  }
}

14. Save Student Object as JSON in SharedPreferences

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Student {
  String name;
  String rollNumber;
  String course;

  Student(this.name, this.rollNumber, this.course);

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "rollNumber": rollNumber,
      "course": course,
    };
  }

  Student.fromMap(Map<String, dynamic> map)
      : name = map["name"],
        rollNumber = map["rollNumber"],
        course = map["course"];
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StudentScreen(),
    );
  }
}

class StudentScreen extends StatefulWidget {
  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  String studentData = "No data";

  Future<void> saveStudent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Student student =
        Student("Ritiksha", "101", "BCA");

    String jsonString = jsonEncode(student.toMap());

    await prefs.setString("student", jsonString);

    loadStudent();
  }

  Future<void> loadStudent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? jsonString = prefs.getString("student");

    if (jsonString != null) {
      Map<String, dynamic> map = jsonDecode(jsonString);

      Student student = Student.fromMap(map);

      setState(() {
        studentData =
            "Name: ${student.name}\n"
            "Roll Number: ${student.rollNumber}\n"
            "Course: ${student.course}";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadStudent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student JSON"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              studentData,
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveStudent,
              child: Text("Save Student"),
            ),
          ],
        ),
      ),
    );
  }
}
15. To-Do App using SharedPreferences

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController controller = TextEditingController();

  List<String> tasks = [];

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  Future<void> loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      tasks = prefs.getStringList("tasks") ?? [];
    });
  }

  Future<void> addTask() async {
    if (controller.text.isNotEmpty) {
      setState(() {
        tasks.add(controller.text);
        controller.clear();
      });

      SharedPreferences prefs =
          await SharedPreferences.getInstance();

      await prefs.setStringList("tasks", tasks);
    }
  }

  Future<void> deleteTask(int index) async {
    setState(() {
      tasks.removeAt(index);
    });

    SharedPreferences prefs =
        await SharedPreferences.getInstance();

    await prefs.setStringList("tasks", tasks);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("To-Do App"),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: "Enter Task",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: addTask,
              child: Text("Add Task"),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(tasks[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        deleteTask(index);
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
16. Notes App using JSON File

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController controller = TextEditingController();

  List<String> notes = [];

  @override
  void initState() {
    super.initState();
    loadNotes();
  }

  Future<File> getFile() async {
    Directory directory =
        await getApplicationDocumentsDirectory();

    return File("${directory.path}/notes.json");
  }

  Future<void> saveNotes() async {
    File file = await getFile();

    String jsonData = jsonEncode(notes);

    await file.writeAsString(jsonData);
  }

  Future<void> loadNotes() async {
    File file = await getFile();

    if (await file.exists()) {
      String data = await file.readAsString();

      setState(() {
        notes = List<String>.from(jsonDecode(data));
      });
    }
  }

  void addNote() {
    if (controller.text.isNotEmpty) {
      setState(() {
        notes.add(controller.text);
        controller.clear();
      });

      saveNotes();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Notes App"),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: "Enter Note",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: addNote,
              child: Text("Add Note"),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.note),
                    title: Text(notes[index]),
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
17. Student Profile Application

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Student Profile",
      home: StudentProfileScreen(),
    );
  }
}

class StudentProfileScreen extends StatefulWidget {
  @override
  State<StudentProfileScreen> createState() =>
      _StudentProfileScreenState();
}

class _StudentProfileScreenState
    extends State<StudentProfileScreen> {
  TextEditingController nameController =
      TextEditingController();

  TextEditingController rollController =
      TextEditingController();

  TextEditingController courseController =
      TextEditingController();

  TextEditingController semesterController =
      TextEditingController();

  bool profileSaved = false;

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> saveProfile() async {
    SharedPreferences prefs =
        await SharedPreferences.getInstance();

    await prefs.setString("name", nameController.text);
    await prefs.setString(
        "rollNumber", rollController.text);
    await prefs.setString(
        "course", courseController.text);
    await prefs.setString(
        "semester", semesterController.text);

    setState(() {
      profileSaved = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Profile Saved")),
    );
  }

  Future<void> loadProfile() async {
    SharedPreferences prefs =
        await SharedPreferences.getInstance();

    String? name = prefs.getString("name");

    if (name != null) {
      setState(() {
        nameController.text = name;
        rollController.text =
            prefs.getString("rollNumber") ?? "";
        courseController.text =
            prefs.getString("course") ?? "";
        semesterController.text =
            prefs.getString("semester") ?? "";

        profileSaved = true;
      });
    }
  }

  Future<void> clearProfile() async {
    SharedPreferences prefs =
        await SharedPreferences.getInstance();

    await prefs.clear();

    setState(() {
      nameController.clear();
      rollController.clear();
      courseController.clear();
      semesterController.clear();

      profileSaved = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Profile Cleared")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student Profile"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Student Name",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 10),

            TextField(
              controller: rollController,
              decoration: InputDecoration(
                labelText: "Roll Number",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 10),

            TextField(
              controller: courseController,
              decoration: InputDecoration(
                labelText: "Course",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 10),

            TextField(
              controller: semesterController,
              decoration: InputDecoration(
                labelText: "Semester",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: saveProfile,
              child: Text("Save Profile"),
            ),

            SizedBox(height: 10),

            ElevatedButton(
              onPressed: loadProfile,
              child: Text("Edit / Load Profile"),
            ),

            SizedBox(height: 10),

            ElevatedButton(
              onPressed: clearProfile,
              child: Text("Clear Profile"),
            ),

            SizedBox(height: 30),

            if (profileSaved)
              Card(
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "Saved Student Profile\n\n"
                    "Name: ${nameController.text}\n"
                    "Roll Number: ${rollController.text}\n"
                    "Course: ${courseController.text}\n"
                    "Semester: ${semesterController.text}",
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}