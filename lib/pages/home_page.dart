import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<List<dynamic>> toDoList = [
    ['Learn Web Development', false],
    ['Learn ReactJS', false],
  ];

  final TextEditingController _textEditingController = TextEditingController();
  int? _selectedIndex;

  void _addItem(String task) {
    setState(() {
      toDoList.add([task, false]);
    });
  }

  void _editItem(int index, String newTask) {
    setState(() {
      toDoList[index][0] = newTask;
    });
  }

  void _toggleCompletion(int index) {
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  void _deleteItem(int index) {
    setState(() {
      toDoList.removeAt(index);
      _selectedIndex = null; // Hide the buttons after deletion
    });
  }

  void _showEditDialog(int index) {
    _textEditingController.text = toDoList[index][0];
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Task'),
          content: TextField(
            controller: _textEditingController,
            autofocus: true,
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                _editItem(index, _textEditingController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showAddDialog() {
    _textEditingController.clear();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Task'),
          content: TextField(
            controller: _textEditingController,
            autofocus: true,
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                _addItem(_textEditingController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: const Text('Simple Todo List'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade400,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: 0,
            ),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = (_selectedIndex == index) ? null : index;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: toDoList[index][1]
                      ? Colors.green.shade400
                      : Colors.blue.shade400,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        toDoList[index][0],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          decoration: toDoList[index][1]
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                        softWrap: true,
                      ),
                    ),
                    Visibility(
                      visible: _selectedIndex == index,
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.white),
                            onPressed: () => _showEditDialog(index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.white),
                            onPressed: () => _deleteItem(index),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue.shade400,
      ),
    );
  }
}
