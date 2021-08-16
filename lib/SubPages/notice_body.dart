import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:spring/enum.dart';
import 'package:spring/spring_kit.dart';

class NoticeBody extends StatefulWidget {
  final String title;
  final String image;
  final String text;
  const NoticeBody({ Key key, this.title, this.image, this.text }) : super(key: key);

  @override
  _NoticeBodyState createState() => _NoticeBodyState();
}

class _NoticeBodyState extends State<NoticeBody> {
  final _key = GlobalKey<SpringState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueAccent,
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Text(
            "Notices",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                // height: size.height,
                child: Stack(
                  children: <Widget>[
                    Container(
                      margin: widget.image != null
                          ? EdgeInsets.only(top: size.height * 0.12)
                          : EdgeInsets.only(top: size.height * 0.03),
                      padding: widget.image != null
                          ? EdgeInsets.only(
                              top: size.height * 0.18,
                              left: 8.0,
                              right: 8.0,
                            )
                          : EdgeInsets.only(
                              top: size.height * 0.03,
                              left: 8.0,
                              right: 8.0,
                            ),
                      height: size.height * 0.8,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(24),
                          )),
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            // SizedBox(height: size.height*0.1,),
                            Text(
                              // "vfdbg fbn hbhh zhrh hGHG hAHzh ah zhr z",
                              widget.title,

                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: size.height * 0.02,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Divider(),
                            ),
                            Text(
                              widget.text,

                              // "fb ffj jbf fjbnjf ffbdjf fdfdjf fdfdjf fdfdjf fdfjdf dfjbdfjd dfbdfjd dfbdjfdf dfdjfb fb ffj jbf fjbnjf ffbdjf fdfdjf fdfdjf fdfdjf fdfjdf dfjbdfjd dfbdfjd dfbdjfdf dfdjfb fb ffj jbf fjbnjf ffbdjf fdfdjf fdfdjf fdfdjf fdfjdf dfjbdfjd dfbdfjd dfbdjfdf dfdjfb\n\nffj jbf fjbnjffjbdfjd dfbdfjd dfbdjfdf dfdjfb\n\nffj jbf fjbnjfjbdfjd dfbdfjd dfbdjfdf dfdjfb\n\nffj jbf fjbnj ffbdjf fdfdjf fdfdjf fdfdjf fdfjdf dfjbdfjd dfbdfjd ffj jbf fjbnjf ffbdjf fdfdjf fdfdjf fdfdjf fdfjdf dfjbdfjd dfbdfjd b ffj jbf fjbnjf ffbdjf fdfdjf fdfdjf fdfdjf fdfjdf dfjbdfjd dfbdfjd dfbdjfdf dfdjfb fb ffj jbf fjbnjf ffbdjf fdfdjf fdfdjf fdfdjf fdfjdf dfjbdfjd dfbdfjd dfbdjfdf dfdjfb fb ffj jbf fjbnjf ffbdjf fdfdjf fdfdjf fdfdjf fdfjdf dfjbdfjd dfbdfjd dfbdjfdf dfdjfb\n\nffj jbf fjbnjffjbdfjd dfbdfjd dfbdjfdf dfdjfb\n\nffj jbf fjbnjfjbdfjd dfbdfjd dfbdjfdf dfdjfb\n\nffj jbf fjbnj ffbdjf fdfdjf fdfdjf fdfdjf fdfjdf dfjbdfjd dfbdfjd ffj jbf fjbnjf ffbdjf fdfdjf fdfdjf fdfdjf fdfjdf dfjbdfjd dfbdfj b ffj jbf fjbnjf ffbdjf fdfdjf fdfdjf fdfdjf fdfjdf dfjbdfjd dfbdfjd dfbdjfdf dfdjfb fb ffj jbf fjbnjf ffbdjf fdfdjf fdfdjf fdfdjf fdfjdf dfjbdfjd dfbdfjd dfbdjfdf dfdjfb fb ffj jbf fjbnjf ffbdjf fdfdjf fdfdjf fdfdjf fdfjdf dfjbdfjd dfbdfjd dfbdjfdf dfdjfb\n\nffj jbf fjbnjffjbdfjd dfbdfjd dfbdjfdf dfdjfb\n\nffj jbf fjbnjfjbdfjd dfbdfjd dfbdjfdf dfdjfb\n\nffj jbf fjbnj ffbdjf fdfdjf fdfdjf fdfdjf fdfjdf dfjbdfjd dfbdfjd ffj jbf fjbnjf ffbdjf fdfdjf fdfdjf fdfdjf fdfjdf dfjbdfjd dfbdfj b ffj jbf fjbnjf ffbdjf fdfdjf fdfdjf fdfdjf fdfjdf dfjbdfjd dfbdfjd dfbdjfdf dfdjfb fb ffj jbf fjbnjf ffbdjf fdfdjf fdfdjf fdfdjf fdfjdf dfjbdfjd dfbdfjd dfbdjfdf dfdjfb fb ffj jbf fjbnjf ffbdjf fdfdjf fdfdjf fdfdjf fdfjdf dfjbdfjd dfbdfjd dfbdjfdf dfdjfb\n\nffj jbf fjbnjffjbdfjd dfbdfjd dfbdjfdf dfdjfb\n\nffj jbf fjbnjfjbdfjd dfbdfjd dfbdjfdf dfdjfb\n\nffj jbf fjbnj ffbdjf fdfdjf fdfdjf fdfdjf fdfjdf dfjbdfjd dfbdfjd ffj jbf fjbnjf ffbdjf fdfdjf fdfdjf fdfdjf fdfjdf dfjbdfjd dfbdfj",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 999,
                              style: TextStyle(
                                height: 1.8,
                                fontSize: size.height * 0.018,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(
                              height: size.height * 0.05,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // SizedBox(
                          //   height: size.height * 0.05,
                          // ),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: size.width * 0.05,
                              ),
                              Expanded(
                                child: widget.image != null
                                    ? Spring(
                                        key: _key,
                                        motion: Motion.Mirror,
                                        animType: AnimType.Slide_In_Left,
                                        animDuration:
                                            Duration(seconds: 5),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(24)),
                                              color: Colors.white,
                                              // image: DecorationImage(
                                              //   image:
                                              //       NetworkImage(widget.image),
                                              //   fit: BoxFit.fill,
                                              // ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey,
                                                  offset:
                                                      Offset(0.0, 1.0), //(x,y)
                                                  blurRadius: 6.0,
                                                )
                                              ]),
                                          height: size.height * 0.25,
                                          // width: size.width*0.40,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(24)),
                                            child: CachedNetworkImage(
                                              imageUrl: widget.image,
                                              imageBuilder:
                                                  (context, imageProvider1) =>
                                                      Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: imageProvider1,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                              progressIndicatorBuilder:
                                                  (context, url,
                                                          downloadProgress) =>
                                                      Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        value: downloadProgress
                                                            .progress),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Center(
                                                          child: Image.asset(
                                                "images/teacher.png",
                                                filterQuality:
                                                    FilterQuality.high,
                                                fit: BoxFit.fitHeight,
                                              )),
                                            ),
                                          ),
                                        ),
                                      )
                                    : SizedBox(
                                        height: 1.0,
                                      ),
                              ),
                              SizedBox(
                                width: size.width * 0.05,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
