import 'package:flutter/material.dart';

import './dummy_data.dart';
import './models/meals.dart';
import './screens/settings_screen.dart';
import './screens/tabs_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/meals_detail_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Map<String,bool> _setting = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meals> _availableMeals = DUMMY_MEALS;
  List<Meals> _favoriteMeals = [];

  void _setSetting(Map<String, bool> settingData){
    setState(() {
      _setting = settingData;

      _availableMeals = DUMMY_MEALS.where((meal){
        if(_setting['gluten'] && !meal.isGlutenFree){
          return false;
        }if(_setting['lactose'] && !meal.isLactoseFree) {
          return false;
        }if(_setting['vegan'] && !meal.isVegan) {
          return false;
        }if(_setting['vegetarian'] && !meal.isVegetarian) {
          return false;
        }return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId){
    final existingIndex = _favoriteMeals.indexWhere((meal) => meal.id == mealId);

    if(existingIndex >= 0){
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    }else{
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal)=> meal.id == mealId),
        );
      });
    }
  }

  bool _isMealsFavorite(String id){
    return _favoriteMeals.any((meal)=> meal.id == id);
    
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor:  Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 0.9),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
          body1:
          TextStyle(
              color: Color.fromRGBO(20, 51, 51, 0.9)
          ),
          body2: TextStyle(
            color: Color.fromRGBO(20, 51, 51, 0.9)
          ),
          title: TextStyle(
            fontSize: 20,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
          )
        )
      ),
      //home: CategoryScreen(),
      initialRoute: '/',
      routes: {
        '/': (ctx)=> TabScreen(_favoriteMeals),
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routName: (ctx) => MealDetailScreen(_toggleFavorite, _isMealsFavorite),
        SettingScreen.routName: (ctx) => SettingScreen(_setting, _setSetting),
      },
      onUnknownRoute: (settings){
        return MaterialPageRoute(builder: (ctx) => CategoryMealsScreen(_availableMeals),
        );
      },
    );
  }
}
