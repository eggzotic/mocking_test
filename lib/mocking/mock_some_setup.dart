import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:mocking_test/mocking/mock_interceptor.dart';
import 'package:mocking_test/mocking/mock_route.dart';

/// {@template MockSomeSetup_doc}
/// Setup mocking, as defined in [fromFile], and insert as interceptors
/// in [dio]. On completion of the setup, [whenComplete] is called to signal
/// to the calling object that it's ready for use
/// {@endtemplate}
class MockSomeSetup {
  final String fromFile;
  final Dio dio;

  /// {@macro MockSomeSetup_doc}
  MockSomeSetup({
    required this.fromFile,
    required this.dio,
    required void Function() whenComplete,
  }) {
    _loadMockingConfig().then((_) => whenComplete());
  }
  //
  Future<void> _loadMockingConfig() async {
    final routes = <String, MockRoute>{};
    try {
      final config = await rootBundle.loadString(fromFile);
      final Map<String, dynamic> jsonData = jsonDecode(config);
      if (jsonData.containsKey("mockPaths")) {
        final pathsData = jsonData['mockPaths'] as List;
        for (var json in pathsData) {
          try {
            final mockPath = MockRoute.fromJson(json);
            routes.addAll({
              "${mockPath.method}:${mockPath.path}": mockPath,
            });
          } catch (e) {
            debugPrint("Warning: could not deserialize mock path: $json");
          }
        }
        dio.interceptors.add(MockInterceptor(routes: routes));
      }
    } catch (e) {
      debugPrint("Error: could not read $fromFile: $e");
    }
  }
}
