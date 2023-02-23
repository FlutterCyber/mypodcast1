import 'package:ebook_app/pages/book_info_page/screens/strings.dart';
import 'package:flutter/material.dart';

class SynopsisScreen extends StatefulWidget {
  static const String id = "synopsis_screen";

  const SynopsisScreen({Key? key}) : super(key: key);

  @override
  State<SynopsisScreen> createState() => _SynopsisScreenState();
}

class _SynopsisScreenState extends State<SynopsisScreen> {
  @override
  Widget build(BuildContext context) {
    return Text(BookInfoPageStrings.synopsis);
  }
}
