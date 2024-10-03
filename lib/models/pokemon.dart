import 'dart:convert';

class Pokemon {
  final int pokemonId;
  final String name;
  final String imageUrl;
  final int height;
  final int weight;
  final List<String> typeNames;

  Pokemon(
    this.pokemonId,
    this.name,
    this.imageUrl,
    this.height,
    this.weight,
    this.typeNames,
  );

  factory Pokemon.fromMap(Map<String, dynamic> map) {
    return Pokemon(
      map['id'],
      map['name'],
      map['sprites']['other']['dream_world']['front_default'],
      map['height'] ?? 0,
      map['weight'] ?? 0,
      List<String>.from(map['types'].map((type) => type['type']['name'])),
    );
  }

  factory Pokemon.fromDatabase(Map<String, dynamic> map) {
    return Pokemon(
      map['pokemonId'],
      map['name'],
      map['imageUrl'],
      map['height'],
      map['weight'],
      List<String>.from(jsonDecode(map['types'])),
    );
  }

  Map<String, Object?> toMap() {
    return {
      'pokemonId': pokemonId,
      'name': name,
      'imageUrl': imageUrl,
      'height': height,
      'weight': weight,
      'types': jsonEncode(typeNames),
    };
  }
}
