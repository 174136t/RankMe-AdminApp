import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';
import 'package:spring/spring.dart';

class EssayBody extends StatefulWidget {
  final String qText;
  final String qImage;
  final String answer;
  final String answerImage;
  final String qNo;
  const EssayBody({ Key key, this.qText, this.qImage, this.answer, this.answerImage, this.qNo }) : super(key: key);

  @override
  _EssayBodyState createState() => _EssayBodyState();
}

class _EssayBodyState extends State<EssayBody> {
  @override
  final _key = GlobalKey<SpringState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          "Question " + widget.qNo,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Html(
                      data: widget.qText,
                      style: {
                        "body": Style(
                          fontSize: FontSize.large,
                          textAlign: TextAlign.justify,
                          // fontSize: FontSize(18.0),
                          // fontWeight: FontWeight.bold,
                        ),
                      },
                    ),
                    // Text(
                    //   widget.qText,
                    //   style: TextStyle(
                    //     color: Colors.white,
                    //     fontWeight: FontWeight.bold,
                    //     fontSize: size.width * 0.05,
                    //   ),
                    // ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  // Padding(
                  //   padding: EdgeInsets.only(
                  //     left: size.width * 0.05,
                  //     right: size.width * 0.05,
                  //   ),
                  //   child: Row(
                  //     children: <Widget>[
                  //       Expanded(
                  //         child: Container(
                  //           decoration: BoxDecoration(
                  //             color: Colors.black,
                  //              border: Border.all(color: Colors.black,width: 1.5),
                  //             borderRadius:
                  //                 BorderRadius.all(Radius.circular(24)),
                  //             image: widget.qImage != null
                  //                 ? DecorationImage(
                  //                     image: NetworkImage(widget.qImage),
                  //                     fit: BoxFit.fill,
                  //                   )
                  //                 : DecorationImage(
                  //                     image: NetworkImage(
                  //                         "https://image.freepik.com/free-vector/e-learning-vector-illustration_95561-13.jpg"),
                  //                     fit: BoxFit.fill,
                  //                   ),
                  //             // boxShadow: [
                  //             //   BoxShadow(
                  //             //     color: Colors.grey,
                  //             //     offset: Offset(0.0, 1.0), //(x,y)
                  //             //     blurRadius: 6.0,
                  //             //   )
                  //             // ]
                  //           ),
                  //           height: size.height * 0.25,
                  //           // width: size.width * 0.40,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
            Stack(
              children: [
                Column(
                  children: [
                    // SizedBox(
                    //   height: size.height * 0.05,
                    // ),
                    Container(
                      margin: widget.qImage != null &&
                              widget.qImage.toString() != ""
                          ? EdgeInsets.only(top: size.height * 0.2)
                          : EdgeInsets.all(0),
                      padding: EdgeInsets.only(
                        top: size.height * 0.03,
                        left: 8.0,
                        right: 8.0,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25)),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: widget.qImage != null &&
                                    widget.qImage.toString() != ""
                                ? size.height * 0.05
                                : 0,
                          ),

                          Text("පිළිතුර",
                              style: GoogleFonts.yesevaOne(
                                fontSize: size.width * 0.06,
                                fontWeight: FontWeight.w900,
                              )),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Html(
                            data: widget.answer,
                            style: {
                              "body": Style(
                                  fontSize: FontSize.medium,
                                  lineHeight: LineHeight.percent(150),
                                  textAlign: TextAlign.justify
                                  // fontSize: FontSize(18.0),
                                  // fontWeight: FontWeight.bold,
                                  ),
                            },
                            // defaultTextStyle: TextStyle(
                            //   height: 1.9,
                            //   // fontSize: 18.0,
                            //   color: Colors.black,
                            //   decoration: TextDecoration.none,
                            // ),

                            // blockSpacing: size.height*0.1,
                            //  padding: EdgeInsets.all(20),
                            // customTextAlign: (_) => TextAlign.justify,
                          ),
                          // Text(
                          //   widget.answer,
                          //   overflow: TextOverflow.ellipsis,
                          //   maxLines: 999,
                          //   style: TextStyle(
                          //     fontSize: size.width * 0.06,
                          //   ),
                          //   textAlign: TextAlign.justify,
                          // ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          widget.answerImage != null &&
                                  widget.answerImage.toString() != ""
                              ? Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(24)),
                                      // border: Border.all(color: Colors.black),
                                      // image: widget.answerImage != null
                                      //     ? DecorationImage(
                                      //         image: NetworkImage(
                                      //             widget.answerImage),
                                      //         fit: BoxFit.none)
                                      //     : Container(),
                                      // NetworkImage(
                                      //     "https://image.freepik.com/free-vector/e-learning-vector-illustration_95561-13.jpg"),

                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey[600],
                                          offset: Offset(0.0, 1.0), //(x,y)
                                          blurRadius: 6.0,
                                        )
                                      ]),
                                  // width: size.width*0.95,
                                  // height: size.height*0.25,
                                  child: widget.answerImage != null &&
                                          widget.answerImage.toString() != ""
                                      ? GestureDetector(
                                          onTap: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (_) {
                                              return DetailScreen(
                                                img: widget.answerImage,
                                              );
                                            }));
                                          },
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(24)),
                                            child: CachedNetworkImage(
                                              imageUrl: widget.answerImage,
                                              // imageBuilder:
                                              //     (context, imageProvider1) =>
                                              //         Container(
                                              //   decoration: BoxDecoration(
                                              //     image: DecorationImage(
                                              //       image: imageProvider1,
                                              //       fit: BoxFit.fill,
                                              //     ),
                                              //   ),
                                              // ),
                                              progressIndicatorBuilder:
                                                  (context, url,
                                                          downloadProgress) =>
                                                      Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        value: downloadProgress
                                                            .progress),
                                              ),
                                              errorWidget: (context, url,
                                                      error) =>
                                                  Center(
                                                      child: Icon(Icons.error)),
                                            ),
                                          ),
                                        )
                                      : Container(),
                                )
                              : Container(),
                          SizedBox(
                            height: size.height * 0.05,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                widget.qImage != null && widget.qImage.toString() != ""
                    ? Spring(
                        key: _key,
                        motion: Motion.Mirror,
                        animType: AnimType.Bubble,
                        animDuration: Duration(seconds: 5),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.05),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              // border:
                              //     Border.all(color: Colors.black, width: 1.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(24)),
                              // image: DecorationImage(
                              //   image: NetworkImage(widget.qImage),
                              //   fit: BoxFit.fill,
                              // )

                              // DecorationImage(
                              //     image: NetworkImage(
                              //         "https://image.freepik.com/free-vector/e-learning-vector-illustration_95561-13.jpg"),
                              //     fit: BoxFit.fill,
                              //   ),

                              // boxShadow: [
                              //   BoxShadow(
                              //     color: Colors.grey,
                              //     offset: Offset(0.0, 1.0), //(x,y)
                              //     blurRadius: 6.0,
                              //   )
                              // ]
                            ),
                            height: size.height * 0.25,
                            // width: size.width * 0.40,
                            child: widget.qImage != null &&
                                    widget.qImage.toString() != ""
                                ? ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(24)),
                                    // child: Image.network(
                                    //   widget.qImage,
                                    //   filterQuality: FilterQuality.low,
                                    //   fit: BoxFit.fill,
                                    //   loadingBuilder: (BuildContext context,
                                    //       Widget child,
                                    //       ImageChunkEvent loadingProgress) {
                                    //     if (loadingProgress == null) return child;
                                    //     return Center(
                                    //       child: SpinKitWave(
                                    //         color: Colors.amber[800],
                                    //         size: size.height * 0.05,
                                    //         // value: loadingProgress.expectedTotalBytes != null
                                    //         //     ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                                    //         //     : null,
                                    //       ),
                                    //     );
                                    //   },
                                    // ),
                                    child: CachedNetworkImage(
                                      imageUrl: widget.qImage,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              Center(
                                        child: CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Center(child: Icon(Icons.error)),
                                    ),
                                  )
                                : Container(),
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final String img;

  DetailScreen({this.img});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
            child: Hero(
          tag: 'imageHero',
          child: PhotoView(
            imageProvider: NetworkImage(
              img,
            ),
          ),
        )
            //   ZoomableWidget(
            // maxScale: 5.0,
            // minScale: 0.5,
            // multiFingersPan: false,
            // autoCenter: true,
            // child: Image(image: AdvancedNetworkImage(img)),
            // // onZoomChanged: (double value) => print(value),
            // )),
            ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}