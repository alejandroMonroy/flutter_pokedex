import 'package:flutter/material.dart';
import 'package:flutter_pokedex/controllers.dart/pokemons_controller.dart';

class PokemonSearchBar extends StatelessWidget {
  const PokemonSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: PokemonsController.to.pokemonsSearchController,
      onChanged: (String query) {
        PokemonsController.to.searchPokemons(query);
      },
      decoration: InputDecoration(
        hintText: 'Type to search',
        suffix: IconButton(
          onPressed: () {
            PokemonsController.to
              ..pokemonsSearchController.clear()
              ..searchPokemons('');
          },
          icon: const Icon(
            Icons.clear,
            size: 16.0,
            color: Colors.black26,
          ),
        ),
      ),
    );
  }
}
