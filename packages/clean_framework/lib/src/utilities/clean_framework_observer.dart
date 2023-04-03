import 'dart:developer';

import 'package:clean_framework/src/core/external_interface/request.dart';
import 'package:clean_framework/src/core/external_interface/response.dart';
import 'package:clean_framework/src/core/use_case/helpers/input.dart';
import 'package:clean_framework/src/providers/external_interface.dart';
import 'package:meta/meta.dart';

/// The class to observe failures, route changes and other events.
class CleanFrameworkObserver {
  /// Default constructor.
  CleanFrameworkObserver({
    this.enableNetworkLogs = true,
  });

  /// Enables network logs.
  final bool enableNetworkLogs;

  /// Default instance of [CleanFrameworkObserver].
  ///
  /// This can be changed in following way:
  /// ```dart
  /// CleanFrameworkObserver.instance = SubClassOfCleanFrameworkObserver();
  /// ```
  static CleanFrameworkObserver instance = CleanFrameworkObserver();

  /// Called when an [error] is thrown by [ExternalInterface]
  /// for the given [request].
  @mustCallSuper
  void onExternalError(
    Object externalInterface,
    Request request,
    Object error,
    StackTrace stackTrace,
  ) {
    log(
      'Error occurred while requesting "${request.runtimeType}" '
      'for "${externalInterface.runtimeType}"',
      name: 'Clean Framework',
      stackTrace: stackTrace,
      error: error,
    );
  }

  /// Called when a [failureResponse] occurs for the given [request].
  void onFailureResponse(
    Object externalInterface,
    Request request,
    FailureResponse failureResponse,
  ) {}

  /// Called when a [failure] occurs in a gateway.
  void onFailureInput(FailureInput failure) {}

  /// Called when [location] of the route changes.
  void onLocationChanged(String location) {}
}