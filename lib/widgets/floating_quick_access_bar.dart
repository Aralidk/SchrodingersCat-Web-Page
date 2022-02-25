import 'package:schrodinger/widgets/responsive.dart';
import 'package:flutter/material.dart';
import '../screens/software.dart';
import 'package:schrodinger/screens/Game.dart';
import 'package:schrodinger/screens/Design.dart';
import 'package:schrodinger/screens/Portfolyo.dart';

class FloatingQuickAccessBar extends StatefulWidget {
  const FloatingQuickAccessBar({
    Key? key,
    required this.screenSize,
  }) : super(key: key);
  final Size screenSize;

  @override
  _FloatingQuickAccessBarState createState() => _FloatingQuickAccessBarState();
}

class _FloatingQuickAccessBarState extends State<FloatingQuickAccessBar> {
  List _isHovering = [false, false, false, false];
  List<Widget> rowElements = [];
  List<Widget> pageRoute = [SoftWare(), Game(), Design(),Portfolyo()];

  List<String> items = ['Yazılım', 'Tasarım', 'Oyun', 'Portfolyo'];
  List<IconData> icons = [
    Icons.code,
    Icons.design_services,
    Icons.videogame_asset,
    Icons.person
  ];

  List<Widget> generateRowElements() {
    rowElements.clear();
    for (int i = 0; i < items.length; i++) {
      Widget elementTile = InkWell(
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onHover: (value) {
          setState(() {
            value ? _isHovering[i] = true : _isHovering[i] = false;
          });
        },
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => pageRoute[i]),
          );
        },
        child: Text(
          items[i],
          style: TextStyle(
            color: _isHovering[i]
                ? Theme.of(context).primaryTextTheme.button!.decorationColor
                : Theme.of(context).primaryTextTheme.button!.color,
          ),
        ),
      );
      Widget spacer = SizedBox(
        height: widget.screenSize.height / 20,
        child: VerticalDivider(
          width: 1,
          color: Colors.blueGrey[100],
          thickness: 1,
        ),
      );
      rowElements.add(elementTile);
      if (i < items.length - 1) {
        rowElements.add(spacer);
      }
    }

    return rowElements;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      heightFactor: 1,
      child: Padding(
        padding: EdgeInsets.only(
          top: widget.screenSize.height * 0.40,
          left: ResponsiveWidget.isSmallScreen(context)
              ? widget.screenSize.width / 12
              : widget.screenSize.width / 5,
          right: ResponsiveWidget.isSmallScreen(context)
              ? widget.screenSize.width / 12
              : widget.screenSize.width / 5,
        ),
        child: ResponsiveWidget.isSmallScreen(context)
            ? Column(
          children: [
            ...Iterable<int>.generate(items.length).map(
                  (int pageIndex) => Padding(
                padding:
                EdgeInsets.only(top: widget.screenSize.height / 80),
                child: Card(
                  color: Theme.of(context).cardColor,
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: widget.screenSize.height / 45,
                        bottom: widget.screenSize.height / 45,
                        left: widget.screenSize.width / 20),
                    child:
                    Row(
                      children: [
                        Icon(
                          icons[pageIndex],
                          color: Theme.of(context).iconTheme.color,
                        ),
                        SizedBox(width: widget.screenSize.width / 20),
                        InkWell(
                          splashColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          onHover: (value) {},
                          onTap: () {
                            for (int i = 0; i < items.length; i++)
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => pageRoute[i] ));
                          },
                          child: Text(
                            items[pageIndex],
                            style: TextStyle(
                                color: Theme.of(context)
                                    .primaryTextTheme
                                    .button!
                                    .color,
                                fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
            : Card(
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.only(
              top: widget.screenSize.height / 50,
              bottom: widget.screenSize.height / 50,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: generateRowElements(),
            ),
          ),
        ),
      ),
    );
  }
}

