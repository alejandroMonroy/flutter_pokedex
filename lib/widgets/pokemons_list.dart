import 'package:flutter/material.dart';
import 'package:flutter_pokedex/models/pokemon.dart';
import 'package:flutter_pokedex/widgets/pokemon_list_item.dart';

class PokemonsList extends StatelessWidget {
  final List<Pokemon> pokemons;

  const PokemonsList({
    super.key,
    required this.pokemons,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) =>
          PokemonListItem(pokemon: pokemons[index]),
      separatorBuilder: (context, index) => const Divider(),
      itemCount: pokemons.length,
    );
  }
}
