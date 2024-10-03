import 'package:flutter/material.dart';
import 'package:flutter_pokedex/controllers.dart/pokemons_controller.dart';
import 'package:flutter_pokedex/models/pokemon.dart';
import 'package:get/get.dart';

class SavePokemonButton extends StatelessWidget {
  final Pokemon pokemon;

  const SavePokemonButton({
    super.key,
    required this.pokemon,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PokemonsController>(builder: (controller) {
      return IconButton(
        onPressed: () {
          if (controller.pokemonsInPokedex.firstWhereOrNull(
                  (poke) => poke.pokemonId == pokemon.pokemonId) !=
              null) {
            Get.defaultDialog(
              titlePadding: const EdgeInsets.all(16.0),
              contentPadding: const EdgeInsets.all(16.0),
              title: "Pokedex info",
              content: const Text("Are you sure?"),
              cancel: MaterialButton(
                onPressed: Get.back,
                child: const Text('Cancel'),
              ),
              confirm: MaterialButton(
                onPressed: () {
                  PokemonsController.to.removePokemon(pokemon);
                  Get.back();
                },
                child: const Text('Remove'),
              ),
            );
          } else {
            PokemonsController.to.savePokemon(pokemon);
          }
        },
        icon: Icon(
          controller.pokemonsInPokedex.firstWhereOrNull(
                      (poke) => poke.pokemonId == pokemon.pokemonId) !=
                  null
              ? Icons.star_rounded
              : Icons.star_outline_rounded,
          color: controller.pokemonsInPokedex.firstWhereOrNull(
                      (poke) => poke.pokemonId == pokemon.pokemonId) !=
                  null
              ? Colors.yellow
              : Colors.black26,
          shadows: controller.pokemonsInPokedex.firstWhereOrNull(
                      (poke) => poke.pokemonId == pokemon.pokemonId) !=
                  null
              ? [
                  const Shadow(
                    blurRadius: 24.0,
                    color: Colors.yellowAccent,
                  )
                ]
              : [],
          size: 32.0,
        ),
      );
    });
  }
}
