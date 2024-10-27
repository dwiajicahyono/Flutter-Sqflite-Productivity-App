import 'package:flutter/material.dart';
import 'package:productivity_app/models/db_activity.dart';
import 'package:productivity_app/helpers/db_activity_helper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:productivity_app/screens/activity_detail.dart';
import 'package:productivity_app/helpers/colors_helper.dart';
import 'package:productivity_app/components/chart_ui.dart';

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

  Future<void> _deleteActivity(int id) async {
    await dbACtivityHelper.deleteDataActivity(id);
    _loadActivities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Productivity App',
          style: GoogleFonts.syne(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: AppColors.barColor),
        ),
      ),
      backgroundColor: const Color(0xffF9F9F9),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'Activity',
                style: GoogleFonts.syne(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.titleColor),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              // height: 232,
              width: double.infinity,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: const Offset(7, 1),
                  ),
                ],
                borderRadius: BorderRadius.circular(12),
                color: AppColors.backgroundColor,
              ),
              // child: Text(
              //   'grafik',
              //   style:
              //       GoogleFonts.syne(fontSize: 24, fontWeight: FontWeight.bold),
              // ),
              child: BarChartSample(),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tasks',
                    style: GoogleFonts.syne(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.titleColor),
                  ),
                  IconButton(
                      onPressed: addActivity,
                      icon: const Icon(
                        size: 25,
                        Icons.add_circle_outline_outlined,
                        color: Color.fromARGB(255, 60, 175, 114),
                      )),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            taskList()
          ],
        ),
      ),
    );
  }

  Expanded taskList() {
    return Expanded(
      child: ListView.builder(
        itemCount: activities.length,
        itemBuilder: (context, index) {
          final activity = activities[index];
          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 0,
                  blurRadius: 10,
                  offset: const Offset(7, 1),
                ),
              ],
              borderRadius:
                  BorderRadius.circular(12), // Menambahkan border radius
            ),
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: ListTile(
              title: Text(
                activity.title,
                style: GoogleFonts.syne(
                    fontSize: 20, color: const Color(0xff1E1E1E)),
              ),
              // subtitle: Text(activity.description),
              trailing: PopupMenuButton(
                color: Colors.white,
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      value: '/hello',
                      child: IconButton(
                          onPressed: () => _deletePopup(activity.id!),
                          icon: Row(
                            children: [
                              const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              const SizedBox(width: 8.0),
                              Text(
                                'Delete',
                                style: GoogleFonts.syne(
                                    fontSize: 16,
                                    color: Colors.red,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          )),
                    ),
                    PopupMenuItem(
                      child: IconButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ActivityDetail(
                                      title: activity.title,
                                      description: activity.description))),
                          icon: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.info_outline,
                                color: Colors.blue,
                              ),
                              const SizedBox(width: 8.0),
                              Text(
                                'Info',
                                style: GoogleFonts.syne(
                                    fontSize: 16,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          )),
                    ),
                  ];
                },
              ),
              // trailing: IconButton(
              //     onPressed: () => _deletePopup(activity.id!),
              //     // onPressed: () => _deleteActivity(activity.id!),
              //     icon: const Icon(Icons.delete)),
            ),
          );
        },
      ),
    );
  }

  Future<void> _deletePopup(int idActivity) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Delete Activity'),
            content:
                const Text('Are you sure you want to delete this activity?'),
            actions: [
              ElevatedButton(
                  onPressed: () async {
                    await _deleteActivity(idActivity);

                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Activity deleted successfully"),
                        duration: Duration(seconds: 3),
                        backgroundColor: Colors.green,
                      ));
                    }

                    if (context.mounted) {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                      // Navigator.of(context).pop();
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text(
                    "Yes",
                    style: TextStyle(color: Colors.white),
                  )),
              ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Cancel"))
            ],
          );
        });
  }

  Future<void> addActivity() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add Activity'),
            content: SizedBox(
              height: 150,
              child: Column(
                mainAxisSize: MainAxisSize
                    .min, // Ensures the column only takes the necessary space
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                    ),
                  ),
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                    ),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                  ),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Cancel")),
              ElevatedButton(
                  onPressed: () async {
                    await _addActivity();
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Activity Add successfully"),
                        duration: Duration(seconds: 3),
                        backgroundColor: Colors.green,
                      ));
                    }

                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: const Text(
                    "Yes",
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          );
        });
  }
}
