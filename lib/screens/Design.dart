import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:schrodinger/widgets/responsive.dart';
import 'package:schrodinger/widgets/top_bar_contents.dart';
import 'package:schrodinger/widgets/web_scrollbar.dart';
import 'package:flutter/material.dart';
import '../widgets/bottom_bar.dart';
import '../widgets/drawer.dart';
import '../widgets/floating_quick_access_bar.dart';

class Design extends StatefulWidget {
  static const String route = '/';

  @override
  _Design createState() => _Design();
}

class _Design extends State<Design> {
  late ScrollController _scrollController;
  double _scrollPosition = 0;
  double _opacity = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: ResponsiveWidget.isSmallScreen(context)
          ? AppBar(
        backgroundColor:
        Theme.of(context).bottomAppBarColor.withOpacity(_opacity),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              EasyDynamicTheme.of(context).changeTheme();
            },
          ),
        ],
        title: Text(
          'Design',
          style: TextStyle(
            color: Colors.blueGrey[100],
            fontSize: 20,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w400,
            letterSpacing: 3,
          ),
        ),
      )
          : PreferredSize(
        preferredSize: Size(screenSize.width, 1000),
        child: TopBarContents(_opacity),
      ),
      drawer: ExploreDrawer(),
      body: WebScrollbar(
        color: Colors.blueGrey,
        backgroundColor: Colors.blueGrey.withOpacity(0.3),
        width: 10,
        heightFraction: 0.3,
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: ClampingScrollPhysics(),
          child: Column(
            children: [
              Stack(
                children: [
                  Column(
                    children: [
                      FloatingQuickAccessBar(screenSize: screenSize),
                      Container(
                        child: Column(
                          children: [
                            Padding(padding: EdgeInsets.all(15)),
                            Container(
                              width: screenSize.width / 3,
                              child: Image.asset("assets/images/1.jpg"),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: screenSize.height / 10),
              BottomBar(),
            ],
          ),
        ),
      ),
    );
  }
}
