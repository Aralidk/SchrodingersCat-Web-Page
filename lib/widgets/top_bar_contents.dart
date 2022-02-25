import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:schrodinger/screens/home_page.dart';
import 'package:schrodinger/utils/authentication.dart';
import 'package:schrodinger/widgets/auth_dialog.dart';
import 'package:flutter/material.dart';

class TopBarContents extends StatefulWidget {
  final double opacity;

  TopBarContents(this.opacity);

  @override
  _TopBarContentsState createState() => _TopBarContentsState();
}

class _TopBarContentsState extends State<TopBarContents> {
  final List _isHovering = [
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true
  ];

  bool _isProcessing = true;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return PreferredSize(
      preferredSize: Size(screenSize.width, 1000),
      child: Container(
        color: Theme.of(context).bottomAppBarColor.withOpacity(widget.opacity),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                //width: 550,
                //height: 350,
                child: Image.asset('images/anasayfalogo1.png', width: 500,),
              ),
              Row(children: [
                IconButton(
                  icon: Icon(Icons.brightness_6),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  color: Colors.red,
                  onPressed: () {
                    EasyDynamicTheme.of(context).changeTheme();
                  },
                ),
                SizedBox(
                  width: screenSize.width / 50,
                ),
                InkWell(
                  onHover: (value) {
                    setState(() {
                      value ? _isHovering[3] = true : _isHovering[3] = false;
                    });
                  },
                  onTap: userEmail == null
                      ? () {
                    showDialog(
                      context: context,
                      builder: (context) => AuthDialog(),
                    );
                  }
                      : null,
                  child: userEmail == null
                      ? Text(
                    'Giriş Yap',
                    style: TextStyle(
                      color: _isHovering[3] ? Colors.white : Colors.red,
                      fontSize: 20,
                    ),
                  )
                      : Row(
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundImage: imageUrl != null
                            ? NetworkImage(imageUrl!)
                            : null,
                        child: imageUrl == null
                            ? Icon(
                          Icons.account_circle,
                          size: 30,
                        )
                            : Container(),
                      ),
                      SizedBox(width: 5),
                      Text(
                        name ?? userEmail!,
                        style: TextStyle(
                          color: _isHovering[3]
                              ? Colors.white
                              : Colors.white70,
                        ),
                      ),
                      SizedBox(width: 10),
                      TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.blueGrey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: _isProcessing
                            ? null
                            : () async {
                          setState(() {
                            _isProcessing = true;
                          });
                          await signOut().then((result) {
                            print(result);
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                fullscreenDialog: true,
                                builder: (context) => HomePage(),
                              ),
                            );
                          }).catchError((error) {
                            print('Sign Out Error: $error');
                          });
                          setState(() {
                            _isProcessing = false;
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 8.0,
                            bottom: 8.0,
                          ),
                          child: _isProcessing
                              ? CircularProgressIndicator()
                              : Text(
                            'Sign out',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],)
            ],
          ),
        ),
      ),
    );

  }
}
