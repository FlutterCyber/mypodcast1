import 'package:ebook_app/pages/book_info_page/screens/strings.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  static const String id = "details_screen";

  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Text(BookInfoPageStrings.details);
  }
}
