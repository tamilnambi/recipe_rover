import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailedRecipe extends StatefulWidget {
  final String url;
  final String title;
  const DetailedRecipe({super.key, required this.url, required this.title});

  @override
  State<DetailedRecipe> createState() => _DetailedRecipeState();
}

class _DetailedRecipeState extends State<DetailedRecipe> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title),backgroundColor: Colors.white,),
      body: Container(
          color: Colors.white,
          child: SafeArea(child: WebViewWidget(controller: _controller))),
    );
  }
}
