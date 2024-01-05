import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:job_finder_ui/controllers/detail_job_controller.dart';
import 'package:job_finder_ui/core/app_color.dart';
import 'package:job_finder_ui/models/detail_job_menu_model.dart';
import 'package:job_finder_ui/models/detail_job_model.dart';
import 'package:job_finder_ui/views/detail_job/widget/requirement_job_widget.dart';
import 'package:job_finder_ui/views/home/home_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailJobScreen extends StatefulWidget {
  final String jobId;

  DetailJobScreen({super.key, required this.jobId});

  @override
  State<DetailJobScreen> createState() => _DetailJobScreenState();
}

class _DetailJobScreenState extends State<DetailJobScreen> {
  final DetailJobController detailJobController = DetailJobController();
  late Future<DetailJobModel> jobDetail;
  int _currentIndex = 0;
  bool _isLoading = false;
  String menuType = "about";

  @override
  void initState() {
    super.initState();
    jobDetail = detailJobController.fetchDetailJob(widget.jobId);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: _isLoading
            ? Container(
                child: SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                      backgroundColor: HexColor(AppColor.tertiary),
                    )))
            : Container(
                height: 70,
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: <Widget>[
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 13),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            side: BorderSide(
                                width: 1.2,
                                color: HexColor(AppColor.tertiary))),
                        onPressed: () {},
                        child: Icon(FeatherIcons.heart,
                            size: 26, color: HexColor(AppColor.tertiary))),
                    SizedBox(width: 15),
                    Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: TextButton(
                            onPressed: () {},
                            child: Text('Apply for Job',
                                style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        color: HexColor(AppColor.white),
                                        fontWeight: FontWeight.w700))),
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                backgroundColor: HexColor(AppColor.tertiary))))
                  ],
                )),
        appBar: AppBar(
          bottomOpacity: 0.0,
          elevation: 0.0,
          // New parameter:
          scrolledUnderElevation: 0,
          backgroundColor: HexColor(AppColor.lightWhite),
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
          ),
          actions: [
            Padding(
                padding: EdgeInsets.only(right: 15),
                child: TextButton(
                    style: TextButton.styleFrom(
                        minimumSize: Size(36, 36),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        padding: EdgeInsets.zero,
                        backgroundColor: HexColor(AppColor.white)),
                    child: Icon(FeatherIcons.share,
                        size: 22, color: HexColor(AppColor.primary)),
                    onPressed: () {}))
          ],
        ),
        body: FutureBuilder<DetailJobModel>(
            future: jobDetail,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final detailJobData = snapshot.data as DetailJobModel;
                return SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                                alignment: Alignment.center,
                                child: Column(children: [
                                  Image.network(detailJobData.employerLogo,
                                      width: 110,
                                      height: 110,
                                      fit: BoxFit.contain),
                                  SizedBox(height: 8),
                                  Text(detailJobData.jobTitle,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.dmSans(
                                          textStyle: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              color:
                                                  HexColor(AppColor.primary)))),
                                  SizedBox(height: 6),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(detailJobData.employerName,
                                            style: GoogleFonts.dmSans(
                                                textStyle: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w500,
                                                    color: HexColor(
                                                        AppColor.secondary)))),
                                        Text(" / "),
                                        Text(detailJobData.jobCountry,
                                            style: GoogleFonts.dmSans(
                                                textStyle: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w500,
                                                    color: HexColor(
                                                        AppColor.secondary))))
                                      ])
                                ])),
                            SizedBox(height: 16),
                            Container(
                                height: 40,
                                child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) =>
                                        ButtonMenuItem(
                                            jobDetailMenu[index], index),
                                    separatorBuilder: (context, index) =>
                                        SizedBox(width: 10),
                                    itemCount: jobDetailMenu.length)),
                            SizedBox(height: 16),
                            RequirementJobDetail(
                                menuType: menuType, detailJob: detailJobData)
                          ]),
                    ),
                  ),
                );
              } else {
                return Center(
                    child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: HexColor(AppColor.lightWhite),
                        backgroundColor: HexColor(AppColor.tertiary)));
              }
            }));
  }

  TextButton ButtonMenuItem(DetailJobMenuModel item, int index) {
    return TextButton(
      style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 18),
          backgroundColor: index == _currentIndex
              ? HexColor(AppColor.primary)
              : HexColor(AppColor.white),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      child: Text(item.title,
          style: GoogleFonts.dmSans(
              textStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: index == _currentIndex
                      ? HexColor(AppColor.lightWhite)
                      : HexColor(AppColor.secondary)))),
      onPressed: () {
        setState(() {
          menuType = item.title.toLowerCase();
          _currentIndex = index;
        });
      },
    );
  }

  Future<void> _launchUrl(String uri) async {
    if (!await launchUrl(Uri.parse(uri))) {
      throw Exception('Could not launch $uri');
    }
  }
}
