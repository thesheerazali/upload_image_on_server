import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_apis_work/postexamples/custom_widgets/upload_buttom.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:http/http.dart' as http;

class ImageUploadOnServer extends StatefulWidget {
  const ImageUploadOnServer({super.key});

  @override
  State<ImageUploadOnServer> createState() => _ImageUploadOnServerState();
}

class _ImageUploadOnServerState extends State<ImageUploadOnServer> {
  File? image;

  final imagepicker = ImagePicker();
  bool progressIndecator = false;

  Future getImageGallery() async {
    Navigator.of(context).pop(true);
    final filepicked = await imagepicker.pickImage(
        source: ImageSource.gallery, imageQuality: 25);

    if (filepicked != null) {
      image = File(filepicked.path);
      setState(() {});
    } else {
      print("No Image Selected");
    }
  }

  Future getImageFromCamera() async {
    Navigator.of(context).pop(true);
    final filepicked = await imagepicker.pickImage(
        source: ImageSource.camera, imageQuality: 25);

    if (filepicked != null) {
      image = File(filepicked.path);
      setState(() {});
    } else {
      print("No Image Selected");
    }
  }

  Future<void> uploadImage() async {
    if (image == null) {
      dialogBox(title: "Select Image Firls", content: "");
    } else {
      setState(() {
        progressIndecator = true;
      });

      var stream = http.ByteStream(image!.openRead());
      stream.cast();

      var length = await image!.length();

      var uri = Uri.parse("https://fakestoreapi.com/products");

      var req = http.MultipartRequest('POST', uri);

      req.fields['title'] = "Static ttitle";

      var multiport = http.MultipartFile(
        'image',
        stream,
        length,
      );

      req.files.add(multiport);

      var responce = await req.send();

      if (responce.statusCode == 200) {
        setState(() {
          progressIndecator = false;
          image = null;
        });

        dialogBox(
            title: "Successfull",
            content: "Yayyy! Image Uploaded Successfully");

        print("Uploaded Successfull");
      } else {
        setState(() {
          progressIndecator = false;
        });

        dialogBox(title: "Unsuccessfull", content: "Oops! Image Not Uploaded");

        print("failed");
      }
    }
  }

  alterBoxForImagePick() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsPadding: EdgeInsets.all(20),
          backgroundColor: Colors.black,
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => getImageFromCamera(),
                  child: Column(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.deepPurple,
                        ),
                        child: const Center(
                            child: Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.white,
                          size: 50,
                        )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Camera",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => getImageGallery(),
                  child: Column(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.deepPurple,
                        ),
                        child: const Center(
                            child: Icon(
                          Icons.collections,
                          size: 50,
                          color: Colors.white,
                        )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Gallery",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  dialogBox({required String title, required String content}) {
    showDialog(
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              Center(
                child: ElevatedButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          );
        },
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text("Upload Your Image"),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
        ),
        body: ModalProgressHUD(
          inAsyncCall: progressIndecator,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => alterBoxForImagePick(),
                  child: SizedBox(
                      height: 400,
                      child: image == null
                          ? Center(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.deepPurple,
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Center(
                                  child: Text(
                                    "Image",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            )
                          : Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  File(image!.path).absolute,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )),
                ),
                const SizedBox(
                  height: 50,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomWidgets.uploadButton(uploadImage),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
