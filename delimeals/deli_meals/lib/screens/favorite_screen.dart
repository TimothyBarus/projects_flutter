import '../widgets/meals_item.dart';

import '../models/meals.dart';
import 'package:flutter/material.dart';


class FavoriteScreen extends StatelessWidget {
  final List<Meals> favoriteMeals;

  FavoriteScreen(this.favoriteMeals);

  @override
  Widget build(BuildContext context) {
    if(favoriteMeals.isEmpty){
      return Center(
        child: Text('No Favorite'),
      );
    }else{
      return ListView.builder(
        itemBuilder: (ctx, index){
          return MealsItem(
            id: favoriteMeals[index].id,
            title: favoriteMeals[index].title,
            imageUrl: favoriteMeals[index].imageUrl,
            duration: favoriteMeals[index].duration,
            affordability: favoriteMeals[index].affordability,
            complexity: favoriteMeals[index].complexity,
          );
          },
        itemCount: favoriteMeals.length,
      );
    }

  }
}
