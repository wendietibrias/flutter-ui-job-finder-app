import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:job_finder_ui/controllers/home_controller.dart';
import 'package:job_finder_ui/core/app_color.dart';
import 'package:job_finder_ui/models/nearby_jobs_model.dart' as nearbyJobs;
import 'package:job_finder_ui/views/detail_job/detail_job_screen.dart';

class NearbyJobs extends StatefulWidget {
  const NearbyJobs({super.key});

  @override
  State<NearbyJobs> createState() => _NearbyJobsState();
}

class _NearbyJobsState extends State<NearbyJobs> {
  final HomeController controllerHome = HomeController();
  late Future<List<nearbyJobs.NearbyJobs>> nearbyJobsItems;

  @override
  void initState() {
    super.initState();
    nearbyJobsItems =
        controllerHome.fetchPopularJobs("React,Javascript,Nextjs");
  }

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Nearby Jobs',
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
                              fontWeight: FontWeight.w600,
                              color: HexColor(AppColor.gray))))),
            ]),
        SizedBox(height: 10),
        FutureBuilder<List<nearbyJobs.NearbyJobs>>(
            future: nearbyJobsItems,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                final List<nearbyJobs.NearbyJobs> items =
                    snapshot.data as List<nearbyJobs.NearbyJobs>;
                return Container(
                    width: double.infinity,
                    child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) =>
                            popularJobItems(items[index]),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemCount: items.length));
              } else {
                return CircularProgressIndicator(
                    strokeWidth: 2,
                    color: HexColor(AppColor.lightWhite),
                    backgroundColor: HexColor(AppColor.tertiary));
              }
            })
      ],
    );
  }

  InkWell popularJobItems(nearbyJobs.NearbyJobs item) {
    return InkWell(
        onTap: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      DetailJobScreen(jobId: item.jobId)));
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.network(
                    "https://t4.ftcdn.net/jpg/05/05/61/73/360_F_505617309_NN1CW7diNmGXJfMicpY9eXHKV4sqzO5H.jpg",
                    width: 60,
                    height: 60),
                SizedBox(width: 8),
                Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(item.jobTitle,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.dmSans(
                                  textStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: HexColor(AppColor.primary)))),
                          Text(item.jobType,
                              style: GoogleFonts.dmSans(
                                  textStyle: TextStyle(
                                      fontSize: 14,
                                      color: HexColor(AppColor.gray2))))
                        ]))
              ]),
          decoration: BoxDecoration(
              color: HexColor("#FFFFFF"),
              boxShadow: [
                BoxShadow(
                    blurRadius: 10,
                    spreadRadius: 4,
                    offset: Offset(0, 2),
                    color: HexColor(AppColor.white).withOpacity(.50)),
              ],
              borderRadius: BorderRadius.circular(8)),
        ));
  }
}
