import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';


class SettingScreen extends StatefulWidget {

  static const routName = '/settings';

  final Function saveSettings;
  final Map<String,bool> currentSetting;


  SettingScreen(this.currentSetting, this.saveSettings);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  bool _glutenFree = false;
  bool _isVegan = false;
  bool _isVegetarian = false;
  bool _isLactoseFree = false;

  @override
  initState(){
    _glutenFree = widget.currentSetting['gluten'];
    _isVegan = widget.currentSetting['vegan'];
    _isVegetarian = widget.currentSetting['vegetarian'];
    _isLactoseFree = widget.currentSetting['lactose'];
    super.initState();
  }

  Widget _buildSwitchListTile(
      String title,
      String description,
      bool currentValue,
      Function updateValue){
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(description),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final selectedSetting ={
                'gluten': _glutenFree,
                'lactose': _isLactoseFree,
                'vegan': _isVegan,
                'vegetarian': _isVegetarian,
              };
              widget.saveSettings(selectedSetting);
            },
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust Your Meal Select',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchListTile(
                    'Gluten Free',
                    'Only Include Gluten Free Meals',
                    _glutenFree,
                    (newValue){
                      setState(() {
                        _glutenFree = newValue;
                      },
                      );
                    },
                ),
                _buildSwitchListTile(
                  'Lactose Free',
                  'Only Include Lactose Free Meals',
                  _isLactoseFree,
                      (newValue){
                    setState(() {
                      _isLactoseFree = newValue;
                    },
                    );
                  },
                ),
                _buildSwitchListTile(
                  'Vegan Free',
                  'Only Include Vegan Free Meals',
                  _isVegan,
                      (newValue){
                    setState(() {
                      _isVegan = newValue;
                    },
                    );
                  },
                ),
                _buildSwitchListTile(
                  'Vegetarian Free',
                  'Only Include Vegetarian Free Meals',
                  _isVegetarian,
                      (newValue){
                    setState(() {
                      _isVegetarian = newValue;
                    },
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
