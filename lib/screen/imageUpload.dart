import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fg_admin/button.dart';
import 'package:fg_admin/firebase/firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fg_admin/constant.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ImageUpload extends StatefulWidget {
  List<String> category_list = <String>[];

  ImageUpload(this.category_list);
  @override
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  int uploading_status=0;
  Color uploading_color= Colors.transparent;
  String file_browse_text = "Browse...";
  var image_file;
  Reference storageReference ;
  Color browse_color =Colors.grey;
  TextEditingController imagetitle_controller = TextEditingController();
  TextEditingController imagedescription_controller = TextEditingController();
   DB db = DB();
  String  _drop_down_value;
  CollectionReference categories = FirebaseFirestore.instance.collection("categories");
  List<DropdownMenuItem<String>> menuItems;
  @override
  void initState() {
    // TODO: implement initState
    db.getCategoriesList().then((list) {
      setState(() {
        widget.category_list= list;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:
            Image.asset('images/F G  T R C K N L G Y.png', fit: BoxFit.cover),
        backgroundColor: Color(0xFFFF3D3A3A),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              //   child: Row(
              //     //****** IMAGE TITLE TEXT FIELD
              //     children: [
              //       Text('Title', style: kTextStyle),
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   height: 10.0,
              // ),
              // Container(
              //     padding: EdgeInsets.only(left: 10.0, right: 10.0),
              //     width: 310.0,
              //     height: 50.0,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(40),
              //       color: Colors.white,
              //       boxShadow: kElevationToShadow[3],
              //     ),
              //
              //     //***** ENTER IMAGE TITLE TEXT FIELD
              //     child: TextFormField(
              //       controller: imagetitle_controller,
              //       decoration:
              //           kTxtField.copyWith(hintText: 'Enter Image Title'),
              //     )),
              // SizedBox(
              //   height: 20.0,
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              //   child: Row(
              //     children: [
              //       Text('Enter Image Description', style: kTextStyle),
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   height: 10.0,
              // ),
              // Container(
              //   padding: EdgeInsets.only(left: 10.0, right: 10.0),
              //   width: 310.0,
              //   height: 50.0,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(40),
              //     color: Colors.white,
              //     boxShadow: kElevationToShadow[3],
              //   ),
              //
              //   //*** IMAGE UPLOAD DESCRIPTION
              //   child: TextFormField(
              //     controller: imagedescription_controller,
              //     decoration:
              //         kTxtField.copyWith(hintText: 'Enter Image Description'),
              //   ),
              // ),
              // SizedBox(
              //   height: 20.0,
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              //   child: Row(
              //     children: [
              //       Text('Category', style: kTextStyle),
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   height: 10.0,
              // ),

              //***** IMAGE CATEGORY
              // Container(
              //   child: DropdownButton<String>(
              //           hint: Text(
              //             '  Select Category',
              //             style: TextStyle(color: Colors.grey),
              //           ),
              //           underline: SizedBox(),
              //           isExpanded: true,
              //           //isDense: true,
              //       value: _drop_down_value,
              //       items:widget.category_list
              //           .map<DropdownMenuItem<String>>((String value) {
              //         return DropdownMenuItem<String>(
              //           value: value,
              //           child: Text(value),
              //         );
              //       }).toList(),
              //
              //           // categories_list.map((String category) {
              //           //   return  DropdownMenuItem(
              //           //     value: category,
              //           //     child: new Text(category),
              //           //   );
              //           // }).toList(),
              //
              //           onChanged: (value) {
              //             setState(() {
              //               _drop_down_value = value;
              //             });
              //           }
              //       ),
              //
              //
              //   width: 310.0,
              //   height: 50.0,
              //   padding: EdgeInsets.only(left: 20.0, right: 20.0),
              //   decoration: BoxDecoration(
              //     boxShadow: kElevationToShadow[3],
              //     borderRadius: BorderRadius.all(Radius.circular(40.0)),
              //     // borderSide: BorderSide(color: Colors.black38)),
              //     color: Colors.white,
              //   ),
              // ),

              SizedBox(
                height: 20.0,
              ),

              //*******UPLOAD IMAGE
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Row(
                  children: [
                    Text('File browse', style: kTextStyle),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              GestureDetector(
                onTap: (){
                  ImagePicker().getImage(source: ImageSource.gallery).then((img) {
                    image_file = img;
                    setState(() {
                      browse_color = Colors.green;
                      file_browse_text = img.path;

                    });
                  });

                },
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          file_browse_text,
                          style: TextStyle(
                            color: Color(0xFFFFA0A0A0),
                            fontFamily: 'Poppin',
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.file_upload,
                        color: browse_color,
                      ),
                    ],
                  ),
                  width: 310.0,
                  height: 50.0,
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  decoration: BoxDecoration(
                    boxShadow: kElevationToShadow[3],
                    borderRadius: BorderRadius.all(Radius.circular(40.0)),
                    // borderSide: BorderSide(color: Colors.black38)),
                    color: Colors.white,
                  ),
                ),
              ),

              SizedBox(
                height: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  LinearProgressIndicator(
                    value: uploading_status/100,
                    backgroundColor: Colors.transparent,
                  ),
                  Text("${uploading_status}%",
                    style: TextStyle(
                        color: uploading_color
                    ),),
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
              //** SAVE IMAGE BUTTON
              Button(
                onPress: () {
                  if(
                  // imagetitle_controller.text.trim()==""||
                      // imagedescription_controller.text.trim()==""||
                      // _drop_down_value==null||
                      image_file==null
                  // ||
                          // imagetitle_controller.text.trim()==null||
                  // imagedescription_controller.text.trim()==null
                  )
                    {
                      Fluttertoast.showToast( msg: "Please fill all fields",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }

                  else {

                    storageReference = FirebaseStorage.instance
                        .ref()//todo replace hello with real data
                        .child("$_drop_down_value/${imagetitle_controller.text.trim()}");
                    UploadTask upload_task = storageReference.putFile(File(image_file.path));
                    upload_task.snapshotEvents.listen((TaskSnapshot snapshot) {
                      uploading_color=Colors.black87;
                      double trandfered_percent = snapshot.bytesTransferred  / snapshot.totalBytes *100;
                      setState(() {
                        uploading_status =int.parse((trandfered_percent).toStringAsFixed(0));
                      });
                    });

                    upload_task.then((value) {
                      storageReference.getDownloadURL().then((url) {
                        var  photo_url =url;
                        db.uploadImageDetails(imagetitle_controller.text.trim(), imagedescription_controller.text.trim(), photo_url,_drop_down_value,storageReference.fullPath);
                        print(photo_url);
                        Fluttertoast.showToast( msg: "Image uploaded successfully");

                        Navigator.pop(context);
                      });
                    }
                    ).catchError((error){
                      Fluttertoast.showToast(
                          msg: "Image uploading failed ${error.toString()}",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    });
                  }
                  },
                buttonTitle: 'Save',
                colour: Color(0xFFFF3D3A3A),
              )
            ],
          ),
        ),
      ),
    );
  }
}
