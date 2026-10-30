Q1_database_creation.dart

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DatabasePage(),
    );
  }
}

class DatabasePage extends StatefulWidget {
  const DatabasePage({super.key});

  @override
  State<DatabasePage> createState() => _DatabasePageState();
}

class _DatabasePageState extends State<DatabasePage> {
  late Future<Database> databaseFuture;

  @override
  void initState() {
    super.initState();
    databaseFuture = createDatabase();
  }

  Future<Database> createDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, 'students.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE students (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            rollNumber TEXT NOT NULL,
            course TEXT NOT NULL
          )
        ''');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create SQLite Database'),
      ),
      body: Center(
        child: FutureBuilder<Database>(
          future: databaseFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const CircularProgressIndicator();
            }

            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            return const Text(
              'Database created successfully!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      ),
    );
  }
}

Q2_create_table.dart

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TablePage(),
    );
  }
}

class TablePage extends StatefulWidget {
  const TablePage({super.key});

  @override
  State<TablePage> createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  String message = 'Creating students table...';

  @override
  void initState() {
    super.initState();
    createTable();
  }

  Future<void> createTable() async {
    try {
      final dbPath = await getDatabasesPath();

      final db = await openDatabase(
        p.join(dbPath, 'students_q2.db'),
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''
            CREATE TABLE students (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name TEXT NOT NULL,
              rollNumber TEXT NOT NULL,
              course TEXT NOT NULL
            )
          ''');
        },
      );

      await db.execute('''
        CREATE TABLE IF NOT EXISTS students (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          rollNumber TEXT NOT NULL,
          course TEXT NOT NULL
        )
      ''');

      await db.close();

      setState(() {
        message = 'Students table created successfully!';
      });
    } catch (e) {
      setState(() {
        message = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Students Table')),
      body: Center(
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

Q3_insert_student.dart

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InsertPage(),
    );
  }
}

class InsertPage extends StatefulWidget {
  const InsertPage({super.key});

  @override
  State<InsertPage> createState() => _InsertPageState();
}

class _InsertPageState extends State<InsertPage> {
  String message = 'Inserting student...';

  Future<Database> openStudentDatabase() async {
    final dbPath = await getDatabasesPath();

    return openDatabase(
      p.join(dbPath, 'students_q3.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE students (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            rollNumber TEXT NOT NULL,
            course TEXT NOT NULL
          )
        ''');
      },
    );
  }

  @override
  void initState() {
    super.initState();
    insertStudent();
  }

  Future<void> insertStudent() async {
    try {
      final db = await openStudentDatabase();

      final id = await db.insert('students', {
        'name': 'Aarav Sharma',
        'rollNumber': '101',
        'course': 'BCA',
      });

      setState(() {
        message = 'Student inserted successfully!\nStudent ID: $id';
      });
    } catch (e) {
      setState(() {
        message = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Insert Student')),
      body: Center(
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

Q4_insert_using_textfields.dart

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StudentFormPage(),
    );
  }
}

class StudentFormPage extends StatefulWidget {
  const StudentFormPage({super.key});

  @override
  State<StudentFormPage> createState() => _StudentFormPageState();
}

class _StudentFormPageState extends State<StudentFormPage> {
  final nameController = TextEditingController();
  final rollController = TextEditingController();
  final courseController = TextEditingController();

  String message = '';

  Future<Database> openStudentDatabase() async {
    final dbPath = await getDatabasesPath();

    return openDatabase(
      p.join(dbPath, 'students_q4.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE students (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            rollNumber TEXT NOT NULL,
            course TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<void> insertStudent() async {
    if (nameController.text.trim().isEmpty ||
        rollController.text.trim().isEmpty ||
        courseController.text.trim().isEmpty) {
      setState(() {
        message = 'Please fill in all fields.';
      });
      return;
    }

    try {
      final db = await openStudentDatabase();

      await db.insert('students', {
        'name': nameController.text.trim(),
        'rollNumber': rollController.text.trim(),
        'course': courseController.text.trim(),
      });

      setState(() {
        message = 'Student inserted successfully!';
      });

      nameController.clear();
      rollController.clear();
      courseController.clear();
    } catch (e) {
      setState(() {
        message = 'Error: $e';
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    rollController.dispose();
    courseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Registration')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
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
              controller: rollController,
              decoration: const InputDecoration(
                labelText: 'Roll Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: courseController,
              decoration: const InputDecoration(
                labelText: 'Course',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: insertStudent,
              child: const Text('Insert Student'),
            ),
            const SizedBox(height: 12),
            Text(message),
          ],
        ),
      ),
    );
  }
}

Q5_raw_insert.dart

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RawInsertPage(),
    );
  }
}

class RawInsertPage extends StatefulWidget {
  const RawInsertPage({super.key});

  @override
  State<RawInsertPage> createState() => _RawInsertPageState();
}

class _RawInsertPageState extends State<RawInsertPage> {
  String message = 'Inserting student...';

  Future<Database> openStudentDatabase() async {
    final dbPath = await getDatabasesPath();

    return openDatabase(
      p.join(dbPath, 'students_q5.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE students (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            rollNumber TEXT NOT NULL,
            course TEXT NOT NULL
          )
        ''');
      },
    );
  }

  @override
  void initState() {
    super.initState();
    insertStudent();
  }

  Future<void> insertStudent() async {
    try {
      final db = await openStudentDatabase();

      final id = await db.rawInsert(
        'INSERT INTO students (name, rollNumber, course) VALUES (?, ?, ?)',
        ['Diya Verma', '102', 'BCA'],
      );

      setState(() {
        message = 'Student inserted successfully!\nID: $id';
      });
    } catch (e) {
      setState(() {
        message = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Insert Using rawInsert')),
      body: Center(
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

Q6_display_students.dart

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StudentsListPage(),
    );
  }
}

class StudentsListPage extends StatefulWidget {
  const StudentsListPage({super.key});

  @override
  State<StudentsListPage> createState() => _StudentsListPageState();
}

class _StudentsListPageState extends State<StudentsListPage> {
  late Future<List<Map<String, Object?>>> studentsFuture;

  Future<Database> openStudentDatabase() async {
    final dbPath = await getDatabasesPath();

    return openDatabase(
      p.join(dbPath, 'students_q6.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE students (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            rollNumber TEXT NOT NULL,
            course TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<List<Map<String, Object?>>> getStudents() async {
    final db = await openStudentDatabase();
    return db.query('students', orderBy: 'id ASC');
  }

  @override
  void initState() {
    super.initState();
    studentsFuture = getStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Student Records')),
      body: FutureBuilder<List<Map<String, Object?>>>(
        future: studentsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final students = snapshot.data ?? [];

          if (students.isEmpty) {
            return const Center(child: Text('No student records found.'));
          }

          return ListView.builder(
            itemCount: students.length,
            itemBuilder: (context, index) {
              final student = students[index];

              return ListTile(
                leading: CircleAvatar(
                  child: Text('${student['id']}'),
                ),
                title: Text('${student['name']}'),
                subtitle: Text(
                  'Roll: ${student['rollNumber']}\n'
                  'Course: ${student['course']}',
                ),
              );
            },
          );
        },
      ),
    );
  }
}

Q7_raw_query.dart

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RawQueryPage(),
    );
  }
}

