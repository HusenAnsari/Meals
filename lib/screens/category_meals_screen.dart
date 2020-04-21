import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  // Declare screenName for "Named Routes"
  static const screenName = '/category_meals_screen';
  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<Meal> displayedMeals;
  var _loadedInitData = false;

  @override
  void initState() {
    // - If we have any context related process that we can not execute in initState()
    //   other than we can use initState() easily.
    // - context is globally available in State<>.
    // - but context is not available in initState() because initState() method run to early
    //   it's run before our widget has been created.
    // - if we use context into initState() is give you error for tha we use didChangeDependencies().
    //
    super.initState();
  }

  void _removeMeal(String mealId) {
    setState(() {
      // removeWhere to remove item from list.
      displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  void didChangeDependencies() {
    // didChangeDependencies() runs couple of time after initialization state.
    // we limit that run we use  _loadedInitData here.
    if (!_loadedInitData) {
      // Receive data to "CategoryItem" using "Named Routes"
      var routeArgument =
      ModalRoute
          .of(context)
          .settings
          .arguments as Map<String, String>;

      final categoryId = routeArgument['id'];
      categoryTitle = routeArgument['title'];

      // - Here we are use widget to access "availableMeals" list
      //   because our "availableMeals" save into Widget "Constructor CategoryMealsScreen;"
      // - That is called widget level function.
      // get filter date using "categoryId".
      displayedMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return MealItem(
            id: displayedMeals[index].id,
            title: displayedMeals[index].title,
            imageUrl: displayedMeals[index].imageUrl,
            complexity: displayedMeals[index].complexity,
            affordability: displayedMeals[index].affordability,
            duration: displayedMeals[index].duration,
            removeItem: _removeMeal,
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
