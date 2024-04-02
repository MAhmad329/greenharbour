import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:green_harbour/constants.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        automaticallyImplyLeading: false,
        leadingWidth: 30,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.arrow_back_ios),
          ),
        ),
        backgroundColor: Colors.white,
        title: Container(
          height: 60.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15), // Shadow color
                spreadRadius: 0, // Spread radius
                blurRadius: 20, // Blur radius
                offset: const Offset(0, 0), // Offset in x and y directions
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: TextField(
                    enabled: true,
                    controller: searchController,
                    focusNode: searchFocusNode,
                    autofocus: true,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintStyle:
                            TextStyle(color: colorLightGrey, fontSize: 16),
                        hintText: "Search Postal Code"),
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    color: primaryGreen,
                    borderRadius: BorderRadius.circular(200),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      "assets/icons/search_icon.svg",
                      height: 22.h,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
