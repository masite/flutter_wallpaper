import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:toast/toast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_view_indicator/page_view_indicator.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File _image;

  GlobalKey rootWidgetKey = GlobalKey();
  List<Uint8List> images = List();
  bool visible;
  bool visibleStyle;
  bool visiblePre;

  List<String> imgTypeList = List();
  int selectIndex = 0;
  String selectImg = "assets/images/custom_wall_figure1.webp";

  int selectType = 0;

  //viewpager
  final pageIndexNotifier = ValueNotifier<int>(0);

  List<String> imgReviews = List();


  @override
  void reassemble() {
    print("reassemble");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    visible = true;
    visibleStyle = false;
    visiblePre = false;
    _setFlowSource();
    imgReviews.add("assets/images/item_review_fround_close.webp");
    imgReviews.add("assets/images/item_review_fround.webp");
  }

  void _setFlowSource() {
    imgTypeList.clear();
    imgTypeList.add("assets/images/custom_wall_figure1.webp");
    imgTypeList.add("assets/images/custom_wall_figure2.webp");
    imgTypeList.add("assets/images/custom_wall_figure3.webp");
    imgTypeList.add("assets/images/custom_wall_figure4.webp");
    imgTypeList.add("assets/images/custom_wall_figure5.webp");
    imgTypeList.add("assets/images/custom_wall_figure6.webp");
    imgTypeList.add("assets/images/custom_wall_figure7.webp");

    selectImg = imgTypeList[0];
    selectType = 0;
    setState(() {});
  }

  void _setClothSource() {
    imgTypeList.clear();
    imgTypeList.add("assets/images/custom_wall_costume1.webp");
    imgTypeList.add("assets/images/custom_wall_costume2.webp");
    imgTypeList.add("assets/images/custom_wall_costume3.webp");

    selectImg = imgTypeList[0];
    selectType = 1;
    setState(() {});
  }

  void _setAinimalSource() {
    imgTypeList.clear();
    imgTypeList.add("assets/images/custom_wall_animal1.webp");
    imgTypeList.add("assets/images/custom_wall_animal2.webp");
    imgTypeList.add("assets/images/custom_wall_animal3.webp");
    imgTypeList.add("assets/images/custom_wall_animal4.webp");
    imgTypeList.add("assets/images/custom_wall_animal5.webp");
    imgTypeList.add("assets/images/custom_wall_animal6.webp");
    imgTypeList.add("assets/images/custom_wall_animal7.webp");
    imgTypeList.add("assets/images/custom_wall_animal8.webp");
    imgTypeList.add("assets/images/custom_wall_animal9.webp");

    selectImg = imgTypeList[0];
    selectType = 2;
    setState(() {});
  }

  void _setPersonSource() {
    imgTypeList.clear();
    imgTypeList.add("assets/images/custom_wall_people1.webp");
    imgTypeList.add("assets/images/custom_wall_people2.webp");
    imgTypeList.add("assets/images/custom_wall_people3.webp");
    imgTypeList.add("assets/images/custom_wall_people4.webp");
    imgTypeList.add("assets/images/custom_wall_people5.webp");
    imgTypeList.add("assets/images/custom_wall_people6.webp");
    imgTypeList.add("assets/images/custom_wall_people7.webp");
    imgTypeList.add("assets/images/custom_wall_people8.webp");
    imgTypeList.add("assets/images/custom_wall_people9.webp");
    imgTypeList.add("assets/images/custom_wall_people10.webp");
    imgTypeList.add("assets/images/custom_wall_people11.webp");
    imgTypeList.add("assets/images/custom_wall_people12.webp");
    imgTypeList.add("assets/images/custom_wall_people13.webp");

    selectImg = imgTypeList[0];
    selectType = 3;
    print("$selectImg");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _changeStatus();
    return WillPopScope(
      child: Container(
        color: Colors.black,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            Center(
              //不指定位置，则填充这个父布局
              child: _ImageView(_image),
            ),
            buildPositioned(context),
            //样式调整
            buildStyle(context),
            buildPreview(),
          ],
        ),
      ),
      onWillPop: () {
        exit(0);
      },
    );
  }

  //预览
  GestureDetector buildPreview() {
    return GestureDetector(
      onTap: () {
        SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top,SystemUiOverlay.bottom]); //top : bottom
        visiblePre = false;
        _changeStyle(true);
      },
      child: Container(
        width: visiblePre ? MediaQuery.of(context).size.width : 0.0,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            PageView.builder(
              onPageChanged: (index) => pageIndexNotifier.value = index,
              itemCount: imgReviews.length,
              itemBuilder: (context, index) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Image.asset(
                    imgReviews[index],
                    fit: BoxFit.fitHeight,
                  ),
                );
              },
            ),
            _buildExample2()
          ],
        ),
      ),
    );
  }

  PageViewIndicator _buildExample2() {
    return PageViewIndicator(
      pageIndexNotifier: pageIndexNotifier,
      length: imgReviews.length,
      normalBuilder: (animationController, index) => Circle(
        size: 8.0,
        color: Colors.black87,
      ),
      highlightedBuilder: (animationController, index) => ScaleTransition(
        scale: CurvedAnimation(
          parent: animationController,
          curve: Curves.ease,
        ),
        child: Circle(
          size: 8.0,
          color: Colors.white,
        ),
      ),
    );
  }

  //展示样式选择器
  Container buildStyle(BuildContext context) {
    return Container(
      width: visibleStyle ? MediaQuery.of(context).size.width : 0,
      height: visibleStyle ? 300 : 0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        border: Border.all(color: Colors.grey),
        color: Color(int.parse("0xD9ffffff")),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          //样式分类
          buildStyleType(),
          Expanded(
              child: Container(
            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: imgTypeList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _selectType(index);
                    },
                    child: Container(
                      width: 110,
                      margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Stack(
                        children: <Widget>[
                          //第一层,图片背景
                          Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              color: Color(int.parse("0xff000000")),
                            ),
                            child: Center(
                              child: Container(
                                width: 100,
                                height: 180,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/main_back.png"),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ),
                          ),

                          //第二层，刘海样式
                          Container(
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              image: DecorationImage(
                                  image: AssetImage(imgTypeList[index]),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          //第三层阴影遮罩
                          Container(
                            width: selectIndex == index ? 120 : 0,
                            child: Stack(
                              children: <Widget>[
                                //阴影
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    color: Color(int.parse("0xB3000000")),
                                  ),
                                ),
                                //选中的图片
                                Center(
                                    child: Image.asset(
                                  selectIndex == index
                                      ? "assets/images/icon_pick_photo.png"
                                      : "",
                                  width: 20,
                                  fit: BoxFit.fitWidth,
                                ))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ))
        ],
      ),
    );
  }

  Container buildStyleType() {
    return Container(
      height: 60,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              _setFlowSource();
            },
            child: Container(
              height: 30,
              width: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  border: Border.all(color: buildTypeColor(0))),
              child: Center(
                child: Text(
                  "花纹",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: buildTypeColor(0),
                      decoration: TextDecoration.none),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              _setClothSource();
            },
            child: Container(
              height: 30,
              width: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  border: Border.all(color: buildTypeColor(1))),
              child: Center(
                child: Text(
                  "服饰",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: buildTypeColor(1),
                      decoration: TextDecoration.none),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              _setAinimalSource();
            },
            child: Container(
              height: 30,
              width: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  border: Border.all(color: buildTypeColor(2))),
              child: Center(
                child: Text(
                  "动物",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: buildTypeColor(2),
                      decoration: TextDecoration.none),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              _setPersonSource();
            },
            child: Container(
              height: 30,
              width: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  border: Border.all(color: buildTypeColor(3))),
              child: Center(
                child: Text(
                  "人物",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: buildTypeColor(3),
                      decoration: TextDecoration.none),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              visibleStyle = false;
              _changeStyle(true);
            },
            child: Image.asset("assets/images/icon_close.webp"),
          )
        ],
      ),
    );
  }

  Color buildTypeColor(int position) {
    if (selectType == position) {
      return Color(int.parse("0xff333333"));
    }
    return Color(int.parse("0xff999999"));
  }

  Positioned buildPositioned(BuildContext context) {
    return Positioned(
      bottom: 40,
      width: MediaQuery.of(context).size.width,
      child: AnimatedOpacity(
        opacity: visible ? 1.0 : 0.0,
        duration: Duration(milliseconds: 300),
        child: Container(
          height: 90,
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.all(new Radius.circular(20.0)),
          ),
          padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
          margin: EdgeInsets.fromLTRB(20, 0, 20, 60),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                child: Image.asset("assets/images/icon_custom_wall_add.webp"),
                onTap: () {
                  print("_selectImage");
                  _selectImage();
                },
              ),
              GestureDetector(
                child:
                    Image.asset("assets/images/icon_custom_wall_template.webp"),
                onTap: () {
                  visibleStyle = true;
                  _changeStyle(false);
                },
              ),
              GestureDetector(
                child:
                    Image.asset("assets/images/icon_custom_wall_preview.webp"),
                onTap: () {
                  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);//全屏，不显示状态栏，也不现实底部虚拟键盘
                  visiblePre = true;
                  _changeStyle(false);
                },
              ),
              GestureDetector(
                child:
                    Image.asset("assets/images/icon_custom_wall_download.webp"),
                onTap: () {
                  print("_testSaveImg");
                  _capturePng();
                },
              ),
              GestureDetector(
                child:
                Image.asset("assets/images/icon_custom_wall_about.webp"),
                onTap: () {
                  print("_testSaveImg");
                  _navigateToSecondPage(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /*图片控件*/
  Widget _ImageView(imgPath) {
    if (imgPath == null) {
      return GestureDetector(
        child: RepaintBoundary(
          key: rootWidgetKey,
          child: Stack(
            children: <Widget>[
              Center(
                child: Image.asset("assets/images/main_back.png",
                    fit: BoxFit.fitWidth,
                    width: MediaQuery.of(context).size.width),
              ),
              Image.asset(
                selectImg,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fitWidth,
              ),
            ],
          ),
        ),
        onTap: () {
          print("onTap");
          visibleStyle = false;
          _changeStyle(true);
        },
      );
    } else {
      return GestureDetector(
        child: RepaintBoundary(
          key: rootWidgetKey,
          child: Stack(
            children: <Widget>[
              Container(
                color: Colors.blue,
                child: SingleChildScrollView(
                  child: Image.file(imgPath, fit: BoxFit.fitWidth),
                ),
                width: MediaQuery.of(context).size.width,
              ),
              Image.asset(
                selectImg,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fitWidth,
              ),
            ],
          ),
        ),
        onTap: () {
          print("onTap");
          visibleStyle = false;
          _changeStyle(true);
        },
      );
    }
  }

  //选择图片
  Future _selectImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  //生成截图
  _capturePng() async {
    try {
      RenderRepaintBoundary boundary =
          rootWidgetKey.currentContext.findRenderObject();
      var image = await boundary.toImage(pixelRatio: 3.0);
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();
      images.clear();
      images.add(pngBytes);
      _testSaveImg();
      return pngBytes;
    } catch (e) {
      print(e);
    }
    return null;
  }

  //下载截图
  _testSaveImg() async {
    final result = await ImageGallerySaver.save(images[0]);
    print(result); //这个返回值 在保存成功后会返回true
    if (result) {
      Toast.show("保存成功", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    } else {
      Toast.show("保存失败", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
  }

  void _changeStyle(bool isShow) {
    setState(() {
      visible = isShow;
    });
  }

  //选择某个
  void _selectType(int position) {
    selectIndex = position;
    selectImg = imgTypeList[selectIndex];
    setState(() {});
  }

  _navigateToSecondPage(BuildContext context) async {
    dynamic customArgumnets = await Navigator.pushNamed(context, '/about',
        arguments: 'Android进阶之光');//1
  }

  _changeStatus() {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}
