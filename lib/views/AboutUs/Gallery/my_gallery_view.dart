import 'package:flutter/material.dart';

class GalleryView extends StatefulWidget {
  const GalleryView({Key? key}) : super(key: key);

  @override
  _GalleryViewState createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  final List<String> assetImage = [
    "images/logo-02-removebg.png",
    "images/bookimg1.jpg",
    "images/logo-01.jpg",
    "images/logo-02.jpg",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      appBar: AppBar(
        title: Text(
          "Gallery",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Center(
          //     child: CarouselSlider.builder(
          //   options: CarouselOptions(
          //       height: 300,
          //       autoPlay: true,
          //       enlargeCenterPage: true,
          //       autoPlayInterval: Duration(seconds: 2),
          //       enableInfiniteScroll: false),
          //   itemCount: assetImage.length,
          //   itemBuilder: (context, index, realIndex) {
          //     final assetsImages = assetImage[index];
          //     return buildImage(assetsImages, index);
          //   },
          // ))
        ],
      ),
    );
  }

  buildImage(String assetImage, int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.symmetric(horizontal: 12),
      child: Image.asset(
        assetImage,
        fit: BoxFit.fill,
      ),
    );
  }
}
