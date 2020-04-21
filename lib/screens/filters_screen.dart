import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const screenName = '/filters_screen';
  Function saveFilters;
  final Map<String, bool> currentFilter;

  FiltersScreen(this.currentFilter, this.saveFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _lactoseFree = false;
  var _vegen = false;
  var _vegetarian = false;

  // To save state of selected filter which is enable after screen change.
  @override
  void initState() {
    super.initState();
    // - Here we are use widget to access "currentFilter" as we get list in FiltersScreen() constructor
    //   and constructor is a widget so we need to use widget to access list.
    _glutenFree = widget.currentFilter['gluten'];
    _lactoseFree = widget.currentFilter['lactose'];
    _vegen = widget.currentFilter['vegen'];
    _vegetarian = widget.currentFilter['vegetarian'];
  }

  Widget _buildSwitchListTile(String title, String description,
      bool currentType, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: currentType,
      subtitle: Text(description),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            // - Here we are use widget to access "saveFilters" function
            //   because our "saveFilters" function save into Widget "Constructor FiltersScreen;"
            // - That is called widget level function.
            onPressed: () {
              // Set key to same as saveFilters() which is in main.dart "_setFilters"
              // Assign filter switch value to keys
              final selectedFilters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegen': _vegen,
                'vegetarian': _vegetarian,
              };
              // below code trigger main.dart "_setFilters(Map<String, bool> filterData) {} method"
              widget.saveFilters(selectedFilters);
            },
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(14),
            child: Text(
              'Adjust your meal selection',
              style: Theme
                  .of(context)
                  .textTheme
                  .title,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchListTile(
                  'Gluten free',
                  'Only include gluten free meals.',
                  _glutenFree,
                      (newValue) {
                    setState(() {
                      _glutenFree = newValue;
                    });
                  },
                ),
                _buildSwitchListTile(
                  'Lactose free',
                  'Only include lactose free meals.',
                  _lactoseFree,
                      (newValue) {
                    setState(() {
                      _lactoseFree = newValue;
                    });
                  },
                ),
                _buildSwitchListTile(
                  'Vegen',
                  'Only include vegen meals.',
                  _vegen,
                      (newValue) {
                    setState(() {
                      _vegen = newValue;
                    });
                  },
                ),
                _buildSwitchListTile(
                  'Vegetarian',
                  'Only include vegetarian meals.',
                  _vegetarian,
                      (newValue) {
                    setState(() {
                      _vegetarian = newValue;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
