import 'package:flutter/material.dart';
import 'package:pmsna1/models/popular_model.dart';

class ItemPopular extends StatelessWidget{
  const ItemPopular({super.key, required this.popularModel});

  final PopularModel popularModel;

  @override
  Widget build(BuildContext){
    return FadeInImage(
      fit: BoxFit.fill,
      placeholder: AssetImage('assets/loading.gif'),
      image: NetworkImage('https://image.tmdb.org/t/p/w500/${popularModel.posterPath}'),
    );
  }
}