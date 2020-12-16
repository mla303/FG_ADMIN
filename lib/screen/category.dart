import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fg_admin/firebase/firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fg_admin/constant.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../button.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  TextEditingController category_name= TextEditingController();
  DB db = DB(); // database object for firestore class
  Reference storageReference ;
  var image_file;
  var  photo_url;
  double uplaod_progress=0.0;
  saveButtonPressed(){
    storageReference = FirebaseStorage.instance
        .ref()//todo replace hello with real data
        .child("Categories/${category_name.text.trim()}");
    UploadTask upload_task = storageReference.putFile(File(image_file.path));

    upload_task.snapshotEvents.listen((TaskSnapshot snapshot) {

      setState(() {
        uplaod_progress = snapshot.bytesTransferred  / snapshot.totalBytes ;
      });
    });
    upload_task.then((value) {
      storageReference.getDownloadURL().then((url) {
         photo_url =url;
        print(photo_url);
         db.uploadCategory(category_name.text.trim(),photo_url);
         category_name.clear();
         setState(() {
           image_file=null;
           uplaod_progress=0.0;
         });
      });
    }
    );


  }
  Widget _buildListItem(BuildContext context, DocumentSnapshot snap){
    return  Column(
      children:[
        SizedBox(height: 15,),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "${snap.id} (${snap.data()['total images']+snap.data()['total videos']})",
                style: TextStyle(
                  color: Color(0xFFFFA0A0A0),
                  fontFamily: 'Poppin',
                  fontSize: 15.0,
                ),
              ),
              FlatButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Are you sure?"),
                        content: Text(
                            "Are you sure you want to delete this category? \nThe videos and images will be lost permanently"),
                        actions: [
                          FlatButton(
                            child: Text("Cancel",style:
                            TextStyle(
                                color: Colors.green
                            ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          FlatButton(
                            child: Text("Delete",
                              style: TextStyle(
                                color: Colors.red
                            ),
                            ),
                            onPressed: () {
                              FirebaseFirestore.instance.collection("categories").doc(snap.id).delete();
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text(
                  'Delete',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
          width: 330.0,
          height: 40.0,
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          decoration: BoxDecoration(
            boxShadow: kElevationToShadow[3],
            borderRadius: BorderRadius.all(Radius.circular(40.0)),
            // borderSide: BorderSide(color: Colors.black38)),
            color: Colors.white,
          ),
        ),
        SizedBox(height: 15,)
      ]

    );

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
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: double.maxFinite,
                    height: 200,
                    color: Colors.black12,
                    child:image_file==null? Icon(Icons.image,size: 80,color: Colors.black54,) :Image.file(
                      File(image_file.path),
                    fit: BoxFit.cover,)
                  ),
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.black12,
                    child: IconButton(
                      onPressed: (){
                        ImagePicker().getImage(source: ImageSource.gallery).then((img) {
                          setState(() {
                            image_file = img;
                          });
                        });
                      },
                      icon: Icon(Icons.camera_alt,
                        size: 30,
                        color: Colors.white,),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              LinearProgressIndicator(
                backgroundColor: Colors.transparent,
                value: uplaod_progress,
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Row(
                  children: [
                    Text('  Category Name', style: kTextStyle),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                width: 310.0,
                height: 50.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                  boxShadow: kElevationToShadow[3],
                ),

                //**** ENTER CATEGORY TEXT FIELD
                child: TextFormField(

                  controller: category_name,
                  decoration: kTxtField.copyWith(
                      contentPadding: EdgeInsets.only(left: 15),
                      hintText: 'Enter Category Name'),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              //***** SAVE BUTTON
              Button(
                onPress: () {
                 if(image_file==null||category_name.text.trim()==""||category_name.text.trim()==null)
                   {
                     Fluttertoast.showToast(  msg: "Please enter both category image and category title",
                         toastLength: Toast.LENGTH_SHORT,
                         gravity: ToastGravity.BOTTOM,
                         timeInSecForIosWeb: 3,
                         backgroundColor: Colors.red[400],
                         textColor: Colors.white,
                         fontSize: 16.0);
                   }

                 else {
                   saveButtonPressed();
                 }
                },
                buttonTitle: 'Save',
                colour: Color(0xFFFF3D3A3A),
              ),
              SizedBox(
                height: 50.0,
              ),
              Container(
                // margin: EdgeInsets.symmetric(vertical: 10),
                height: 300,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("categories").snapshots(),
                    builder: (context,snapshot) {
                      if (!snapshot.hasData)
                        return Center(child: CircularProgressIndicator());
                      return
                        ListView.builder(
                          itemCount:snapshot.data.documents.length,
                          itemBuilder: (BuildContext context, int index) {
                            return  _buildListItem(context ,snapshot.data.documents[index]);
                          }
                        );
                    }
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
