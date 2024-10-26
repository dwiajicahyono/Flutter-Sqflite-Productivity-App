import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ActivityDetail extends StatefulWidget {
  final String idActivity;
  const ActivityDetail({super.key, required this.idActivity});

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
          style: GoogleFonts.syne(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: const Color(0xffF9F9F9),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.idActivity,
                style: GoogleFonts.syne(
                    color: const Color(0xff1E1E1E),
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
      ),
    );
  }
}
