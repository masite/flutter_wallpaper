import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    _changeStatus();
    return Container(
      color: Colors.white,
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: <Widget>[
          Positioned(
              right: 20,
              top: 60,
              child: GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Image.asset("assets/images/icon_close.webp"),
              )),
          Positioned(top: 140, child: Image.asset("assets/images/logo.png")),
          Positioned(
            top: 200,
            child: Text(
              "neets壁纸",
              style: TextStyle(
                  color: Color(int.parse("0xff666666")),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.none),
            ),
          ),
          Positioned(
            top: 230,
            child: Text(
              "v1.0.0",
              style: TextStyle(
                  color: Color(int.parse("0xff666666")),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.none),
            ),
          ),
          Positioned(
            top: 255,
            child: Text(
              "精选原创个性模板，快来打造你的专属小刘海吧！",
              style: TextStyle(
                  color: Color(int.parse("0xff666666")),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.none),
            ),
          ),
          Positioned(
            top: 310,
            left: 20,
            child: Text(
              "联系我们",
              style: TextStyle(
                  color: Color(int.parse("0xff666666")),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.none),
            ),
          ),
          Positioned(
            top: 310,
            right: 20,
            child: Image.asset("assets/images/icon_forward.webp"),
          ),
          Positioned(
            top: 340,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 20,
              child: Divider(
                height: 10.0,
                indent: 20.0,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _changeStatus() {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}
