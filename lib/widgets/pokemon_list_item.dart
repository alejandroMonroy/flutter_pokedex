import 'package:flutter/material.dart';
import 'package:flutter_pokedex/models/pokemon.dart';
import 'package:flutter_pokedex/views/pokemon_view.dart';
import 'package:flutter_pokedex/widgets/save_pokemon_button.dart';
import 'package:get/get.dart';

class PokemonListItem extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonListItem({
    super.key,
    required this.pokemon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        pokemon.name.toUpperCase(),
      ),
      subtitle: Text(
        pokemon.typeNames.first.toUpperCase(),
        style: const TextStyle(fontSize: 12.0),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        color: Colors.black26,
        size: 16.0,
      ),
      leading: SavePokemonButton(pokemon: pokemon),
      onTap: () => Get.to(() => PokemonView(pokemon: pokemon)),
    );
  }
}
