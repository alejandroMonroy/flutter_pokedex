import 'package:flutter/material.dart';
import 'package:flutter_pokedex/controllers.dart/pokemons_controller.dart';
import 'package:flutter_pokedex/views/pokedex_view.dart';
import 'package:flutter_pokedex/widgets/pokemon_list_item.dart';
import 'package:flutter_pokedex/widgets/pokemon_search_bar.dart';
import 'package:flutter_pokedex/widgets/pokemons_placeholder.dart';
import 'package:get/get.dart';

class PokemonsView extends StatelessWidget {
  const PokemonsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemons'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: InkWell(
              onTap: () {
                Get.to(() => const PokedexView());
              },
              child: Image.asset(
                'assets/icons/pokeball.png',
                height: 24.0,
              ),
            ),
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
                      ? const Center(
                          child: CircularProgressIndicator.adaptive(),
                        )
                      : RefreshIndicator.adaptive(
                          onRefresh: () async {
                            await controller.getAllPokemons(mustRefetch: true);
                          },
                          child: controller.pokemons.isEmpty
                              ? const PokemonsPlaceholder()
                              : ListView.separated(
                                  itemBuilder: (context, index) =>
                                      PokemonListItem(
                                          pokemon: controller.pokemons[index]),
                                  separatorBuilder: (context, index) =>
                                      const Divider(),
                                  itemCount: controller.pokemons.length,
                                ),
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
