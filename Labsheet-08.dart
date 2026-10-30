q1_notes_app.dart

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: NotesScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  List<Map<String, dynamic>> notes = [];

  Future<Database> openDB() async {
    String path = join(await getDatabasesPath(), 'notes1.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE notes(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            content TEXT
          )
        ''');
      },
    );
  }

  Future<void> addNote() async {
    if (titleController.text.isEmpty ||
        contentController.text.isEmpty) {
      return;
    }

    Database db = await openDB();

    await db.insert('notes', {
      'title': titleController.text,
      'content': contentController.text,
    });

    await db.close();

    titleController.clear();
    contentController.clear();

    loadNotes();
  }

  Future<void> loadNotes() async {
    Database db = await openDB();

    List<Map<String, dynamic>> data = await db.query('notes');

    await db.close();

    setState(() {
      notes = data;
    });
  }

  @override
  void initState() {
    super.initState();
    loadNotes();
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Notes")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Note Title",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: contentController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Note Content",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: addNote,
              child: const Text("Add Note"),
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];

                  return Card(
                    child: ListTile(
                      title: Text(note['title']),
                      subtitle: Text(note['content']),
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

q2_edit_note.dart

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: NotesScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  List<Map<String, dynamic>> notes = [];
  int? editingId;

  Future<Database> openDB() async {
    String path = join(await getDatabasesPath(), 'notes2.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE notes(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            content TEXT
          )
        ''');
      },
    );
  }

  Future<void> loadNotes() async {
    Database db = await openDB();
    List<Map<String, dynamic>> data = await db.query('notes');
    await db.close();

    setState(() {
      notes = data;
    });
  }

  Future<void> saveNote() async {
    if (titleController.text.isEmpty ||
        contentController.text.isEmpty) {
      return;
    }

    Database db = await openDB();

    if (editingId == null) {
      await db.insert('notes', {
        'title': titleController.text,
        'content': contentController.text,
      });
    } else {
      await db.update(
        'notes',
        {
          'title': titleController.text,
          'content': contentController.text,
        },
        where: 'id = ?',
        whereArgs: [editingId],
      );
    }

    await db.close();

    clearForm();
    loadNotes();
  }

  void editNote(Map<String, dynamic> note) {
    setState(() {
      editingId = note['id'];
      titleController.text = note['title'];
      contentController.text = note['content'];
    });
  }

  void clearForm() {
    setState(() {
      editingId = null;
      titleController.clear();
      contentController.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    loadNotes();
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Notes")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Note Title",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: contentController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Note Content",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: saveNote,
              child: Text(editingId == null ? "Add Note" : "Update Note"),
            ),
            TextButton(
              onPressed: clearForm,
              child: const Text("Clear"),
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];

                  return Card(
                    child: ListTile(
                      title: Text(note['title']),
                      subtitle: Text(note['content']),
                      trailing: const Icon(Icons.edit),
                      onTap: () => editNote(note),
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

q3_swipe_delete_note.dart

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: NotesScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  List<Map<String, dynamic>> notes = [];

  Future<Database> openDB() async {
    String path = join(await getDatabasesPath(), 'notes3.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE notes(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            content TEXT
          )
        ''');
      },
    );
  }

  Future<void> addNote() async {
    if (titleController.text.isEmpty ||
        contentController.text.isEmpty) {
      return;
    }

    Database db = await openDB();

    await db.insert('notes', {
      'title': titleController.text,
      'content': contentController.text,
    });

    await db.close();

    titleController.clear();
    contentController.clear();

    loadNotes();
  }

  Future<void> loadNotes() async {
    Database db = await openDB();
    List<Map<String, dynamic>> data = await db.query('notes');
    await db.close();

    setState(() {
      notes = data;
    });
  }

  Future<void> deleteNote(int id) async {
    Database db = await openDB();

    await db.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );

    await db.close();

    loadNotes();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Note deleted successfully")),
    );
  }

  @override
  void initState() {
    super.initState();
    loadNotes();
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Swipe to Delete Notes")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Note Title",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: contentController,
              decoration: const InputDecoration(
                labelText: "Note Content",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: addNote,
              child: const Text("Add Note"),
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];

                  return Dismissible(
                    key: ValueKey(note['id']),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.all(20),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    onDismissed: (direction) {
                      deleteNote(note['id']);
                    },
                    child: Card(
                      child: ListTile(
                        title: Text(note['title']),
                        subtitle: Text(note['content']),
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

q4_search_notes.dart

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SearchNotesScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SearchNotesScreen extends StatefulWidget {
  const SearchNotesScreen({super.key});

  @override
  State<SearchNotesScreen> createState() => _SearchNotesScreenState();
}

class _SearchNotesScreenState extends State<SearchNotesScreen> {
  final searchController = TextEditingController();

  List<Map<String, dynamic>> notes = [];

  Future<Database> openDB() async {
    String path = join(await getDatabasesPath(), 'notes4.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE notes(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            content TEXT
          )
        ''');

        await db.insert('notes', {
          'title': 'Flutter Basics',
          'content': 'Learn Flutter widgets and layouts',
        });

        await db.insert('notes', {
          'title': 'SQLite Database',
          'content': 'Learn database operations',
        });

        await db.insert('notes', {
          'title': 'Python Programming',
          'content': 'Learn Python basics',
        });
      },
    );
  }

  Future<void> searchNotes(String value) async {
    Database db = await openDB();

    List<Map<String, dynamic>> data = await db.query(
      'notes',
      where: 'title LIKE ?',
      whereArgs: ['%$value%'],
    );

    await db.close();

    setState(() {
      notes = data;
    });
  }

  @override
  void initState() {
    super.initState();
    searchNotes('');
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search Notes")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: const InputDecoration(
                labelText: "Search by Title",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: searchNotes,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];

                  return Card(
                    child: ListTile(
                      title: Text(note['title']),
                      subtitle: Text(note['content']),
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

q5_contact_book.dart

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ContactScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  List<Map<String, dynamic>> contacts = [];

  Future<Database> openDB() async {
    String path = join(await getDatabasesPath(), 'contacts5.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE contacts(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            phone TEXT
          )
        ''');
      },
    );
  }

  Future<void> addContact() async {
    if (nameController.text.isEmpty ||
        phoneController.text.isEmpty) {
      return;
    }

    Database db = await openDB();

    await db.insert('contacts', {
      'name': nameController.text,
      'phone': phoneController.text,
    });

    await db.close();

    nameController.clear();
    phoneController.clear();

    loadContacts();
  }

  Future<void> loadContacts() async {
    Database db = await openDB();
    List<Map<String, dynamic>> data = await db.query('contacts');
    await db.close();

    setState(() {
      contacts = data;
    });
  }

  @override
  void initState() {
    super.initState();
    loadContacts();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contact Book")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Contact Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Phone Number",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: addContact,
              child: const Text("Add Contact"),
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  final contact = contacts[index];

                  return Card(
                    child: ListTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      title: Text(contact['name']),
                      subtitle: Text(contact['phone']),
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

q6_delete_contact_confirmation.dart

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ContactScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  List<Map<String, dynamic>> contacts = [];

  Future<Database> openDB() async {
    String path = join(await getDatabasesPath(), 'contacts6.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE contacts(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            phone TEXT
          )
        ''');
      },
    );
  }

  Future<void> addContact() async {
    if (nameController.text.isEmpty ||
        phoneController.text.isEmpty) {
      return;
    }

    Database db = await openDB();

    await db.insert('contacts', {
      'name': nameController.text,
      'phone': phoneController.text,
    });

    await db.close();

    nameController.clear();
    phoneController.clear();

    loadContacts();
  }

  Future<void> loadContacts() async {
    Database db = await openDB();
    List<Map<String, dynamic>> data = await db.query('contacts');
    await db.close();

    setState(() {
      contacts = data;
    });
  }

  Future<void> deleteContact(int id) async {
    Database db = await openDB();

    await db.delete(
      'contacts',
      where: 'id = ?',
      whereArgs: [id],
    );

    await db.close();

    loadContacts();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Contact deleted successfully")),
    );
  }

  Future<void> confirmDelete(int id, String name) async {
    bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Contact"),
          content: Text("Are you sure you want to delete $name?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      await deleteContact(id);
    }
  }

  @override
  void initState() {
    super.initState();
    loadContacts();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contact Book")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Contact Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Phone Number",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: addContact,
              child: const Text("Add Contact"),
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  final contact = contacts[index];

                  return Card(
                    child: ListTile(
                      title: Text(contact['name']),
                      subtitle: Text(contact['phone']),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () => confirmDelete(
                          contact['id'],
                          contact['name'],
                        ),
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

q7_search_contacts.dart

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ContactSearchScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ContactSearchScreen extends StatefulWidget {
  const ContactSearchScreen({super.key});

  @override
  State<ContactSearchScreen> createState() =>
      _ContactSearchScreenState();
}

class _ContactSearchScreenState extends State<ContactSearchScreen> {
  final searchController = TextEditingController();

  List<Map<String, dynamic>> contacts = [];

  Future<Database> openDB() async {
    String path = join(await getDatabasesPath(), 'contacts7.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE contacts(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            phone TEXT
          )
        ''');

        await db.insert('contacts', {
          'name': 'Rahul',
          'phone': '9876543210',
        });

        await db.insert('contacts', {
          'name': 'Rohit',
          'phone': '9876543211',
        });

        await db.insert('contacts', {
          'name': 'Priya',
          'phone': '9876543212',
        });
      },
    );
  }

  Future<void> searchContacts(String value) async {
    Database db = await openDB();

    List<Map<String, dynamic>> data = await db.query(
      'contacts',
      where: 'name LIKE ?',
      whereArgs: ['%$value%'],
    );

    await db.close();

    setState(() {
      contacts = data;
    });
  }

  @override
  void initState() {
    super.initState();
    searchContacts('');
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search Contacts")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: const InputDecoration(
                labelText: "Search Contact by Name",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: searchContacts,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  final contact = contacts[index];

                  return ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(contact['name']),
                    subtitle: Text(contact['phone']),
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

q8_expense_tracker.dart

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ExpenseScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  List<Map<String, dynamic>> expenses = [];

  Future<Database> openDB() async {
    String path = join(await getDatabasesPath(), 'expenses8.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE expenses(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            amount REAL
          )
        ''');
      },
    );
  }

  Future<void> addExpense() async {
    String title = titleController.text.trim();
    double? amount = double.tryParse(amountController.text);

    if (title.isEmpty || amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter valid expense details")),
      );
      return;
    }

    Database db = await openDB();

    await db.insert('expenses', {
      'title': title,
      'amount': amount,
    });

    await db.close();

    titleController.clear();
    amountController.clear();

    loadExpenses();
  }

  Future<void> loadExpenses() async {
    Database db = await openDB();
    List<Map<String, dynamic>> data = await db.query('expenses');
    await db.close();

    setState(() {
      expenses = data;
    });
  }

  @override
  void initState() {
    super.initState();
    loadExpenses();
  }

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Expense Tracker")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Expense Title",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Amount",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: addExpense,
              child: const Text("Add Expense"),
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: expenses.length,
                itemBuilder: (context, index) {
                  final expense = expenses[index];

                  return ListTile(
                    leading: const Icon(Icons.money),
                    title: Text(expense['title']),
                    trailing: Text(
                      "₹${expense['amount']}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
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

q9_total_expense.dart

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TotalExpenseScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TotalExpenseScreen extends StatefulWidget {
  const TotalExpenseScreen({super.key});

  @override
  State<TotalExpenseScreen> createState() =>
      _TotalExpenseScreenState();
}

class _TotalExpenseScreenState extends State<TotalExpenseScreen> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  List<Map<String, dynamic>> expenses = [];
  double totalExpense = 0;

  Future<Database> openDB() async {
    String path = join(await getDatabasesPath(), 'expenses9.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE expenses(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            amount REAL
          )
        ''');
      },
    );
  }

  Future<void> addExpense() async {
    String title = titleController.text.trim();
    double? amount = double.tryParse(amountController.text);

    if (title.isEmpty || amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter valid details")),
      );
      return;
    }

    Database db = await openDB();

    await db.insert('expenses', {
      'title': title,
      'amount': amount,
    });

    await db.close();

    titleController.clear();
    amountController.clear();

    loadExpenses();
  }

  Future<void> loadExpenses() async {
    Database db = await openDB();

    List<Map<String, dynamic>> data = await db.query('expenses');

    List<Map<String, Object?>> result = await db.rawQuery(
      'SELECT SUM(amount) AS total FROM expenses',
    );

    double total =
        (result.first['total'] as num?)?.toDouble() ?? 0.0;

    await db.close();

    setState(() {
      expenses = data;
      totalExpense = total;
    });
  }

  @override
  void initState() {
    super.initState();
    loadExpenses();
  }

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Expense Tracker")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Expense Title",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Amount",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: addExpense,
              child: const Text("Add Expense"),
            ),
            const SizedBox(height: 15),
            Card(
              child: ListTile(
                title: const Text("Total Expense"),
                trailing: Text(
                  "₹${totalExpense.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: expenses.length,
                itemBuilder: (context, index) {
                  final expense = expenses[index];

                  return ListTile(
                    title: Text(expense['title']),
                    trailing: Text("₹${expense['amount']}"),
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

q10_todo_checkbox.dart

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TodoScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final taskController = TextEditingController();

  List<Map<String, dynamic>> tasks = [];

  Future<Database> openDB() async {
    String path = join(await getDatabasesPath(), 'todo10.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE tasks(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            completed INTEGER DEFAULT 0
          )
        ''');
      },
    );
  }

  Future<void> addTask() async {
    if (taskController.text.trim().isEmpty) {
      return;
    }

    Database db = await openDB();

    await db.insert('tasks', {
      'title': taskController.text.trim(),
      'completed': 0,
    });

    await db.close();

    taskController.clear();
    loadTasks();
  }

  Future<void> loadTasks() async {
    Database db = await openDB();

    List<Map<String, dynamic>> data = await db.query('tasks');

    await db.close();

    setState(() {
      tasks = data;
    });
  }

  Future<void> updateTaskStatus(int id, bool completed) async {
    Database db = await openDB();

    await db.update(
      'tasks',
      {'completed': completed ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );

    await db.close();

    loadTasks();
  }

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  @override
  void dispose() {
    taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("To-Do Application")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: taskController,
              decoration: const InputDecoration(
                labelText: "Enter Task",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: addTask,
              child: const Text("Add Task"),
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  bool isCompleted = task['completed'] == 1;

                  return Card(
                    child: CheckboxListTile(
                      title: Text(
                        task['title'],
                        style: TextStyle(
                          decoration: isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      value: isCompleted,
                      onChanged: (value) {
                        updateTaskStatus(
                          task['id'],
                          value ?? false,
                        );
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

q11_registration_app.dart

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RegistrationScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() =>
      _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<Database> openDB() async {
    String path = join(await getDatabasesPath(), 'registration11.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            email TEXT,
            password TEXT
          )
        ''');
      },
    );
  }

  Future<void> registerUser() async {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    Database db = await openDB();

    await db.insert('users', {
      'name': nameController.text.trim(),
      'email': emailController.text.trim(),
      'password': passwordController.text,
    });

    await db.close();

    nameController.clear();
    emailController.clear();
    passwordController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Registration successful!")),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User Registration")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Full Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: registerUser,
              child: const Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}

q12_login_app.dart

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<Database> openDB() async {
    String path = join(await getDatabasesPath(), 'login12.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            email TEXT,
            password TEXT
          )
        ''');

        await db.insert('users', {
          'email': 'student@gmail.com',
          'password': '123456',
        });
      },
    );
  }

  Future<void> loginUser() async {
    Database db = await openDB();

    List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [
        emailController.text.trim(),
        passwordController.text,
      ],
    );

    await db.close();

    if (!mounted) return;

    if (result.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid email or password"),
        ),
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User Login")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: loginUser,
              child: const Text("Login"),
            ),
            const SizedBox(height: 10),
            const Text(
              "Demo Login:\nEmail: student@gmail.com\nPassword: 123456",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Screen")),
      body: const Center(
        child: Text(
          "Login Successful!\nWelcome to Home Screen",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}

q13_form_validation.dart

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RegistrationScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() =>
      _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<Database> openDB() async {
    String path = join(await getDatabasesPath(), 'validation13.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            email TEXT,
            password TEXT
          )
        ''');
      },
    );
  }

  Future<void> saveUser() async {
    if (formKey.currentState!.validate()) {
      Database db = await openDB();

      await db.insert('users', {
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'password': passwordController.text,
      });

      await db.close();

      nameController.clear();
      emailController.clear();
      passwordController.clear();

      formKey.currentState!.reset();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Record inserted successfully")),
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Form Validation")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter your name";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter your email";
                  }

                  if (!RegExp(
                    r'^[^@]+@[^@]+\.[^@]+$',
                  ).hasMatch(value.trim())) {
                    return "Enter a valid email";
                  }

                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter password";
                  }

                  if (value.length < 6) {
                    return "Password must be at least 6 characters";
                  }

                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: saveUser,
                child: const Text("Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

q14_student_navigation.dart

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: StudentListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DatabaseHelper {
  static Database? database;

  static Future<Database> getDB() async {
    if (database != null) {
      return database!;
    }

    String path = join(await getDatabasesPath(), 'students14.db');

    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE students(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            rollno TEXT,
            course TEXT
          )
        ''');
      },
    );

    return database!;
  }

  static Future<List<Map<String, dynamic>>> getStudents() async {
    Database db = await getDB();
    return db.query('students');
  }

  static Future<void> saveStudent(
    String name,
    String rollno,
    String course,
    int? id,
  ) async {
    Database db = await getDB();

    Map<String, dynamic> data = {
      'name': name,
      'rollno': rollno,
      'course': course,
    };

    if (id == null) {
      await db.insert('students', data);
    } else {
      await db.update(
        'students',
        data,
        where: 'id = ?',
        whereArgs: [id],
      );
    }
  }
}

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  List<Map<String, dynamic>> students = [];

  Future<void> loadStudents() async {
    List<Map<String, dynamic>> data =
        await DatabaseHelper.getStudents();

    setState(() {
      students = data;
    });
  }

  Future<void> openAddScreen() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddEditStudentScreen(),
      ),
    );

    loadStudents();
  }

  Future<void> openEditScreen(Map<String, dynamic> student) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditStudentScreen(student: student),
      ),
    );

    loadStudents();
  }

  @override
  void initState() {
    super.initState();
    loadStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Student List")),
      body: students.isEmpty
          ? const Center(child: Text("No students found"))
          : ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];

                return Card(
                  child: ListTile(
                    title: Text(student['name']),
                    subtitle: Text(
                      "Roll No: ${student['rollno']} | ${student['course']}",
                    ),
                    trailing: const Icon(Icons.edit),
                    onTap: () => openEditScreen(student),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: openAddScreen,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddEditStudentScreen extends StatefulWidget {
  final Map<String, dynamic>? student;

  const AddEditStudentScreen({super.key, this.student});

  @override
  State<AddEditStudentScreen> createState() =>
      _AddEditStudentScreenState();
}

class _AddEditStudentScreenState extends State<AddEditStudentScreen> {
  final nameController = TextEditingController();
  final rollController = TextEditingController();
  final courseController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.student != null) {
      nameController.text = widget.student!['name'];
      rollController.text = widget.student!['rollno'];
      courseController.text = widget.student!['course'];
    }
  }

  Future<void> saveStudent() async {
    if (nameController.text.isEmpty ||
        rollController.text.isEmpty ||
        courseController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    await DatabaseHelper.saveStudent(
      nameController.text.trim(),
      rollController.text.trim(),
      courseController.text.trim(),
      widget.student?['id'],
    );

    if (!mounted) return;
    Navigator.pop(context);
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
    bool isEditing = widget.student != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? "Edit Student" : "Add Student"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Student Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: rollController,
              decoration: const InputDecoration(
                labelText: "Roll Number",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: courseController,
              decoration: const InputDecoration(
                labelText: "Course",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveStudent,
              child: Text(isEditing ? "Update Student" : "Save Student"),
            ),
          ],
        ),
      ),
    );
  }
}

