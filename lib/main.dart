import 'package:ebook_app/pages/book_info_page/book_info_page.dart';
import 'package:ebook_app/pages/nav_bar_widget/nav_bar_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NavBarWidget(),
      routes: {
        NavBarWidget.id: (context) => NavBarWidget(),
        BookInfoPage.id: (context) => BookInfoPage(),
      },
    );
  }
}
