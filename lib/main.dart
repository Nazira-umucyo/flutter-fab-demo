import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FAB Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const NotesPage(),
    );
  }
}

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final List<String> _notes = [];
  final TextEditingController _controller = TextEditingController();

  // Opens a dialog to add a new note
  void _showAddNoteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New Note'),
        content: TextField(
          controller: _controller,
          decoration: const InputDecoration(hintText: 'Type your note here...'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _controller.clear();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_controller.text.trim().isNotEmpty) {
                setState(() {
                  _notes.add(_controller.text.trim());
                });
                _controller.clear();
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: _notes.isEmpty
          ? const Center(
              child: Text(
                'No notes yet.\nTap + to add one.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _notes.length,
              itemBuilder: (context, index) => Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: const Icon(Icons.note, color: Colors.indigo),
                  title: Text(_notes[index]),
                ),
              ),
            ),

      // ✅ FloatingActionButton — the widget being presented
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddNoteDialog,

        // Property 1: backgroundColor — changes the button's fill color
        backgroundColor: Colors.indigo,

        // Property 2: tooltip — shows a hint label on long press
        tooltip: 'Add a new note',

        // Property 3: elevation — controls the shadow depth beneath the button
        elevation: 8.0,

        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}