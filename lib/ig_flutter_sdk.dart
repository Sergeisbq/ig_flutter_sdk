import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class IGWebSDKWidget extends StatefulWidget {
  final String videoToken;
  final int age;
  final String gender;
  final void Function(dynamic data)? onReady;
  final void Function(dynamic error)? onError;

  const IGWebSDKWidget({
    required this.videoToken,
    required this.age,
    required this.gender,
    this.onReady,
    this.onError,
    super.key,
  });

  @override
  State<IGWebSDKWidget> createState() => _IGWebSDKWidgetState();
}

class _IGWebSDKWidgetState extends State<IGWebSDKWidget> {
  InAppWebViewController? _controller;

  late final String _base64Config;

  @override
  void initState() {
    super.initState();

    final config = {
      "videoToken": widget.videoToken,
      "age": widget.age,
      "gender": widget.gender,
      // other config you want to pass
    };
    final configString = jsonEncode(config);
    _base64Config = base64Encode(utf8.encode(configString));
  }

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialUrlRequest: URLRequest(
        url: WebUri("https://ig-sdk-host.vercel.app"),
      ),
      initialSettings: InAppWebViewSettings(
        javaScriptEnabled: true,
        mediaPlaybackRequiresUserGesture: false,
        useHybridComposition: true,
      ),
      onWebViewCreated: (controller) {
        _controller = controller;

        controller.addJavaScriptHandler(
          handlerName: 'flutter_inappwebview',
          callback: (args) {
            if (args.isNotEmpty) {
              final data = args[0];
              if (data is Map && data.containsKey('event')) {
                final event = data['event'];
                final payload = data['data'];
                if (event == 'onReady' && widget.onReady != null) {
                  widget.onReady!(payload);
                } else if (event == 'onFailedToLoadPage' &&
                    widget.onError != null) {
                  widget.onError!(payload);
                }
              }
            }
          },
        );
      },
      onLoadStop: (controller, url) async {
        await controller.evaluateJavascript(
          source: '''
          const configJsonParsed = JSON.parse(atob("$_base64Config"));
          window.startSDK(configJsonParsed);
        ''',
        );
      },
      onPermissionRequest: (controller, request) async {
        return PermissionResponse(
          resources: request.resources,
          action: PermissionResponseAction.GRANT,
        );
      },
    );
  }
}
