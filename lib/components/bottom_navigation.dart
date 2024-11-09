import 'package:flutter/material.dart';
import 'package:productivity_app/screens/dashboard.dart';
import 'package:productivity_app/screens/pomodoro_page.dart';
import 'package:productivity_app/helpers/colors_helper.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  // ignore: unused_field
  int _selectedTabIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  static final List<Widget> _widgetOptions = <Widget>[
    const Dashboard(),
    const PomodoroPage(),
  ];

  void _onPagechanged(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPagechanged,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buildBottonNavigation(
                index: 0, label: 'Dashboard', icon: Icons.home_outlined),
            _buildBottonNavigation(
                index: 2, label: 'Timer', icon: Icons.watch_later_outlined),
          ],
        ),
      ),
    );
  }

  Widget _buildBottonNavigation(
      {required int index, required String label, required IconData icon}) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        _onItemTapped(index);
      },
      child: Column(
        children: [
          Icon(
            icon,
            color: AppColors.titleColor,
            size: 25,
          ),
          Text(
            label,
            style: GoogleFonts.syne(fontSize: 12),
          )
        ],
      ),
    );
  }
}
