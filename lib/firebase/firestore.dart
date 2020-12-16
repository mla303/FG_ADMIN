import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

 class DB {
   //instance members
   FirebaseFirestore firestore =FirebaseFirestore.instance;


   //member functions
   uploadImageDetails(String title, String desciption,String image_url,String category,String storage_referance){
     firestore.collection("categories").doc(category).update({
       "images": FieldValue.arrayUnion([
         //json/ map object
         {
           "image title":title,
           "image description":desciption,
           "image url":image_url,
           "cloud storage referance":storage_referance
         },
       ]),
       "total images":FieldValue.increment(1),
     });
   }
   uploadVideoDetails(String title, String desciption,String video_url,String category,String storage_referance){
     firestore.collection("categories").doc(category).update({
       "videos":FieldValue.arrayUnion([
         {
           "video title":title,
           "video description":desciption,
           "video url":video_url,
           "cloud storage referance":storage_referance
         }
       ]),
       "total videos":FieldValue.increment(1)
     });
   }

  Future<List<String>>  getCategoriesList () async{
   List<String> cat_list = <String>[];
    await  firestore.collection("categories").get().then((querysnapshot) {

       for(var doc in querysnapshot.docs){
         cat_list.add(doc.id);
       }
       // querysnapshot.docs.map((e) => cat_list.add(e.id));
       print(cat_list);
     });
   return cat_list;
   }
  uploadCategory(String category_name,String photo_url){
    firestore.collection("categories").doc(category_name).set({
      "total images":0,//initially there is no image
      "total videos":0,
      "photo url":photo_url
    }).catchError((e){
      print(e);
    });
  }

}