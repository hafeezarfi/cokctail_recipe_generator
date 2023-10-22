import 'package:cocktail_recipe_generator/models/recipe.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('recipe should store values name, ingredients and instructions.', () {
    final recipe = Recipe(
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
Serve in coffee mug.''');
    expect(recipe.name, 'Drinking Chocolate');
    expect(recipe.ingredients, [
      '2 oz Heavy Cream',
      '6-8 oz Milk',
      '1 stick Cinnamon',
      '1 Vanilla',
      '2 oz finely chopped dark Chocolate',
      'Fresh Whipped cream'
    ]);
    expect(recipe.instructions,
        '''Heat the cream and milk with the cinnamon and vanilla bean very slowly for 15-20 minutes.
(If you don't have any beans add 1-2 tsp of vanilla after heating).
Remove the bean and cinnamon.
Add the chocolate.
Mix until fully melted.
Serve topped with some very dense fresh whipped cream.
Serves 1-2 depending upon how much of a glutton you are.
For a richer chocolate, use 4 oz of milk, 4 oz of cream, 4 oz of chocolate.
Serve in coffee mug.''');
  });
}
