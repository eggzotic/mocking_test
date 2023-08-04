import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mocking_test/mocking/mock_some_setup.dart';

class AppState with ChangeNotifier {
  final _baseUrl = "https://restcountries.com";
  final _pathNz = "/v3.1/name/New%20Zealand?fields=tld";
  final _pathAu = "/v3.1/name/Australia?fields=tld";
  final _pathSg = "/v3.1/name/Singapore?fields=tld";

  late final Dio _dio;
  //
  AppState() {
    _dio = Dio(BaseOptions(baseUrl: _baseUrl));
    // setup the selective-mocking
    MockSomeSetup(
        fromFile: "config.json",
        dio: _dio,
        whenComplete: () {
          _isready = true;
          notifyListeners();
        });
  }
  bool get isReady => _isready;
  bool _isready = false;

  Future<void> fetch() async {
    final responseAu = await _dio.get(_pathAu);
    if (responseAu.statusCode == 200) {
      debugPrint("Response: ${responseAu.data}");
    } else {
      debugPrint("Error code: ${responseAu.statusCode}");
    }
    final responseNz = await _dio.get(_pathNz);
    if (responseNz.statusCode == 200) {
      debugPrint("Response: ${responseNz.data}");
    } else {
      debugPrint("Error code: ${responseNz.statusCode}");
    }
    final responseSg = await _dio.get(_pathSg);
    if (responseNz.statusCode == 200) {
      debugPrint("Response: ${responseSg.data}");
    } else {
      debugPrint("Error code: ${responseSg.statusCode}");
    }
  }
}
