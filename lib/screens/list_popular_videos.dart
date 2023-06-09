import 'package:flutter/material.dart';
import 'package:pmsna1/models/popular_model.dart';
import 'package:pmsna1/network/api_popular.dart';
import 'package:pmsna1/widgets/item_popular.dart';

class ListPopularVideos extends StatefulWidget {
  const ListPopularVideos({super.key});

  @override
  State<ListPopularVideos> createState() => _ListPopularVideosState();
}

class _ListPopularVideosState extends State<ListPopularVideos> {
  ApiPopular? apiPopular;

  @override
  void initState(){
    super.initState();
    apiPopular = ApiPopular();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('List Popular'),),
      body: FutureBuilder(
        future: apiPopular!.getAllPopular(),
        builder: (context, AsyncSnapshot<List<PopularModel>?> snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio:  0.8,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            ),
            itemCount: snapshot.data !=null ? snapshot.data!.length:0,
            itemBuilder: (context, index) {
              return ItemPopular(popularModel: snapshot.data![index]);
            },
            );
          } else if (snapshot.hasError){
            return Center(child: Text('Error'),);
          } else {
            return const CircularProgressIndicator();
          }
        }
      ),
    );
  }
}