import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:job_finder_ui/core/app_color.dart';
import 'package:job_finder_ui/views/home/widget/categories_widget.dart';
import 'package:job_finder_ui/views/home/widget/nearby_jobs_widget.dart';
import 'package:job_finder_ui/views/home/widget/popular_jobs_widget.dart';
import 'package:job_finder_ui/views/home/widget/search_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor(AppColor.lightWhite),
        appBar: AppBar(
            title: const Icon(FeatherIcons.menu, size: 22),
            backgroundColor: Colors.transparent,
            bottomOpacity: 0.0,
            elevation: 0.0,
            // New parameter:
            scrolledUnderElevation: 0,
            actions: [
              Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Container(
                      width: 46,
                      height: 46,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Image.asset('assets/images/person.jpg',
                          fit: BoxFit.cover)))
            ]),
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Hello Steffi',
                          style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                  fontSize: 18,
                                  color: HexColor(AppColor.secondary),
                                  fontWeight: FontWeight.w500))),
                      Text('Find your pefect job',
                          style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: HexColor(AppColor.primary)))),
                      const SizedBox(height: 20),
                      const SearchField(),
                      const SizedBox(height: 18),
                      const CategoryList(),
                      const SizedBox(height: 14),
                      const PopulerJobs(),
                      const SizedBox(height: 14),
                      const NearbyJobs()
                    ])),
          ),
        ));
  }
}
