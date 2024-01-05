import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:job_finder_ui/controllers/home_controller.dart';
import 'package:job_finder_ui/controllers/search_job_controller.dart';
import 'package:job_finder_ui/core/app_color.dart';
import 'package:job_finder_ui/models/nearby_jobs_model.dart';
import 'package:job_finder_ui/views/detail_job/detail_job_screen.dart';

class SearchJobResult extends StatefulWidget {
  final String searchTerm;

  const SearchJobResult({super.key, required this.searchTerm});

  @override
  State<SearchJobResult> createState() => _SearchJobResultState();
}

class _SearchJobResultState extends State<SearchJobResult> {
  late Future<List<NearbyJobs>> searchResult;
  SearchJobController searchJobController = SearchJobController();

  @override
  void initState() {
    super.initState();
    searchResult = searchJobController.fetchSearchJob(
        searchTerm: widget.searchTerm, jobType: "");
  }

  Widget build(BuildContext context) {
    return FutureBuilder<List<NearbyJobs>>(
        future: searchResult,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            final List<NearbyJobs> items = snapshot.data as List<NearbyJobs>;
            return Container(
                width: double.infinity,
                child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) =>
                        searchJobItems(items[index]),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemCount: items.length));
          } else {
            return Center(
                child: CircularProgressIndicator(
                    color: HexColor(AppColor.lightWhite),
                    strokeWidth: 2,
                    backgroundColor: HexColor(AppColor.tertiary)));
          }
        });
  }

  InkWell searchJobItems(NearbyJobs item) {
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
