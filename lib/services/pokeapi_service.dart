import 'dart:convert';

import 'package:http/http.dart';

class PokeApiConstants {
  PokeApiConstants._();

  static const String baseUrl = 'https://pokeapi.co/api/v2';
  static const String pokemonsEndpoint = '/pokemon';
}

class PokeApiListResponse {
  final int count;
  final String? next;
  final String? previous;
  final List results;

  PokeApiListResponse(
    this.count,
    this.next,
    this.previous,
    this.results,
  );

  factory PokeApiListResponse.fromMap(Map<String, dynamic> map) {
    return PokeApiListResponse(
      map['count'],
      map['next'],
      map['previous'],
      map['results'],
    );
  }
}

class PokeApiService {
  PokeApiService._();

  static Future<PokeApiListResponse> fetchPokemons() async {
    try {
      final Response response = await get(
        Uri.parse(
          '${PokeApiConstants.baseUrl}${PokeApiConstants.pokemonsEndpoint}',
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, Object?> pokemonsResponse = jsonDecode(response.body);
        final PokeApiListResponse pokeApiResponse =
            PokeApiListResponse.fromMap(Map.from(pokemonsResponse));

        return pokeApiResponse;
      } else {
        throw 'Failed to load pokemons';
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<Map<String, dynamic>> fetchPokemonById(String id) async {
    try {
      final Response response = await get(
        Uri.parse(
          '${PokeApiConstants.baseUrl}${PokeApiConstants.pokemonsEndpoint}/$id',
        ),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw 'Failed to load pokemon';
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<Map<String, dynamic>> fetchPokemonByUrl(String url) async {
    try {
      final Response response = await get(
        Uri.parse(url),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw 'Failed to load pokemon';
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
