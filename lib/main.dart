import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomeScreen(),
    );
  }
}

class MyHomeScreen extends StatelessWidget {
  const MyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dio = Dio(BaseOptions(baseUrl: "https://restcountries.com"));
    // final dioAdapter = DioAdapter(dio: dio);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mocking Test"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                debugPrint("You clicked me");
                final response =
                    await dio.get("/v3.1/name/New%20Zealand?fields=tld");
                if (response.statusCode == 200) {
                  debugPrint("RLS response: ${response.data}");
                } else {
                  debugPrint("RLS error code: ${response.statusCode}");
                }
              },
              child: const Text("Real"),
            ),
          ],
        ),
      ),
    );
  }
}
