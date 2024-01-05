import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:job_finder_ui/core/app_color.dart';
import 'package:job_finder_ui/views/home/home_screen.dart';
import 'package:job_finder_ui/views/search/widget/search_job_result.dart';

class SearchScreen extends StatefulWidget {
  final String searchTerm;
  final String jobType;

  SearchScreen({super.key, required this.searchTerm, required this.jobType});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: TextButton(
          style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              backgroundColor: HexColor(AppColor.white),
              padding: EdgeInsets.zero,
              minimumSize: Size(36, 36)),
          child: Icon(FeatherIcons.arrowLeft,
              size: 22, color: HexColor(AppColor.primary)),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => HomeScreen()));
          },
        )),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.jobType != "" ? widget.jobType : widget.searchTerm,
                  style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: HexColor(AppColor.primary)))),
              SizedBox(height: 3),
              Text('Job Opportunities',
                  style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: HexColor(AppColor.secondary)))),
              SizedBox(height: 15),
              SearchJobResult(searchTerm: widget.searchTerm)
            ],
          ),
        ))));
  }
}
