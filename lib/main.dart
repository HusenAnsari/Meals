import 'package:flutter/material.dart';

import './screens/categories_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/filters_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/tabs_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
        CategoryMealsScreen.screenName: (context) => CategoryMealsScreen(),
        MealDetailScreen.screenName: (context) => MealDetailScreen(),
        FiltersScreen.screenName: (context) => FiltersScreen(),
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
