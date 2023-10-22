import 'package:equatable/equatable.dart';

class Recipe extends Equatable {
  String name;
  List<String> ingredients;
  String instructions;
  bool isFavorite;

  Recipe({
    required this.name,
    required this.ingredients,
    required this.instructions,
    this.isFavorite = false,
  });

  factory Recipe.fromJson(dynamic json) {

    var ingredientsList = json['ingredients'];
    List<String>? ingredients = ingredientsList!=null?List.from(ingredientsList):null;
    return Recipe(
      name: json['name'] as String,
      ingredients: ingredients as List<String>,
      instructions: json['instructions'] as String,
    );
  }

  Map toJson() => {
    'name':name,
    'ingredients':ingredients,
    'instructions':instructions,
    'isFavorite':isFavorite?true:false
  };

  @override
  List<Object?> get props => [
        name,
        ingredients,
        instructions,
        isFavorite,
      ];
  @override
  String toString() {
    return '{"name": $name, "ingredients": ${ingredients.toString()}, "instructions": $instructions, "isFavorite": ${isFavorite ? "true" : "false"}}';
  }
}
