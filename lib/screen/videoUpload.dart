import 'dart:io';
import 'package:fg_admin/firebase/firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fg_admin/button.dart';
import 'package:fg_admin/constant.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';


class VideoUpload extends StatefulWidget {
  List<String> category_list = <String>[];

  VideoUpload(this.category_list);
  @override
  _VideoUploadState createState() => _VideoUploadState();
}

class _VideoUploadState extends State<VideoUpload> {
  TextEditingController videotitle_controller = TextEditingController();
  TextEditingController videodescription_controller = TextEditingController();
  TaskSnapshot taskSnapshot;
  DB db = DB();
  Color uploading_color = Colors.transparent;
  int uploading_status=0;
  String file_browse_text = "Browse...";
  Color browse_color =Colors.grey;
  Reference storageReference;
  var video_file=null;
  String _drop_down_value ;
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
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Row(
                  //****** IMAGE TITLE TEXT FIELD
                  children: [
                    Text('Title', style: kTextStyle),
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

                  //***** ENTER IMAGE TITLE TEXT FIELD
                  child: TextFormField(
                    controller: videotitle_controller,
                    decoration:
                        kTxtField.copyWith(hintText: 'Enter Video Title'),
                  )),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Row(
                  children: [
                    Text('Enter Video Description', style: kTextStyle),
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

                //*** IMAGE UPLOAD DESCRIPTION
                child: TextFormField(
                  controller: videodescription_controller,
                  decoration:
                      kTxtField.copyWith(hintText: 'Enter Video Description'),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),

              //***** CATEGORY
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Row(
                  children: [
                    Text('Category', style: kTextStyle),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),

              //***** VIDEO CATEGORY
              Container(
                child: DropdownButton(
                    hint: Text('  Select Category'),
                    underline: SizedBox(),
                    isExpanded: true,
                    //isDense: true,
                    value: _drop_down_value,
                    items: widget.category_list
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _drop_down_value = value;
                      });
                    }),
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

              SizedBox(
                height: 20.0,
              ),
              //*******UPLOAD VIDEO
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
                  ImagePicker().getVideo(source: ImageSource.gallery).then((video) {
                    video_file=video;
                    setState(() {
                      browse_color = Colors.green;
                      file_browse_text = video.path;
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
                height: 20.0,
              ),
              //****** SAVE IMAGE BUTTON
              // LinearProgressIndicator(
              //   value: 50,
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              Center(
                child: Button(
                  onPress: () {
                    if(videotitle_controller.text.trim()==""||videodescription_controller.text.trim()==""||video_file==null||_drop_down_value==null
                   || videotitle_controller.text.trim()==null||videodescription_controller.text.trim()==null
                    ){
                      Fluttertoast.showToast(
                          msg: "Please fill all fields",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.red[400],
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    }
                    else
                   {

                     storageReference = FirebaseStorage.instance
                         .ref()
                         .child("$_drop_down_value/${videotitle_controller.text.trim()}");
                     UploadTask upload_task = storageReference.putFile(File(video_file.path));

                     upload_task.snapshotEvents.listen((TaskSnapshot snapshot) {
                       uploading_color=Colors.black87;
                       double trandfered_percent = snapshot.bytesTransferred  / snapshot.totalBytes *100;
                      setState(() {
                        uploading_status =int.parse((trandfered_percent).toStringAsFixed(0));
                      });
                     });

                     upload_task.then((value) {
                       storageReference.getDownloadURL().then((url) {
                         var  video_url =url;
                         db.uploadVideoDetails(videotitle_controller.text.trim(), videodescription_controller.text.trim(), video_url, _drop_down_value, storageReference.fullPath);
                         print(video_url);
                         Fluttertoast.showToast(
                             msg: "Video uploaded successfully");
                         Navigator.pop(context);
                       });
                     }
                     ).catchError((error){
                       Fluttertoast.showToast(
                           msg: "Video upload failed ${error.toString()}",
                           toastLength: Toast.LENGTH_SHORT,
                           gravity: ToastGravity.BOTTOM,
                           timeInSecForIosWeb: 3,
                           backgroundColor: Colors.red,
                           textColor: Colors.white,
                           fontSize: 16.0
                       );
                     });
                   }
                  },
                  buttonTitle: 'Save',
                  colour: Color(0xFFFF3D3A3A),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