class RawQueryPage extends StatefulWidget {
  const RawQueryPage({super.key});

  @override
  State<RawQueryPage> createState() => _RawQueryPageState();
}

class _RawQueryPageState extends State<RawQueryPage> {
  late Future<List<Map<String, Object?>>> studentsFuture;

  Future<Database> openStudentDatabase() async {
    final path = p.join(await getDatabasesPath(), 'students_q7.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE students(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            rollNumber TEXT NOT NULL,
            course TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<List<Map<String, Object?>>> getStudents() async {
    final db = await openStudentDatabase();

    return db.rawQuery('SELECT * FROM students ORDER BY id ASC');
  }

  @override
  void initState() {
    super.initState();
    studentsFuture = getStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Students Using rawQuery')),
      body: FutureBuilder<List<Map<String, Object?>>>(
        future: studentsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final students = snapshot.data ?? [];

          if (students.isEmpty) {
            return const Center(child: Text('No records found.'));
          }

          return ListView(
            children: students.map((student) {
              return ListTile(
                title: Text('${student['name']}'),
                subtitle: Text(
                  'Roll: ${student['rollNumber']} | '
                  'Course: ${student['course']}',
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

Q8_update_student.dart

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UpdateStudentPage(),
    );
  }
}

class UpdateStudentPage extends StatefulWidget {
  const UpdateStudentPage({super.key});

  @override
  State<UpdateStudentPage> createState() => _UpdateStudentPageState();
}

class _UpdateStudentPageState extends State<UpdateStudentPage> {
  final idController = TextEditingController();
  final nameController = TextEditingController();
  final rollController = TextEditingController();
  final courseController = TextEditingController();

  String message = '';

  Future<Database> openStudentDatabase() async {
    return openDatabase(
      p.join(await getDatabasesPath(), 'students_q8.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE students(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            rollNumber TEXT NOT NULL,
            course TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<void> updateStudent() async {
    final id = int.tryParse(idController.text.trim());

    if (id == null ||
        nameController.text.trim().isEmpty ||
        rollController.text.trim().isEmpty ||
        courseController.text.trim().isEmpty) {
      setState(() => message = 'Enter a valid ID and fill all fields.');
      return;
    }

    try {
      final db = await openStudentDatabase();

      final count = await db.update(
        'students',
        {
          'name': nameController.text.trim(),
          'rollNumber': rollController.text.trim(),
          'course': courseController.text.trim(),
        },
        where: 'id = ?',
        whereArgs: [id],
      );

      setState(() {
        message = count > 0
            ? 'Student updated successfully!'
            : 'Student ID not found.';
      });
    } catch (e) {
      setState(() => message = 'Error: $e');
    }
  }

  @override
  void dispose() {
    idController.dispose();
    nameController.dispose();
    rollController.dispose();
    courseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Student')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: idController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Student ID'),
            ),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'New Name'),
            ),
            TextField(
              controller: rollController,
              decoration: const InputDecoration(labelText: 'New Roll Number'),
            ),
            TextField(
              controller: courseController,
              decoration: const InputDecoration(labelText: 'New Course'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: updateStudent,
              child: const Text('Update Student'),
            ),
            Text(message),
          ],
        ),
      ),
    );
  }
}

Q9_delete_student.dart

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DeleteStudentPage(),
    );
  }
}