q15_product_inventory.dart

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: InventoryScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final nameController = TextEditingController();
  final quantityController = TextEditingController();
  final priceController = TextEditingController();

  List<Map<String, dynamic>> products = [];
  int? editingId;

  Future<Database> openDB() async {
    String path = join(await getDatabasesPath(), 'inventory15.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE products(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            quantity INTEGER,
            price REAL
          )
        ''');
      },
    );
  }

  Future<void> loadProducts() async {
    Database db = await openDB();
    List<Map<String, dynamic>> data = await db.query('products');
    await db.close();

    setState(() {
      products = data;
    });
  }

  Future<void> saveProduct() async {
    String name = nameController.text.trim();
    int? quantity = int.tryParse(quantityController.text);
    double? price = double.tryParse(priceController.text);

    if (name.isEmpty || quantity == null || price == null ||
        quantity < 0 || price < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter valid product details")),
      );
      return;
    }

    Database db = await openDB();

    Map<String, dynamic> data = {
      'name': name,
      'quantity': quantity,
      'price': price,
    };

    if (editingId == null) {
      await db.insert('products', data);
    } else {
      await db.update(
        'products',
        data,
        where: 'id = ?',
        whereArgs: [editingId],
      );
    }

    await db.close();

    clearForm();
    loadProducts();
  }

  void editProduct(Map<String, dynamic> product) {
    setState(() {
      editingId = product['id'];
      nameController.text = product['name'];
      quantityController.text = product['quantity'].toString();
      priceController.text = product['price'].toString();
    });
  }

  Future<void> deleteProduct(int id) async {
    Database db = await openDB();

    await db.delete(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );

    await db.close();

    loadProducts();
  }

  void clearForm() {
    setState(() {
      editingId = null;
      nameController.clear();
      quantityController.clear();
      priceController.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  @override
  void dispose() {
    nameController.dispose();
    quantityController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Product Inventory")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Product Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Quantity",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: priceController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: "Price",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: saveProduct,
                    child: Text(
                      editingId == null ? "Add Product" : "Update Product",
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: clearForm,
                  child: const Text("Clear"),
                ),
              ],
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];

                  return Card(
                    child: ListTile(
                      title: Text(product['name']),
                      subtitle: Text(
                        "Quantity: ${product['quantity']} | "
                        "Price: ₹${product['price']}",
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => editProduct(product),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () => deleteProduct(product['id']),
                          ),
                        ],
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

q16_shopping_cart.dart

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ShoppingCartScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({super.key});

  @override
  State<ShoppingCartScreen> createState() =>
      _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  final nameController = TextEditingController();
  final quantityController = TextEditingController();
  final priceController = TextEditingController();

  List<Map<String, dynamic>> cartItems = [];
  double totalPrice = 0;

  Future<Database> openDB() async {
    String path = join(await getDatabasesPath(), 'cart16.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE cart(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            quantity INTEGER,
            price REAL
          )
        ''');
      },
    );
  }

  Future<void> addToCart() async {
    String name = nameController.text.trim();
    int? quantity = int.tryParse(quantityController.text);
    double? price = double.tryParse(priceController.text);

    if (name.isEmpty ||
        quantity == null ||
        price == null ||
        quantity <= 0 ||
        price <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter valid item details")),
      );
      return;
    }

    Database db = await openDB();

    await db.insert('cart', {
      'name': name,
      'quantity': quantity,
      'price': price,
    });

    await db.close();

    nameController.clear();
    quantityController.clear();
    priceController.clear();

    loadCart();
  }

  Future<void> loadCart() async {
    Database db = await openDB();

    List<Map<String, dynamic>> data = await db.query('cart');

    List<Map<String, Object?>> result = await db.rawQuery(
      'SELECT SUM(quantity * price) AS total FROM cart',
    );

    double total =
        (result.first['total'] as num?)?.toDouble() ?? 0.0;

    await db.close();

    setState(() {
      cartItems = data;
      totalPrice = total;
    });
  }

  Future<void> removeItem(int id) async {
    Database db = await openDB();

    await db.delete(
      'cart',
      where: 'id = ?',
      whereArgs: [id],
    );

    await db.close();

    loadCart();
  }

  @override
  void initState() {
    super.initState();
    loadCart();
  }

  @override
  void dispose() {
    nameController.dispose();
    quantityController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Shopping Cart")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Product Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Quantity",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: priceController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: "Price per Item",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: addToCart,
              child: const Text("Add to Cart"),
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];

                  double itemTotal =
                      (item['quantity'] as int) *
                      (item['price'] as num).toDouble();

                  return Card(
                    child: ListTile(
                      title: Text(item['name']),
                      subtitle: Text(
                        "Quantity: ${item['quantity']} | "
                        "Price: ₹${item['price']}",
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "₹${itemTotal.toStringAsFixed(2)}",
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () => removeItem(item['id']),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Card(
              child: ListTile(
                title: const Text(
                  "Total Cart Price",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                trailing: Text(
                  "₹${totalPrice.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

q17_student_management.dart

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(const MyApp());
}

// Student Model
class Student {
  final int? id;
  final String name;
  final String email;
  final String course;

  Student({
    this.id,
    required this.name,
    required this.email,
    required this.course,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'course': course,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      course: map['course'],
    );
  }
}

// Database Helper
class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    String path = join(
      await getDatabasesPath(),
      'student_management17.db',
    );

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE students(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            email TEXT,
            course TEXT
          )
        ''');
      },
    );

    return _database!;
  }

  // Insert Student
  Future<int> insertStudent(Student student) async {
    Database db = await database;

    return await db.insert(
      'students',
      student.toMap(),
    );
  }

  // Get All Students
  Future<List<Student>> getStudents() async {
    Database db = await database;

    List<Map<String, dynamic>> data =
        await db.query('students');

    return data.map((map) => Student.fromMap(map)).toList();
  }

  // Update Student
  Future<int> updateStudent(Student student) async {
    Database db = await database;

    return await db.update(
      'students',
      student.toMap()..remove('id'),
      where: 'id = ?',
      whereArgs: [student.id],
    );
  }

  // Delete Student
  Future<int> deleteStudent(int id) async {
    Database db = await database;

    return await db.delete(
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
      title: "Student Management",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

// Home Screen
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Management System"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.school,
                size: 80,
                color: Colors.blue,
              ),
              const SizedBox(height: 20),
              const Text(
                "Welcome to Student Management System",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.person_add),
                  label: const Text("Add Student"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddStudentScreen(),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.list),
                  label: const Text("View Students"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const StudentListScreen(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Add Student Screen
class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({super.key});

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final courseController = TextEditingController();

  Future<void> saveStudent() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    Student student = Student(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      course: courseController.text.trim(),
    );

    await DatabaseHelper.instance.insertStudent(student);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Student added successfully"),
      ),
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    courseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Student")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Student Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter student name";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter email";
                  }

                  if (!RegExp(
                    r'^[^@]+@[^@]+\.[^@]+$',
                  ).hasMatch(value.trim())) {
                    return "Enter a valid email";
                  }

                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: courseController,
                decoration: const InputDecoration(
                  labelText: "Course",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter course";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: saveStudent,
                  child: const Text("Save Student"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Student List Screen
class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  List<Student> students = [];

  Future<void> loadStudents() async {
    List<Student> data =
        await DatabaseHelper.instance.getStudents();

    setState(() {
      students = data;
    });
  }

  Future<void> deleteStudent(Student student) async {
    bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Student"),
          content: Text(
            "Are you sure you want to delete ${student.name}?",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      await DatabaseHelper.instance.deleteStudent(student.id!);
      loadStudents();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Student deleted successfully"),
        ),
      );
    }
  }

  Future<void> openUpdateScreen(Student student) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateStudentScreen(student: student),
      ),
    );

    loadStudents();
  }

  @override
  void initState() {
    super.initState();
    loadStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Student List")),
      body: students.isEmpty
          ? const Center(
              child: Text("No student records found"),
            )
          : ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                Student student = students[index];

                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    title: Text(student.name),
                    subtitle: Text(
                      "Email: ${student.email}\n"
                      "Course: ${student.course}",
                    ),
                    isThreeLine: true,
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'edit') {
                          openUpdateScreen(student);
                        } else if (value == 'delete') {
                          deleteStudent(student);
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'edit',
                          child: Text("Edit"),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Text("Delete"),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddStudentScreen(),
            ),
          );

          loadStudents();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Update Student Screen
class UpdateStudentScreen extends StatefulWidget {
  final Student student;

  const UpdateStudentScreen({
    super.key,
    required this.student,
  });

  @override
  State<UpdateStudentScreen> createState() =>
      _UpdateStudentScreenState();
}

class _UpdateStudentScreenState extends State<UpdateStudentScreen> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final courseController = TextEditingController();

  @override
  void initState() {
    super.initState();

    nameController.text = widget.student.name;
    emailController.text = widget.student.email;
    courseController.text = widget.student.course;
  }

  Future<void> updateStudent() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    Student updatedStudent = Student(
      id: widget.student.id,
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      course: courseController.text.trim(),
    );

    await DatabaseHelper.instance.updateStudent(updatedStudent);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Student updated successfully"),
      ),
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    courseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Update Student")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Student Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter student name";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter email";
                  }

                  if (!RegExp(
                    r'^[^@]+@[^@]+\.[^@]+$',
                  ).hasMatch(value.trim())) {
                    return "Enter a valid email";
                  }

                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: courseController,
                decoration: const InputDecoration(
                  labelText: "Course",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter course";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: updateStudent,
                  child: const Text("Update Student"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}