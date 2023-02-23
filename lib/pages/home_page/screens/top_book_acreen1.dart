import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class TopBookScreen1 extends StatelessWidget {
  static const String id = "screen1";

  TopBookScreen1({Key? key}) : super(key: key);
  final CollectionReference _newest_podcasts =
      FirebaseFirestore.instance.collection("newest_podcasts");

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _newest_podcasts.snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
        if (streamSnapshot.hasData) {
          return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                
                return Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black54,
                        image: DecorationImage(
                          image: NetworkImage("${documentSnapshot["details"]}"),
                          //AssetImage("assets/images/1.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      // child: Image.network("${documentSnapshot["details"]}"),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        //color: Colors.black54,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: Container(
                                  padding: EdgeInsets.only(right: 8, left: 8),
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(10),
                                    //border: Border.all(width: 1,color: Colors.white30)
                                  ),
                                  child: Center(
                                    child: GestureDetector(
                                        onTap: () {
                                          print("bookmark1");
                                        },
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            IconlyBroken.bookmark,
                                            color: Colors.black,
                                            //Color(0xffFBF8F2),
                                          ),
                                        )),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                padding: EdgeInsets.only(right: 8, left: 8),
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.3),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            documentSnapshot["name"],
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: Color(0xffFBF8F2),
                                                fontSize: 15,
                                                fontFamily:
                                                    "PlayfairDisplay-VariableFont",
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  const Icon(
                                                    IconlyBold.play,
                                                    color: Color(0xffFBF8F2),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    documentSnapshot[
                                                        "duration"],
                                                    style: const TextStyle(
                                                      color: Color(0xffFBF8F2),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: const [
                                                  Icon(
                                                    IconlyBroken
                                                        .arrow_right_circle,
                                                    color: Color(0xffFBF8F2),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    "Andrew Dalby",
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: Color(0xffFBF8F2),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              });
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

// Widget _example(){
//   return Stack(
//     children: [
//       Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: Colors.black54,
//           image: const DecorationImage(
//             image: AssetImage("assets/images/1.png"),
//             fit: BoxFit.cover,
//           ),
//         ),
//       ),
//       Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           //color: Colors.black54,
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(10),
//                 child: BackdropFilter(
//                   filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//                   child: Container(
//                     padding: EdgeInsets.only(right: 8, left: 8),
//                     height: 40,
//                     width: 40,
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.3),
//                       borderRadius: BorderRadius.circular(10),
//                       //border: Border.all(width: 1,color: Colors.white30)
//                     ),
//                     child: Center(
//                       child: GestureDetector(
//                         onTap: () {
//                           print("bookmark1");
//                         },
//                         child: const Icon(
//                           IconlyBroken.bookmark,
//                           color: Color(0xffFBF8F2),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             ClipRRect(
//               borderRadius: const BorderRadius.only(
//                 bottomRight: Radius.circular(10),
//                 bottomLeft: Radius.circular(10),
//               ),
//               child: BackdropFilter(
//                 filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//                 child: Container(
//                   padding: EdgeInsets.only(right: 8, left: 8),
//                   height: 60,
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.3),
//                   ),
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           const Expanded(
//                             child: Text(
//                               "Food in the ancient World from A to Z",
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                               style: TextStyle(
//                                   color: Color(0xffFBF8F2),
//                                   fontSize: 15,
//                                   fontFamily: "PlayfairDisplay-VariableFont",
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                           const SizedBox(
//                             width: 10,
//                           ),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   children: const [
//                                     Icon(
//                                       IconlyBold.play,
//                                       color: Color(0xffFBF8F2),
//                                     ),
//                                     SizedBox(
//                                       width: 5,
//                                     ),
//                                     Text(
//                                       "15h Listen",
//                                       style: TextStyle(
//                                         color: Color(0xffFBF8F2),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Row(
//                                   children: const [
//                                     Icon(
//                                       IconlyBroken.arrow_right_circle,
//                                       color: Color(0xffFBF8F2),
//                                     ),
//                                     SizedBox(
//                                       width: 5,
//                                     ),
//                                     Text(
//                                       "Andrew Dalby",
//                                       maxLines: 2,
//                                       overflow: TextOverflow.ellipsis,
//                                       style: TextStyle(
//                                         color: Color(0xffFBF8F2),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ],
//   );
// }
// Widget _example2(){
//   return Card(
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(documentSnapshot["name"],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
//         const SizedBox(height: 5,),
//         Text(documentSnapshot["duration"],style: TextStyle(fontSize: 16),),
//         const SizedBox(height: 5,),
//         Text(documentSnapshot["releaseDate"],style: TextStyle(fontSize: 16),),
//         const SizedBox(height: 5,),
//         Text(documentSnapshot["synopsis"],style: TextStyle(fontSize: 16),),
//         const SizedBox(height: 5,),
//         Text(documentSnapshot["details"],style: TextStyle(fontSize: 16),),
//         const SizedBox(height: 15,),
//       ],
//     ),
//   );
// }
}
