import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:green_harbour/constants.dart';

Widget homeHeader(
    {required String imageUrl,
    required String username,
    required VoidCallback onTap}) {
  return Row(
    children: [
      GestureDetector(
        onTap: onTap,
        child: CircleAvatar(
          radius: 42,
          backgroundColor: primaryGreen.withOpacity(0.5),
          child: Center(
            child: imageUrl == '' || imageUrl == 'null'
                ? CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey.shade100,
                    child: Icon(
                      Icons.person,
                      size: 38,
                      color: primaryGreen.withOpacity(0.5),
                    ),
                  )
                : CircleAvatar(
                    radius: 40,
                    backgroundColor: primaryGreen,
                    child: CircleAvatar(
                      radius: 38,
                      backgroundColor: Colors.grey.shade100,
                      backgroundImage: NetworkImage(imageUrl),
                    ),
                  ),
          ),
        ),
      ),
      SizedBox(
        width: 10.w,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Hello!",
            style: TextStyle(
              color: colorGrey,
              fontSize: 20,
            ),
          ),
          Text(
            username,
            style: const TextStyle(
                color: colorBlack, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      )
    ],
  );
}

Widget searchBar({required VoidCallback onTap}) {
  return Container(
      height: 60.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15), // Shadow color
            spreadRadius: 0, // Spread radius
            blurRadius: 10, // Blur radius
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
                readOnly: true,
                onTap: onTap,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: colorLightGrey, fontSize: 16),
                    hintText: "Search Postal Code"),
              ),
            ),
          ),
          Container(
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
        ],
      ));
}
