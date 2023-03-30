import 'package:flutter/material.dart';
import 'package:pmsna1/database/database_helper.dart';
import 'package:pmsna1/models/post_model.dart';
import 'package:provider/provider.dart';

import '../provider/flags_provider.dart';

class AddPostScreen extends StatelessWidget {
  AddPostScreen({super.key});

  DatabaseHelper database = DatabaseHelper();

  PostModel? objPostModel;

  @override
  Widget build(BuildContext context) {

    FlagsProvider flag = Provider.of<FlagsProvider>(context);
    final txtConPost= TextEditingController();
    if(ModalRoute.of(context)!.settings.arguments != null){
      objPostModel = ModalRoute.of(context)!.settings.arguments as PostModel;
      txtConPost.text = objPostModel!.dscPost!;
    }


    return Scaffold(
    body: Center(
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(15),
        height: 350,
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          border: Border.all(color: Colors.black)
        ),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            objPostModel==null 
            ? const Text('Add Post :)') 
            : const Text('Update Post'),
            TextFormField(
              controller: txtConPost, 
              maxLines: 8,
            ),
            ElevatedButton(
              onPressed: (){

                if(objPostModel==null){
                database.INSERT('tblPost',{
                  'dscPost' : txtConPost.text,
                  'datePost' : DateTime.now().toString()
                }).then((value){

                  var msg = value > 0 
                    ? 'Registro insertado' 
                    : 'Ocurrió un error';

                  var snackBar = SnackBar(
                    content: Text(msg)
                  );

                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                });
                }else{
                  database.UPDATE('tblPost',{
                  'idPost' : objPostModel!.idPost,
                  'dscPost' : txtConPost.text,
                  'datePost' : DateTime.now().toString()
                }).then((value){

                  var msg = value > 0 
                    ? 'Registro actuaizado' 
                    : 'Ocurrió un error';

                  var snackBar = SnackBar(
                    content: Text(msg)
                  );

                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                });
                }
                flag.setflagListPost();
              }, 
              child: Text('Save Post')
            )
          ],
        ),
      ),
    ),
    );
  }
}