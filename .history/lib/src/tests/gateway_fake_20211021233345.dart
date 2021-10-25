import 'dart:async';

import 'package:clean_framework/clean_framework_providers.dart';
import 'package:flutter_test/flutter_test.dart';

class GatewayFake extends Fake implements Gateway {
  FailureResponse? failureResponse;
  SuccessResponse? successResponse;
  final Completer hasYielded = Completer();

  @override
  late final Transport<Request, SuccessResponse> transport;

  @override
  onSuccess(response) {
    return SuccessInput();
  }
}

class WatcherGatewayFake<R extends Request, P extends SuccessResponse>
    extends Fake implements WatcherGateway<Output, R, P, SuccessInput> {
  FailureResponse? failureResponse;
  P? _successResponse;
  final Completer<P> hasYielded = Completer();

  P get successResponse => _successResponse!;

  @override
  late final Transport<R, P> transport;

  @override
  onSuccess(response) {
    return SuccessInput();
  }

  @override
  void yieldResponse(P response) {
    _successResponse = response;
    if (!hasYielded.isCompleted) hasYielded.complete(_successResponse);
  }
}