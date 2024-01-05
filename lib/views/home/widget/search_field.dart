import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:job_finder_ui/core/app_color.dart';
import 'package:job_finder_ui/views/search/search_screen.dart';

class SearchField extends StatefulWidget {
  const SearchField({super.key});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Container(
        child: Row(children: [
      Flexible(
          flex: 1,
          child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: HexColor(AppColor.white),
                  borderRadius: BorderRadius.circular(12)),
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                      prefixIconColor: HexColor(AppColor.lightWhite),
                      fillColor: HexColor(AppColor.gray2),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: "What are you looking for?",
                      hintStyle: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: HexColor(AppColor.gray))))))),
      SizedBox(width: 7),
      IconButton(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return SearchScreen(
                  searchTerm: _controller.value.text, jobType: "");
            }));
          },
          style: IconButton.styleFrom(
              padding: EdgeInsets.all(9),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              backgroundColor: HexColor(AppColor.tertiary)),
          icon: Icon(FeatherIcons.search, color: HexColor(AppColor.white)))
    ]));
  }
}
