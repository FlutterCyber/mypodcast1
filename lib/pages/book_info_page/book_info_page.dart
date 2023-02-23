import 'dart:ui';
import 'package:ebook_app/pages/audio_with_pdf_page/audio_with_pdf_viewer_page.dart';
import 'package:ebook_app/pages/book_info_page/screens/details_screen.dart';
import 'package:ebook_app/pages/book_info_page/screens/synopsis_screen.dart';
import 'package:ebook_app/pages/nav_bar_widget/nav_bar_widget.dart';
import 'package:ebook_app/pages/pdf_viewer_page/pdf_viewer_page.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:iconly/iconly.dart';

import '../../controllers/pdf_opener/pdf_opener.dart';

class BookInfoPage extends StatefulWidget {
  static const String id = "book_info_page";

  const BookInfoPage({Key? key}) : super(key: key);

  @override
  State<BookInfoPage> createState() => _BookInfoPageState();
}

class _BookInfoPageState extends State<BookInfoPage> {
  bool complated = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFBF8F2),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xffFBF8F2),
        leading: IconButton(
          icon: const Icon(
            IconlyBroken.arrow_left,
            color: Color(0xff2F2F2F),
          ),
          onPressed: () {
            Get.to(const NavBarWidget());
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(IconlyBroken.bookmark, color: Color(0xff2F2F2F)),
            onPressed: () {},
          ),
        ],
        title: const Text(
          "Book Info",
          style: TextStyle(
              fontSize: 20,
              color: Color(0xff2F2F2F),
              fontFamily: "PlayfairDisplay-VariableFont",
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              _bookInfos(),
            ],
          ),
          complated
              ? SizedBox.shrink()
              : Center(child: CircularProgressIndicator()),
        ],
      ),
      floatingActionButton: _bookInfoNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _bookInfos() {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: SliverToBoxAdapter(
        child: Padding(
          padding:
              const EdgeInsets.only(right: 15, left: 15, top: 10, bottom: 10),
          child: ClipRRect(
            //borderRadius: BorderRadius.circular(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: Get.height * 0.28,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        image: AssetImage("assets/images/3.png"),
                        fit: BoxFit.cover,
                      )),
                ),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  "The Homeric Hymns",
                  style: TextStyle(
                      fontSize: 22,
                      color: Color(0xff2F2F2F),
                      fontFamily: "PlayfairDisplay-VariableFont",
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "By Michael Crudden",
                      style: TextStyle(
                        fontSize: 17,
                        color: Color(0xff2F2F2F),
                      ),
                    ),
                    Text(
                      "3h 22 m",
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff2F2F2F),
                          fontFamily: "PlayfairDisplay-VariableFont",
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      height: 70,
                      width: Get.width * 0.27,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(width: 1.5, color: Color(0xffBFA054)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Text(
                            "Released",
                            style:
                                TextStyle(color: Colors.black54, fontSize: 16),
                          ),
                          Text(
                            "2021",
                            style: TextStyle(
                                color: Color(0xff2F2F2F),
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      height: 70,
                      width: Get.width * 0.27,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(width: 1.5, color: Color(0xffBFA054)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Text(
                            "Part",
                            style:
                                TextStyle(color: Colors.black54, fontSize: 16),
                          ),
                          Text(
                            "16",
                            style: TextStyle(
                                color: Color(0xff2F2F2F),
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      height: 70,
                      width: Get.width * 0.27,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(width: 1.5, color: Color(0xffBFA054)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Text(
                            "Pages",
                            style:
                                TextStyle(color: Colors.black54, fontSize: 16),
                          ),
                          Text(
                            "340",
                            style: TextStyle(
                                color: Color(0xff2F2F2F),
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: Get.width * 0.55,
                  child: const TabBar(
                    indicatorColor: Color(0xff2F2F2F),
                    unselectedLabelColor: Colors.grey,
                    labelColor: Color(0xff2F2F2F),
                    labelStyle: TextStyle(fontSize: 17),
                    indicatorPadding: EdgeInsets.all(10),
                    tabs: [
                      Tab(
                        text: "Synopsis",
                      ),
                      Tab(
                        text: "Details",
                      ),

                      // Text(
                      //   "Synopsis",
                      //   style: TextStyle(color: Color(0xff2F2F2F),fontSize: 17),
                      // ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const SizedBox(
                  height: 650,
                  child: TabBarView(
                    children: [
                      SynopsisScreen(),
                      DetailsScreen(),
                    ],
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// nav bar for this page => for "Start  Reading" and "Play Audio" buttons
  Widget _bookInfoNavBar() {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5), topRight: Radius.circular(5)),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaY: 10,
          sigmaX: 10,
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 15, left: 15, bottom: 10),
          child: Container(
            height: Get.height * 0.07,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xffffffff).withOpacity(0.3),
                  const Color(0xffffffff).withOpacity(0.3),
                ],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      setState(() {
                        complated = false;
                      });
                      Get.to(
                        PDFViewerPage(
                          file: await PDFOpener.openMe(),
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xffBFA054),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.book),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Start Reading",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      setState(() {
                        complated = false;
                      });
                      Get.to(
                        AudioWithPdfPage(
                          file: await PDFOpener.openMe(),
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xff2F2F2F),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            IconlyBroken.play,
                            color: Color(0xffFBF8F2),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Play Audio",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xffFBF8F2),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
