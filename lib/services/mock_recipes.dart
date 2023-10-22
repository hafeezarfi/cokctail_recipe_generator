import 'package:cocktail_recipe_generator/models/recipe.dart';

final List<Recipe> mockRecipes = [
  Recipe(
      name: 'Margarita',
      ingredients: ['Tequila', 'Triple sec', 'Lime Juice', 'Salt'],
      instructions:
          '''Rub the rim of the glass with the lime slice to make the salt stick to it.
Take care to moisten only the outer rim and sprinkle the salt on it.
The salt should present to the lips of the imbiber and never mix into the cocktail.
Shake the other ingredients with ice, then carefully pour into the glass.'''),
  Recipe(name: 'Mojito', ingredients: [
    '2-3 oz Light rum',
    'Juice of 1 Lime',
    '2 tsp Sugar',
    '2-4 Mint',
    'Soda Water'
  ], instructions: '''Muddle mint leaves with sugar and lime juice.
Add a splash of soda water and fill the glass with cracked ice.
Pour the rum and top with soda water.
Garnish and serve with straw.'''),
  Recipe(
      name: ' Gin Tonic',
      ingredients: [
        '4 cl Gin',
        '10 cl Tonic Water',
        '1 Slice Lemon Peel',
        'cubes ice'
      ],
      instructions:
          '''Fill a highball glass with ice, pour the gin, top with tonic water and squeeze a lemon wedge and garnish with a lemon wedge.'''),
  Recipe(
      name: 'Drinking Chocolate',
      ingredients: [
        '2 oz Heavy Cream',
        '6-8 oz Milk',
        '1 stick Cinnamon',
        '1 Vanilla',
        '2 oz finely chopped dark Chocolate',
        'Fresh Whipped cream'
      ],
      instructions:
          '''Heat the cream and milk with the cinnamon and vanilla bean very slowly for 15-20 minutes.
(If you don't have any beans add 1-2 tsp of vanilla after heating).
Remove the bean and cinnamon.
Add the chocolate.
Mix until fully melted.
Serve topped with some very dense fresh whipped cream.
Serves 1-2 depending upon how much of a glutton you are.
For a richer chocolate, use 4 oz of milk, 4 oz of cream, 4 oz of chocolate.
Serve in coffee mug.'''),
  Recipe(
    name: ' Tennesee Mud',
    ingredients: [
      '8 oz Coffee',
      '4 oz Jack Daniels',
      '4 oz Amaretto',
      'Whipped cream'
    ],
    instructions: '''Mix Coffee, Jack Daniels and Amaretto.
Add Cream on top.''',
  ),
];
