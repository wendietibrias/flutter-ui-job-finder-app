import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:job_finder_ui/controllers/home_controller.dart';
import 'package:job_finder_ui/core/app_color.dart';
import 'package:job_finder_ui/models/popular_jobs_model.dart' as popularJobs;
import 'package:job_finder_ui/views/detail_job/detail_job_screen.dart';

class PopulerJobs extends StatefulWidget {
  const PopulerJobs({super.key});

  @override
  State<PopulerJobs> createState() => _PopulerJobsState();
}

class _PopulerJobsState extends State<PopulerJobs> {
  final HomeController controllerHome = HomeController();
  late Future<List<popularJobs.PopularJobs>> jobsItem;

  @override
  void initState() {
    super.initState();
    jobsItem = controllerHome.fetchNearbyJobs();
  }

  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Popular Jobs',
                    style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: HexColor(AppColor.primary)))),
                TextButton(
                    onPressed: () {},
                    child: Text('Show all',
                        style: GoogleFonts.dmSans(
                            textStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: HexColor(AppColor.gray))))),
              ]),
          const SizedBox(height: 10),
          FutureBuilder<List<popularJobs.PopularJobs>>(
              future: jobsItem,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  final List<popularJobs.PopularJobs> items =
                      snapshot.data as List<popularJobs.PopularJobs>;
                  return Container(
                      height: 180,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, index) =>
                              popularJobItems(items[index]),
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 12),
                          itemCount: items.length));
                } else {
                  return CircularProgressIndicator(
                      color: HexColor(AppColor.lightWhite),
                      strokeWidth: 2,
                      backgroundColor: HexColor(AppColor.tertiary));
                }
              })
        ]);
  }

  InkWell popularJobItems(popularJobs.PopularJobs item) {
    return InkWell(
        onTap: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return DetailJobScreen(jobId: item.jobId);
          }));
        },
        child: Container(
          width: 270,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    width: 42,
                    height: 42,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: HexColor(AppColor.lightWhite),
                    ),
                    child: Center(
                      child: Image.network(
                        "https://t4.ftcdn.net/jpg/05/05/61/73/360_F_505617309_NN1CW7diNmGXJfMicpY9eXHKV4sqzO5H.jpg",
                        fit: BoxFit.cover,
                      ),
                    )),
                SizedBox(height: 5),
                Text(item.employerName,
                    style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                            fontSize: 14, color: HexColor(AppColor.gray2)))),
                SizedBox(height: 12),
                Text(item.jobTitle,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: HexColor(AppColor.primary)))),
                Text(item.jobCountry,
                    style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                            fontSize: 14, color: HexColor(AppColor.gray2)))),
              ]),
          decoration: BoxDecoration(
              color: HexColor("#FFFFFF"),
              boxShadow: [
                BoxShadow(
                    blurRadius: 10,
                    spreadRadius: 4,
                    offset: Offset(0, 2),
                    color: HexColor(AppColor.white).withOpacity(.70)),
              ],
              borderRadius: BorderRadius.circular(8)),
        ));
  }
}
