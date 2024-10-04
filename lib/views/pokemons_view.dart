import 'package:flutter/material.dart';
import 'package:flutter_pokedex/controllers.dart/pokemons_controller.dart';
import 'package:flutter_pokedex/widgets/loader.dart';
import 'package:flutter_pokedex/widgets/open_pokeball_button.dart';
import 'package:flutter_pokedex/widgets/pokemon_search_bar.dart';
import 'package:flutter_pokedex/widgets/pokemons_list.dart';
import 'package:flutter_pokedex/widgets/pokemons_placeholder.dart';
import 'package:get/get.dart';

class PokemonsView extends StatelessWidget {
  const PokemonsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.primaryColor,
        title: const Text(
          'Pokemons',
          style: TextStyle(color: Colors.white),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: OpenPokeballButton(),
          )
        ],
      ),
      body: GetBuilder<PokemonsController>(
        init: Get.put(PokemonsController()),
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const PokemonSearchBar(),
                const SizedBox(height: 16.0),
                Expanded(
                  child: controller.isLoadingPokemons
                      ? const Loader()
                      : RefreshIndicator.adaptive(
                          onRefresh: () async {
                            await controller.getAllPokemons(mustRefetch: true);
                          },
                          child: controller.pokemons.isEmpty
                              ? const PokemonsPlaceholder()
                              : PokemonsList(pokemons: controller.pokemons),
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
