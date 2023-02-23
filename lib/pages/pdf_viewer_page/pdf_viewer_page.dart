import 'dart:io';
import 'package:ebook_app/controllers/pdf_opener/pdf_opener.dart';
import 'package:ebook_app/pages/book_info_page/book_info_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:path/path.dart';

class PDFViewerPage extends StatefulWidget {
  static const String id = "pdf_viewer_page";
  final File file;

  const PDFViewerPage({Key? key, required this.file}) : super(key: key);

  @override
  State<PDFViewerPage> createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  late PDFViewController controller;
  int pages = 0;
  int indexPage = 0;

  @override
  Widget build(BuildContext context) {
    final name = basename(widget.file.path);
    final text = "${indexPage + 1} of $pages";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffBFA054),
        leading: IconButton(
          onPressed: () {
            Get.offAll(BookInfoPage());
          },
          icon: Icon(IconlyBroken.arrow_left),
        ),
        actions: [
          Center(
            child: Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          IconButton(
            onPressed: () {
              final page = indexPage == 0 ? pages : indexPage - 1;
              controller.setPage(page);
            },
            icon: const Icon(
              IconlyBroken.arrow_left,
            ),
          ),
          IconButton(
            onPressed: () {
              final page = indexPage == pages - 1 ? 0 : indexPage + 1;
              controller.setPage(page);
            },
            icon: Icon(
              IconlyBroken.arrow_right,
            ),
          ),
        ],
        title: Text(name),
      ),
      body: Center(
          child: PDFView(
        filePath: widget.file.path,
        //swipeHorizontal: true,
        pageSnap: false,
        pageFling: false,
        autoSpacing: false,
        //nightMode: true,
        onRender: (pages) {
          setState(() {
            this.pages = pages!;
          });
        },
        onViewCreated: (controller) {
          setState(() {
            this.controller = controller;
          });
        },
        onPageChanged: (indexPage, _) {
          setState(() {
            this.indexPage = indexPage!;
          });
        },
      )),
    );
  }
}
