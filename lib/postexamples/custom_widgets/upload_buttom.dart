// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomWidgets {
  static Widget uploadButton(Function uploadImage) {
    return GestureDetector(
      onTap: () {
        uploadImage();
      },
      child: Container(
        height: 60,
        decoration: BoxDecoration(
            color: Colors.deepPurple, borderRadius: BorderRadius.circular(10)),
        child: const Center(
          child: Text(
            "Upload",
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
 

// GestureDetector(
//               onTap: () {
//                 showDialog(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return AlertDialog(
//                       title: Text("Select Please"),
//                       actions: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             GestureDetector(
//                               onTap: () => getImageFromCamera(),
//                               child: Container(
//                                 height: 100,
//                                 width: 100,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   color: Colors.deepPurple,
//                                 ),
//                                 child: const Center(
//                                     child: Icon(
//                                   Icons.camera_alt_outlined,
//                                   color: Colors.white,
//                                   size: 50,
//                                 )),
//                               ),
//                             ),
//                             GestureDetector(
//                               onTap: () => getImageGallery(),
//                               child: Container(
//                                 height: 100,
//                                 width: 100,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   color: Colors.deepPurple,
//                                 ),
//                                 child: const Center(
//                                     child: Icon(
//                                   Icons.collections,
//                                   size: 50,
//                                   color: Colors.white,
//                                 )),
//                               ),
//                             ),
//                           ],
//                         )
//                       ],
//                     );
//                   },
//                 );
//               },
//               child: Container(
//                 height: 50,
//                 width: 100,
//                 decoration: BoxDecoration(
//                     color: Colors.deepPurple,
//                     borderRadius: BorderRadius.circular(10)),
//                 child: const Center(
//                   child: Text(
//                     "Click Here",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),
//             ),