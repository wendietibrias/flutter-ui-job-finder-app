import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:job_finder_ui/core/app_color.dart';
import 'package:job_finder_ui/models/categories_model.dart';
import 'package:job_finder_ui/views/search/search_screen.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 36,
        child: ListView.separated(
          itemCount: categories.length,
          separatorBuilder: (context, index) => const SizedBox(width: 12),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) =>
              categoryItem(categories[index], index),
        ));
  }

  OutlinedButton categoryItem(Categories category, int index) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          side: BorderSide(
              width: 1.5,
              color: _currentIndex == index
                  ? HexColor(AppColor.secondary)
                  : HexColor(AppColor.gray2)),
        ),
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return SearchScreen(
                searchTerm: "Developer", jobType: category.value);
          }));
          setState(() {
            _currentIndex = index;
          });
        },
        child: Text(category.title,
            style: GoogleFonts.dmSans(
                textStyle: _currentIndex == index
                    ? TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        color: HexColor(AppColor.secondary))
                    : TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        color: HexColor(AppColor.gray)))));
  }
}
