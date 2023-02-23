import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class PopularBooksWidget extends StatelessWidget {
  static const String id = "popular_books_widget";
  PopularBooksWidget({Key? key}) : super(key: key);
  final CollectionReference _newest_podcasts =
      FirebaseFirestore.instance.collection("newest_podcasts");

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: StreamBuilder(
        stream: _newest_podcasts.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return _topBooksWidget(
                  "${documentSnapshot["name"]}",
                  "${documentSnapshot["imageLink"]}",
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget _topBooksWidget(String name, String imageLink) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 10),
      child: ClipRRect(
        child: Container(
          child: Row(
            children: [
              Container(
                height: 65,
                width: 60,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(imageLink), fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xff2F2F2F),
                      fontWeight: FontWeight.bold,
                      fontFamily: "PlayfairDisplay-VariableFont",
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  const Text("Derek Collins"),
                  const SizedBox(
                    height: 3,
                  ),
                  Row(
                    children: const [
                      Icon(
                        IconlyBroken.star,
                        size: 17,
                      ),
                      Icon(
                        IconlyBroken.star,
                        size: 17,
                      ),
                      Icon(
                        IconlyBroken.star,
                        size: 17,
                      ),
                      Icon(
                        IconlyBroken.star,
                        size: 17,
                      ),
                      Icon(
                        IconlyBroken.star,
                        size: 17,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
