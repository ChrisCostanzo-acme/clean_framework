import 'dart:async';

import 'package:clean_framework/clean_framework_legacy.dart';
import 'package:flutter_test/flutter_test.dart';

class GatewayFake<R extends Request, P extends SuccessResponse> extends Fake
    implements Gateway<DomainModel, R, P, SuccessDomainInput> {
  FailureResponse? failureResponse;
  SuccessResponse? successResponse;
  final Completer<void> hasYielded = Completer();

  @override
  late final Transport<R, P> transport;
}

class WatcherGatewayFake<R extends Request, P extends SuccessResponse>
    extends Fake
    implements WatcherGateway<DomainModel, R, P, SuccessDomainInput> {
  FailureResponse? failureResponse;
  P? _successResponse;
  final Completer<P> hasYielded = Completer();

  P get successResponse => _successResponse!;

  @override
  late final Transport<R, P> transport;

  @override
  void yieldResponse(P response) {
    _successResponse = response;
    if (!hasYielded.isCompleted) hasYielded.complete(_successResponse);
  }
}
