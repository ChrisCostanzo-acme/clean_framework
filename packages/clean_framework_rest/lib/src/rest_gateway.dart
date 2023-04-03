import 'package:clean_framework/clean_framework.dart';

import 'package:clean_framework_rest/src/rest_requests.dart';
import 'package:clean_framework_rest/src/rest_responses.dart';

abstract class RestGateway<O extends Output, R extends RestRequest,
    S extends SuccessInput> extends Gateway<O, R, RestSuccessResponse, S> {
  @override
  FailureInput onFailure(FailureResponse failureResponse) {
    return FailureInput(message: failureResponse.message);
  }
}