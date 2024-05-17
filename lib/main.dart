import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
void main() => runApp( const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  late WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter Simple Example')),
        body: WebView(
          onWebViewCreated: (WebViewController webViewController) {
            _controller = webViewController;
            loadLocalHtml();
          },
          initialUrl: 'about:blank',
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }

  void loadLocalHtml() async {
    String mapHtml = await rootBundle.loadString('assets/web/map.html');
    String mapDataUri = Uri.dataFromString(mapHtml, mimeType: 'text/html').toString();

    _controller.loadUrl(mapDataUri);
  }
}