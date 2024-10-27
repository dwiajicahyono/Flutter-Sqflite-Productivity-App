import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:productivity_app/helpers/colors_helper.dart';

class ActivityDetail extends StatefulWidget {
  final String title;
  final String description;
  const ActivityDetail(
      {super.key, required this.title, required this.description});

  @override
  State<ActivityDetail> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ActivityDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Activity Detail',
          style: GoogleFonts.syne(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: AppColors.barColor),
        ),
        // backgroundColor: const Color(0xff8CF2BB),
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.barColor,
      ),
      backgroundColor: const Color(0xffF9F9F9),
      body: SafeArea(
        child: Container(
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
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  widget.title,
                  style: GoogleFonts.syne(
                      color: const Color.fromARGB(255, 89, 215, 148),
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.description,
                style: GoogleFonts.syne(
                    color: const Color(0xff1E1E1E),
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
      ),
    );
  }
}
