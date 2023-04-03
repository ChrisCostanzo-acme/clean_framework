import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework_example/features/home/domain/home_entity.dart';
import 'package:clean_framework_example/features/home/domain/home_ui_output.dart';
import 'package:clean_framework_example/features/home/external_interface/pokemon_collection_gateway.dart';
import 'package:clean_framework_example/features/home/models/pokemon_model.dart';

const _spritesBaseUrl =
    'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites';

class HomeUseCase extends UseCase<HomeEntity> {
  HomeUseCase()
      : super(
          entity: HomeEntity(),
          transformers: [
            HomeUIOutputTransformer(),
            PokemonSearchInputTransformer(),
            LastViewedPokemonInputTransformer(),
          ],
        );

  Future<void> fetchPokemons({bool isRefresh = false}) async {
    if (!isRefresh) {
      entity = entity.copyWith(status: HomeStatus.loading);
    }

    await request<PokemonCollectionGatewayOutput,
        PokemonCollectionSuccessInput>(
      PokemonCollectionGatewayOutput(),
      onSuccess: (success) {
        final pokemons = success.pokemonIdentities.map(_resolvePokemon);

        return entity.copyWith(
          pokemons: pokemons.toList(growable: false),
          status: HomeStatus.loaded,
          isRefresh: isRefresh,
        );
      },
      onFailure: (failure) {
        return entity.copyWith(
          status: HomeStatus.failed,
          isRefresh: isRefresh,
        );
      },
    );

    if (isRefresh) {
      entity = entity.copyWith(isRefresh: false, status: HomeStatus.loaded);
    }
  }

  PokemonModel _resolvePokemon(PokemonIdentity pokemon) {
    return PokemonModel(
      name: pokemon.name.toUpperCase(),
      imageUrl: '$_spritesBaseUrl/pokemon/other/dream-world/${pokemon.id}.svg',
    );
  }
}

class PokemonSearchInput extends Input {
  PokemonSearchInput({required this.name});

  final String name;
}

class HomeUIOutputTransformer
    extends OutputTransformer<HomeEntity, HomeUIOutput> {
  @override
  HomeUIOutput transform(HomeEntity entity) {
    final filteredPokemons = entity.pokemons.where(
      (pokemon) {
        final pokeName = pokemon.name.toLowerCase();
        return pokeName.contains(entity.pokemonNameQuery.toLowerCase());
      },
    );

    return HomeUIOutput(
      pokemons: filteredPokemons.toList(growable: false),
      status: entity.status,
      isRefresh: entity.isRefresh,
      lastViewedPokemon: entity.lastViewedPokemon,
    );
  }
}

class PokemonSearchInputTransformer
    extends InputTransformer<HomeEntity, PokemonSearchInput> {
  @override
  HomeEntity transform(HomeEntity entity, PokemonSearchInput input) {
    return entity.copyWith(pokemonNameQuery: input.name);
  }
}

class LastViewedPokemonInput extends Input {
  LastViewedPokemonInput({required this.name});

  final String name;
}

class LastViewedPokemonInputTransformer
    extends InputTransformer<HomeEntity, LastViewedPokemonInput> {
  @override
  HomeEntity transform(HomeEntity entity, LastViewedPokemonInput input) {
    return entity.copyWith(lastViewedPokemon: input.name);
  }
}