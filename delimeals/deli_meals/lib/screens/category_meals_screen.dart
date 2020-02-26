import 'package:deli_meals/models/meals.dart';
import 'package:flutter/material.dart';

import '../widgets/meals_item.dart';
import '../dummy_data.dart';

class CategoryMealsScreen extends StatefulWidget {

  static const routeName = '/categories-meals';

  final List<Meals> availableMeals;

  CategoryMealsScreen(this.availableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {

  String categoryTitle;
  List <Meals> displayedMeals;
  var _loadedInitData = false;

  @override
  void initState() {

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if(!_loadedInitData){
      final routesArgs =
      ModalRoute.of(context).settings.arguments as Map<String, String>;
      final categoryId = routesArgs['id'];
      categoryTitle = routesArgs['title'];
      displayedMeals = widget.availableMeals.where((meals){
        return meals.categories.contains(categoryId);
      }).toList();
      _loadedInitData=true;
    }
    super.didChangeDependencies();
  }

  void _removeMeals (String mealId){
    setState(() {
      displayedMeals.removeWhere((meal)=> meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index){
          return MealsItem(
            id: displayedMeals[index].id,
            title: displayedMeals[index].title,
            imageUrl: displayedMeals[index].imageUrl,
            duration: displayedMeals[index].duration,
            affordability: displayedMeals[index].affordability,
            complexity: displayedMeals[index].complexity,
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
