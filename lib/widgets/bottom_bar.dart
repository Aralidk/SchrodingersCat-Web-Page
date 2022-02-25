import 'package:schrodinger/widgets/bottom_bar_column.dart';
import 'package:schrodinger/widgets/info_text.dart';
import 'package:schrodinger/widgets/responsive.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      color: Theme.of(context).bottomAppBarColor,
      child: ResponsiveWidget.isSmallScreen(context)
          ? Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BottomBarColumn(
                heading: 'İletişim',
                s1: 'dilaraakuzeyyy@gmail.com',
                //s2: 'About Us',
                //s3: 'Careers',
              ),
              BottomBarColumn(
                heading: 'Sosyal Medya',
                s1: 'Linkedin',
                //s2: 'Facebook',
                //s3: 'YouTube',
              ),
            ],
          ),
          Container(
            color: Colors.blueGrey,
            width: double.maxFinite,
            height: 1,
          ),
          SizedBox(height: 20),
          Container(
            color: Colors.blueGrey,
            width: double.maxFinite,
            height: 1,
          ),
        ],
      )
          : Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BottomBarColumn(
                heading: 'İletişim',
                s1: 'dilaraakuzeyyy@gmail.com',
              ),

              BottomBarColumn(
                heading: 'Sosyal Medya',
                s1: 'Linkedin',
              ),
              Container(
                color: Colors.blueGrey,
                width: 2,
                height: 150,
              ),
            ],
          ),

        ],
      ),
    );
  }
}
