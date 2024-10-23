import 'package:flutter/material.dart';
import 'package:productivity_app/models/db_activity.dart';
import 'package:productivity_app/helpers/db_activity_helper.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final DbActivityHelper dbACtivityHelper = DbActivityHelper();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  List<Activity> activities = [];

  String counter = '';

  @override
  void initState() {
    super.initState();
    _loadActivities();
  }

  Future<void> _loadActivities() async {
    List<Activity> activitiesList = await dbACtivityHelper.getAllDataActivity();
    setState(() {
      activities = activitiesList;
    });
  }

  Future<void> _addActivity() async {
    final String title = titleController.text;
    final String description = descriptionController.text;

    if (title.isNotEmpty && description.isNotEmpty) {
      Activity activity = Activity(title: title, description: description);

      await dbACtivityHelper.insertDataActivity(activity);
      titleController.clear();
      descriptionController.clear();
      _loadActivities();
    }
  }

  void _incrementCounter() {
    setState(() {
      counter = 'Hello World';
    });
  }

  Future<void> _deleteActivity(int id) async {
    await dbACtivityHelper.deleteDataActivity(id);
    _loadActivities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productivity App'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _addActivity,
              child: const Text('Add'),
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: activities.length,
              itemBuilder: (context, index) {
                final activity = activities[index];
                return ListTile(
                  title: Text(activity.title),
                  subtitle: Text(activity.description),
                  trailing: IconButton(
                      onPressed: () => _deletePopup(activity.id!),
                      // onPressed: () => _deleteActivity(activity.id!),
                      icon: Icon(Icons.delete)),
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _deletePopup(int idActivity) async {
    print(idActivity);
    // showDialog(context: context, builder: );
  }
}
