import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework_example/core/pokemon/pokemon_request.dart';
import 'package:clean_framework_example/core/pokemon/pokemon_success_response.dart';
import 'package:clean_framework_example/features/profile/models/pokemon_species_model.dart';

class PokemonSpeciesGateway extends Gateway<
    PokemonSpeciesDomainToGatewayModel,
    PokemonSpeciesRequest,
    PokemonSuccessResponse,
    PokemonSpeciesSuccessDomainInput> {
  @override
  PokemonSpeciesRequest buildRequest(
      PokemonSpeciesDomainToGatewayModel output) {
    return PokemonSpeciesRequest(name: output.name);
  }

  @override
  FailureDomainInput onFailure(FailureResponse failureResponse) {
    return FailureDomainInput(message: failureResponse.message);
  }

  @override
  PokemonSpeciesSuccessDomainInput onSuccess(PokemonSuccessResponse response) {
    return PokemonSpeciesSuccessDomainInput(
      species: PokemonSpeciesModel.fromJson(response.data),
    );
  }
}

class PokemonSpeciesDomainToGatewayModel extends DomainModel {
  PokemonSpeciesDomainToGatewayModel({required this.name});

  final String name;

  @override
  List<Object?> get props => [name];
}

class PokemonSpeciesSuccessDomainInput extends SuccessDomainInput {
  PokemonSpeciesSuccessDomainInput({required this.species});

  final PokemonSpeciesModel species;
}

class PokemonSpeciesRequest extends GetPokemonRequest {
  PokemonSpeciesRequest({required this.name});

  final String name;

  @override
  String get resource => 'pokemon-species/$name';
}
