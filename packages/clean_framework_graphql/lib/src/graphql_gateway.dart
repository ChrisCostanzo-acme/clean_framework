import 'package:clean_framework/clean_framework_legacy.dart';

import 'package:clean_framework_graphql/src/graphql_requests.dart';
import 'package:clean_framework_graphql/src/graphql_responses.dart';

abstract class GraphQLGateway<M extends DomainModel, R extends GraphQLRequest,
        S extends SuccessDomainInput>
    extends Gateway<M, R, GraphQLSuccessResponse, S> {
  GraphQLGateway({
    super.context,
    super.provider,
    super.useCase,
  });

  @override
  FailureDomainInput onFailure(GraphQLFailureResponse failureResponse) {
    return FailureDomainInput(message: failureResponse.message);
  }
}
