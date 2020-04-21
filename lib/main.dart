import 'package:flutter/material.dart';

import './dummy_data.dart';
import './models/meal.dart';
import './screens/categories_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/filters_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/tabs_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Default value for filter
  Map<String, bool> _filter = {
    'gluten': false,
    'lactose': false,
    'vegen': false,
    'vegetarian': false,
  };
  List<Meal> _availableMeals = DUMMY_MEALS;

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      // Make sure the key for both " _filter and filterData " are same.
      _filter = filterData;
      // Filter data using where
      _availableMeals = DUMMY_MEALS.where((meals) {
        if (_filter['gluten'] && !meals.isGlutenFree) {
          return false;
        }
        if (_filter['lactose'] && !meals.isLactoseFree) {
          return false;
        }
        if (_filter['vegen'] && !meals.isVegan) {
          return false;
        }
        if (_filter['vegetarian'] && !meals.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              body2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              title: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      //home: CategoriesScreen(),
      initialRoute: '/',
      // Default load value is : '/'.
      routes: {
        '/': (context) => TabsScreen(),

        // Register screenName for "Named Routes" in ROUTE TABLE on Main Screen.
        CategoryMealsScreen.screenName: (context) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.screenName: (context) => MealDetailScreen(),
        FiltersScreen.screenName: (context) =>
            FiltersScreen(_filter, _setFilters),
      },

      // If you are using "NameRoute" and going using "pushName" to that screen which is not
      // register in route Table that is
      //  routes: {
      //        '/': (context) => CategoriesScreen(),}
      // Then "onGenerateRoute" execute. And return to mension screen in "onGenerateRoute" method.
      // return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      onGenerateRoute: (setting) {
        print(setting.arguments);
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },

      // -When flutter failed to build screen that is there is nothing in route table and
      // -if we not use onGenerateRoute() at that time "onUnknownRoute()" execute to show
      //  something on the screen.
      // -This is use to show 404 page not found like error.
      // -This method execute when "onUnknownRoute()" not defined or doesn't return avalid
      //  Navigation action.
      onUnknownRoute: (setting) {
        print(setting.arguments);
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}
