import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:job_finder_ui/core/app_color.dart';
import 'package:job_finder_ui/models/detail_job_model.dart';

class RequirementJobDetail extends StatelessWidget {
  final String menuType;
  final DetailJobModel detailJob;

  const RequirementJobDetail(
      {super.key, required this.menuType, required this.detailJob});

  @override
  Widget build(BuildContext context) {
    switch (menuType) {
      case "about":
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("About the Job : ",
                  style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: HexColor(AppColor.primary)))),
              SizedBox(height: 12),
              Text(detailJob.jobDescription,
                  style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: HexColor(AppColor.secondary))))
            ]);
        break;
      case "responsibilities":
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Job Responsibilities: ",
                  style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: HexColor(AppColor.primary)))),
              SizedBox(height: 12),
              listDataRequirement(detailJob.jobResponsibilities)
            ]);
        break;
      case "benefits":
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Job Benefits: ",
                  style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: HexColor(AppColor.primary)))),
              SizedBox(height: 12),
              listDataRequirement(detailJob.jobBenefits)
            ]);
        break;
      case "qualitifications":
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Job Qualifications: ",
                  style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: HexColor(AppColor.primary)))),
              SizedBox(height: 12),
              listDataRequirement(detailJob.jobQualifications)
            ]);
        break;
      default:
        return Container(child: const Text('Invalid data'));
    }
  }

  ListView listDataRequirement(List<dynamic> lists) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: lists.length,
      shrinkWrap: true,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (BuildContext context, int index) {
        return Text("* ${lists[index]}",
            style: GoogleFonts.dmSans(
                textStyle: TextStyle(
                    fontSize: 13,
                    color: HexColor(AppColor.gray),
                    fontWeight: FontWeight.w500)));
      },
    );
  }
}