class DeleteStudentPage extends StatefulWidget {
  const DeleteStudentPage({super.key});

  @override
  State<DeleteStudentPage> createState() => _DeleteStudentPageState();
}

class _DeleteStudentPageState extends State<DeleteStudentPage> {
  final idController = TextEditingController();
  String message = '';

  Future<Database> openStudentDatabase() async {
    return openDatabase(
      p.join(await getDatabasesPath(), 'students_q9.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE students(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            rollNumber TEXT NOT NULL,
            course TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<void> deleteStudent() async {
    final id = int.tryParse(idController.text.trim());

    if (id == null) {
      setState(() => message = 'Please enter a valid student ID.');
      return;
    }

    try {
      final db = await openStudentDatabase();

      final count = await db.delete(
        'students',
        where: 'id = ?',
        whereArgs: [id],
      );

      setState(() {
        message = count > 0
            ? 'Student deleted successfully!'
            : 'Student ID not found.';
      });
    } catch (e) {
      setState(() => message = 'Error: $e');
    }
  }

  @override
  void dispose() {
    idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Delete Student')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: idController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter Student ID',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: deleteStudent,
              child: const Text('Delete Student'),
            ),
            const SizedBox(height: 12),
            Text(message),
          ],
        ),
      ),
    );
  }
}

Q10_clear_all.dart

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ClearStudentsPage(),
    );
  }
}

class ClearStudentsPage extends StatefulWidget {
  const ClearStudentsPage({super.key});

  @override
  State<ClearStudentsPage> createState() => _ClearStudentsPageState();
}

class _ClearStudentsPageState extends State<ClearStudentsPage> {
  String message = '';

  Future<Database> openStudentDatabase() async {
    return openDatabase(
      p.join(await getDatabasesPath(), 'students_q10.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE students(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            rollNumber TEXT NOT NULL,
            course TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<void> clearAllStudents() async {
    try {
      final db = await openStudentDatabase();
      final count = await db.delete('students');

      setState(() {
        message = '$count student record(s) deleted.';
      });
    } catch (e) {
      setState(() => message = 'Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Clear All Students')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Delete all student records?',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: clearAllStudents,
              child: const Text('Clear All'),
            ),
            const SizedBox(height: 12),
            Text(message),
          ],
        ),
      ),
    );
  }
}

Q11_search_by_rollno.dart

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SearchStudentPage(),
    );
  }
}

class SearchStudentPage extends StatefulWidget {
  const SearchStudentPage({super.key});

  @override
  State<SearchStudentPage> createState() => _SearchStudentPageState();
}

class _SearchStudentPageState extends State<SearchStudentPage> {
  final rollController = TextEditingController();

  List<Map<String, Object?>> students = [];
  String message = '';

  Future<Database> openStudentDatabase() async {
    return openDatabase(
      p.join(await getDatabasesPath(), 'students_q11.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE students(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            rollNumber TEXT NOT NULL,
            course TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<void> searchStudent() async {
    if (rollController.text.trim().isEmpty) {
      setState(() => message = 'Enter a roll number.');
      return;
    }

    try {
      final db = await openStudentDatabase();

      final result = await db.query(
        'students',
        where: 'rollNumber = ?',
        whereArgs: [rollController.text.trim()],
      );

      setState(() {
        students = result;
        message = result.isEmpty ? 'No student found.' : '';
      });
    } catch (e) {
      setState(() => message = 'Error: $e');
    }
  }

  @override
  void dispose() {
    rollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Student')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: rollController,
              decoration: const InputDecoration(
                labelText: 'Enter Roll Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: searchStudent,
              child: const Text('Search'),
            ),
            Text(message),
            Expanded(
              child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  final student = students[index];

                  return ListTile(
                    title: Text('${student['name']}'),
                    subtitle: Text(
                      'Roll: ${student['rollNumber']} | '
                      'Course: ${student['course']}',
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

Q12_filter_by_course.dart

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CourseStudentsPage(),
    );
  }
}

class CourseStudentsPage extends StatefulWidget {
  const CourseStudentsPage({super.key});

  @override
  State<CourseStudentsPage> createState() => _CourseStudentsPageState();
}

class _CourseStudentsPageState extends State<CourseStudentsPage> {
  final List<String> courses = ['BCA', 'BBA', 'B.Tech', 'MCA'];

  String selectedCourse = 'BCA';
  List<Map<String, Object?>> students = [];
  String message = '';

  Future<Database> openStudentDatabase() async {
    return openDatabase(
      p.join(await getDatabasesPath(), 'students_q12.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE students(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            rollNumber TEXT NOT NULL,
            course TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<void> loadStudents() async {
    try {
      final db = await openStudentDatabase();

      final result = await db.query(
        'students',
        where: 'course = ?',
        whereArgs: [selectedCourse],
        orderBy: 'name ASC',
      );

      setState(() {
        students = result;
        message = result.isEmpty
            ? 'No students found for $selectedCourse.'
            : '';
      });
    } catch (e) {
      setState(() => message = 'Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    loadStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Students by Course')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButton<String>(
              value: selectedCourse,
              isExpanded: true,
              items: courses.map((course) {
                return DropdownMenuItem<String>(
                  value: course,
                  child: Text(course),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedCourse = value;
                  });
                  loadStudents();
                }
              },
            ),
            ElevatedButton(
              onPressed: loadStudents,
              child: const Text('Show Students'),
            ),
            Text(message),
            Expanded(
              child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  final student = students[index];

                  return ListTile(
                    title: Text('${student['name']}'),
                    subtitle: Text(
                      'Roll: ${student['rollNumber']} | '
                      'Course: ${student['course']}',
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

Q13_sort_by_name.dart

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SortedStudentsPage(),
    );
  }
}

class SortedStudentsPage extends StatefulWidget {
  const SortedStudentsPage({super.key});

  @override
  State<SortedStudentsPage> createState() => _SortedStudentsPageState();
}

class _SortedStudentsPageState extends State<SortedStudentsPage> {
  late Future<List<Map<String, Object?>>> studentsFuture;

  Future<Database> openStudentDatabase() async {
    return openDatabase(
      p.join(await getDatabasesPath(), 'students_q13.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE students(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            rollNumber TEXT NOT NULL,
            course TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<List<Map<String, Object?>>> getSortedStudents() async {
    final db = await openStudentDatabase();

    return db.query(
      'students',
      orderBy: 'name ASC',
    );
  }

  @override
  void initState() {
    super.initState();
    studentsFuture = getSortedStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Students in Alphabetical Order')),
      body: FutureBuilder<List<Map<String, Object?>>>(
        future: studentsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final students = snapshot.data ?? [];

          if (students.isEmpty) {
            return const Center(child: Text('No students found.'));
          }

          return ListView.builder(
            itemCount: students.length,
            itemBuilder: (context, index) {
              final student = students[index];

              return ListTile(
                leading: Text('${index + 1}'),
                title: Text('${student['name']}'),
                subtitle: Text(
                  'Roll: ${student['rollNumber']} | '
                  'Course: ${student['course']}',
                ),
              );
            },
          );
        },
      ),
    );
  }
}

Q14_count_students.dart

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StudentCountPage(),
    );
  }
}

class StudentCountPage extends StatefulWidget {
  const StudentCountPage({super.key});

  @override
  State<StudentCountPage> createState() => _StudentCountPageState();
}

class _StudentCountPageState extends State<StudentCountPage> {
  late Future<int> countFuture;

  Future<Database> openStudentDatabase() async {
    return openDatabase(
      p.join(await getDatabasesPath(), 'students_q14.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE students(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            rollNumber TEXT NOT NULL,
            course TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<int> getStudentCount() async {
    final db = await openStudentDatabase();

    final result = await db.rawQuery(
      'SELECT COUNT(*) AS total FROM students',
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }

  @override
  void initState() {
    super.initState();
    countFuture = getStudentCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Total Student Records')),
      body: Center(
        child: FutureBuilder<int>(
          future: countFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const CircularProgressIndicator();
            }

            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Total Number of Students',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 12),
                Text(
                  '${snapshot.data}',
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      countFuture = getStudentCount();
                    });
                  },
                  child: const Text('Refresh Count'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

Q15_student_model.dart

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

void main() => runApp(const MyApp());

class Student {
  final int? id;
  final String name;
  final String rollNumber;
  final String course;

  Student({
    this.id,
    required this.name,
    required this.rollNumber,
    required this.course,
  });

  Map<String, Object?> toMap() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'rollNumber': rollNumber,
      'course': course,
    };
  }

  factory Student.fromMap(Map<String, Object?> map) {
    return Student(
      id: map['id'] as int?,
      name: map['name'] as String,
      rollNumber: map['rollNumber'] as String,
      course: map['course'] as String,
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StudentModelPage(),
    );
  }
}

class StudentModelPage extends StatefulWidget {
  const StudentModelPage({super.key});

  @override
  State<StudentModelPage> createState() => _StudentModelPageState();
}

class _StudentModelPageState extends State<StudentModelPage> {
  final nameController = TextEditingController();
  final rollController = TextEditingController();
  final courseController = TextEditingController();

  List<Student> students = [];
  String message = '';

  Future<Database> openStudentDatabase() async {
    return openDatabase(
      p.join(await getDatabasesPath(), 'students_q15.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE students(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            rollNumber TEXT NOT NULL,
            course TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<void> insertStudent() async {
    if (nameController.text.trim().isEmpty ||
        rollController.text.trim().isEmpty ||
        courseController.text.trim().isEmpty) {
      setState(() => message = 'Please fill in all fields.');
      return;
    }

    try {
      final db = await openStudentDatabase();

      final student = Student(
        name: nameController.text.trim(),
        rollNumber: rollController.text.trim(),
        course: courseController.text.trim(),
      );

      await db.insert('students', student.toMap());

      nameController.clear();
      rollController.clear();
      courseController.clear();

      setState(() => message = 'Student inserted successfully!');

      await loadStudents();
    } catch (e) {
      setState(() => message = 'Error: $e');
    }
  }

  Future<void> loadStudents() async {
    final db = await openStudentDatabase();
    final rows = await db.query('students', orderBy: 'id ASC');

    setState(() {
      students = rows.map((row) => Student.fromMap(row)).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    loadStudents();
  }

  @override
  void dispose() {
    nameController.dispose();
    rollController.dispose();
    courseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Model Example')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Student Name'),
            ),
            TextField(
              controller: rollController,
              decoration: const InputDecoration(labelText: 'Roll Number'),
            ),
            TextField(
              controller: courseController,
              decoration: const InputDecoration(labelText: 'Course'),
            ),
            ElevatedButton(
              onPressed: insertStudent,
              child: const Text('Insert Student'),
            ),
            Text(message),
            Expanded(
              child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  final student = students[index];

                  return ListTile(
                    title: Text(student.name),
                    subtitle: Text(
                      'ID: ${student.id} | '
                      'Roll: ${student.rollNumber} | '
                      'Course: ${student.course}',
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

Q16_database_helper.dart

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

void main() => runApp(const MyApp());

// DatabaseHelper Class
class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, 'students_q16.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE students(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            rollNumber TEXT NOT NULL,
            course TEXT NOT NULL
          )
        ''');
      },
    );
  }

  // Insert Operation
  Future<int> insertStudent(Map<String, Object?> student) async {
    final db = await database;
    return db.insert('students', student);
  }

  // Read Operation
  Future<List<Map<String, Object?>>> getStudents() async {
    final db = await database;
    return db.query('students', orderBy: 'id ASC');
  }

  // Update Operation
  Future<int> updateStudent(
    int id,
    Map<String, Object?> student,
  ) async {
    final db = await database;

    return db.update(
      'students',
      student,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Delete Operation
  Future<int> deleteStudent(int id) async {
    final db = await database;

    return db.delete(
      'students',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

// Main Application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DatabaseHelperPage(),
    );
  }
}

class DatabaseHelperPage extends StatefulWidget {
  const DatabaseHelperPage({super.key});

  @override
  State<DatabaseHelperPage> createState() =>
      _DatabaseHelperPageState();
}

class _DatabaseHelperPageState extends State<DatabaseHelperPage> {
  final nameController = TextEditingController();
  final rollController = TextEditingController();
  final courseController = TextEditingController();
  final idController = TextEditingController();

  List<Map<String, Object?>> students = [];
  String message = '';

  @override
  void initState() {
    super.initState();
    loadStudents();
  }

  Future<void> loadStudents() async {
    try {
      final data = await DatabaseHelper.instance.getStudents();

      if (!mounted) return;

      setState(() {
        students = data;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => message = 'Error: $e');
    }
  }

  Future<void> insertStudent() async {
    if (nameController.text.trim().isEmpty ||
        rollController.text.trim().isEmpty ||
        courseController.text.trim().isEmpty) {
      setState(() => message = 'Please fill in all fields.');
      return;
    }

    try {
      await DatabaseHelper.instance.insertStudent({
        'name': nameController.text.trim(),
        'rollNumber': rollController.text.trim(),
        'course': courseController.text.trim(),
      });

      nameController.clear();
      rollController.clear();
      courseController.clear();

      setState(() => message = 'Student inserted successfully!');

      await loadStudents();
    } catch (e) {
      setState(() => message = 'Error: $e');
    }
  }

  Future<void> updateStudent() async {
    final id = int.tryParse(idController.text.trim());

    if (id == null ||
        nameController.text.trim().isEmpty ||
        rollController.text.trim().isEmpty ||
        courseController.text.trim().isEmpty) {
      setState(() => message = 'Enter ID and fill all fields.');
      return;
    }

    try {
      final count = await DatabaseHelper.instance.updateStudent(
        id,
        {
          'name': nameController.text.trim(),
          'rollNumber': rollController.text.trim(),
          'course': courseController.text.trim(),
        },
      );

      setState(() {
        message = count > 0
            ? 'Student updated successfully!'
            : 'Student ID not found.';
      });

      await loadStudents();
    } catch (e) {
      setState(() => message = 'Error: $e');
    }
  }

  Future<void> deleteStudent() async {
    final id = int.tryParse(idController.text.trim());

    if (id == null) {
      setState(() => message = 'Enter a valid student ID.');
      return;
    }

    try {
      final count =
          await DatabaseHelper.instance.deleteStudent(id);

      setState(() {
        message = count > 0
            ? 'Student deleted successfully!'
            : 'Student ID not found.';
      });

      await loadStudents();
    } catch (e) {
      setState(() => message = 'Error: $e');
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    rollController.dispose();
    courseController.dispose();
    idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DatabaseHelper CRUD'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: idController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Student ID for Update/Delete',
              ),
            ),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Student Name',
              ),
            ),
            TextField(
              controller: rollController,
              decoration: const InputDecoration(
                labelText: 'Roll Number',
              ),
            ),
            TextField(
              controller: courseController,
              decoration: const InputDecoration(
                labelText: 'Course',
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              children: [
                ElevatedButton(
                  onPressed: insertStudent,
                  child: const Text('Insert'),
                ),
                ElevatedButton(
                  onPressed: updateStudent,
                  child: const Text('Update'),
                ),
                ElevatedButton(
                  onPressed: deleteStudent,
                  child: const Text('Delete'),
                ),
                ElevatedButton(
                  onPressed: loadStudents,
                  child: const Text('Read'),
                ),
              ],
            ),
            Text(message),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  final student = students[index];

                  return ListTile(
                    title: Text('${student['name']}'),
                    subtitle: Text(
                      'ID: ${student['id']} | '
                      'Roll: ${student['rollNumber']} | '
                      'Course: ${student['course']}',
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

Q17_student_management.dart

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

void main() {
  runApp(const MyApp());
}

// Student Model Class
class Student {
  final int? id;
  final String name;
  final String rollNumber;
  final String course;

  const Student({
    this.id,
    required this.name,
    required this.rollNumber,
    required this.course,
  });

  Map<String, Object?> toMap() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'rollNumber': rollNumber,
      'course': course,
    };
  }

  factory Student.fromMap(Map<String, Object?> map) {
    return Student(
      id: map['id'] as int?,
      name: map['name'] as String,
      rollNumber: map['rollNumber'] as String,
      course: map['course'] as String,
    );
  }
}

// DatabaseHelper Class
class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await openStudentDatabase();
    return _database!;
  }

  Future<Database> openStudentDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, 'student_management.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE students(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            rollNumber TEXT NOT NULL,
            course TEXT NOT NULL
          )
        ''');
      },
    );
  }

  // Create: Insert a student
  Future<int> insertStudent(Student student) async {
    final db = await database;

    return db.insert(
      'students',
      student.toMap(),
    );
  }

  // Read: Get all students
  Future<List<Student>> getStudents() async {
    final db = await database;

    final result = await db.query(
      'students',
      orderBy: 'id DESC',
    );

    return result.map(Student.fromMap).toList();
  }

  // Update: Update an existing student
  Future<int> updateStudent(Student student) async {
    final db = await database;

    return db.update(
      'students',
      student.toMap(),
      where: 'id = ?',
      whereArgs: [student.id],
    );
  }

  // Delete: Delete a student
  Future<int> deleteStudent(int id) async {
    final db = await database;

    return db.delete(
      'students',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

// Main Application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      home: const StudentManagementPage(),
    );
  }
}

// Student Management Screen
class StudentManagementPage extends StatefulWidget {
  const StudentManagementPage({super.key});

  @override
  State<StudentManagementPage> createState() =>
      _StudentManagementPageState();
}

class _StudentManagementPageState
    extends State<StudentManagementPage> {
  final nameController = TextEditingController();
  final rollController = TextEditingController();
  final courseController = TextEditingController();

  List<Student> students = [];

  int? editingId;
  String message = '';

  @override
  void initState() {
    super.initState();
    loadStudents();
  }

  // Load all student records
  Future<void> loadStudents() async {
    try {
      final data = await DatabaseHelper.instance.getStudents();

      if (!mounted) return;

      setState(() {
        students = data;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        message = 'Error loading students: $e';
      });
    }
  }

  // Add or update a student
  Future<void> saveStudent() async {
    final name = nameController.text.trim();
    final rollNumber = rollController.text.trim();
    final course = courseController.text.trim();

    if (name.isEmpty ||
        rollNumber.isEmpty ||
        course.isEmpty) {
      setState(() {
        message = 'Please fill in all fields.';
      });
      return;
    }

    try {
      if (editingId == null) {
        final student = Student(
          name: name,
          rollNumber: rollNumber,
          course: course,
        );

        await DatabaseHelper.instance.insertStudent(student);

        setState(() {
          message = 'Student added successfully!';
        });
      } else {
        final student = Student(
          id: editingId,
          name: name,
          rollNumber: rollNumber,
          course: course,
        );

        final count =
            await DatabaseHelper.instance.updateStudent(student);

        setState(() {
          message = count > 0
              ? 'Student updated successfully!'
              : 'Student not found.';
        });
      }

      clearForm();
      await loadStudents();
    } catch (e) {
      setState(() {
        message = 'Error: $e';
      });
    }
  }

  // Load selected student into the form
  void editStudent(Student student) {
    setState(() {
      editingId = student.id;
      nameController.text = student.name;
      rollController.text = student.rollNumber;
      courseController.text = student.course;
      message = 'Editing student ID: ${student.id}';
    });
  }

  // Delete a student after confirmation
  Future<void> deleteStudent(Student student) async {
    if (student.id == null) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Student'),
          content: Text(
            'Are you sure you want to delete ${student.name}?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;

    try {
      await DatabaseHelper.instance.deleteStudent(student.id!);

      if (editingId == student.id) {
        clearForm();
      }

      setState(() {
        message = 'Student deleted successfully!';
      });

      await loadStudents();
    } catch (e) {
      setState(() {
        message = 'Error: $e';
      });
    }
  }

  // Clear all input fields
  void clearForm() {
    nameController.clear();
    rollController.clear();
    courseController.clear();

    setState(() {
      editingId = null;
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    rollController.dispose();
    courseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Record Management'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Student Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: rollController,
              decoration: const InputDecoration(
                labelText: 'Roll Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: courseController,
              decoration: const InputDecoration(
                labelText: 'Course',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(
                  onPressed: saveStudent,
                  child: Text(
                    editingId == null
                        ? 'Add Student'
                        : 'Update Student',
                  ),
                ),
                OutlinedButton(
                  onPressed: clearForm,
                  child: const Text('Clear Form'),
                ),
                OutlinedButton(
                  onPressed: loadStudents,
                  child: const Text('Refresh'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
            ),
            const Divider(),
            Expanded(
              child: students.isEmpty
                  ? const Center(
                      child: Text('No student records found.'),
                    )
                  : ListView.builder(
                      itemCount: students.length,
                      itemBuilder: (context, index) {
                        final student = students[index];

                        return Card(
                          child: ListTile(
                            title: Text(student.name),
                            subtitle: Text(
                              'ID: ${student.id}\n'
                              'Roll Number: ${student.rollNumber}\n'
                              'Course: ${student.course}',
                            ),
                            isThreeLine: true,
                            onTap: () => editStudent(student),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              tooltip: 'Delete Student',
                              onPressed: () =>
                                  deleteStudent(student),
                            ),
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