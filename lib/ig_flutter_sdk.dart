import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class IGWebSDKWidget extends StatefulWidget {
  final String videoToken;

  // Optional params
  final String? containerId;
  final String? clientId;
  final int? age;
  final String? gender;
  final String? showResults;
  final bool? noDesign;
  final bool? faceOutline;
  final String? buttonBgColor;
  final String? buttonTextColor;
  final bool? isVoiceAnalysisOn;
  final String? voiceAnalysisType;
  final bool? forceFrontCamera;
  final bool? showDisclaimer;
  final int? height;
  final int? weight;
  final bool? smoker;
  final bool? hypertension;
  final bool? bpMedication;
  final int? diabetic;
  final int? waistCircumference;
  final bool? heartDisease;
  final bool? depression;
  final int? totalCholesterol;
  final int? hdl;
  final int? parentalHypertension;
  final bool? physicalActivity;
  final bool? healthyDiet;
  final bool? antiHypertensive;
  final bool? historyBloodGlucose;
  final int? historyFamilyDiabetes;

  // Callbacks
  final void Function(dynamic data)? onReady;
  final void Function(dynamic data)? onAnalysisStart;
  final void Function(dynamic data)? onHealthAnalysisFinished;
  final void Function(dynamic data)? onFailedToGetHealthAnalysisResults;
  final void Function(dynamic data)? onVoiceAnalysisFinished;
  final void Function(dynamic data)? onFailedToGetVoiceAnalysisResults;
  final void Function(dynamic data)? onFailedToGetResults;
  final void Function(dynamic data)? videoElementDimensions;
  final void Function(dynamic data)? scanTimeRemaining;
  final void Function(dynamic data)? conditionStatus;
  final void Function(dynamic data)? onFailedToLoadPage;
  final void Function(dynamic error)? onError;

  const IGWebSDKWidget({
    required this.videoToken,
    this.containerId,
    this.clientId,
    this.age,
    this.gender,
    this.showResults,
    this.noDesign,
    this.faceOutline,
    this.buttonBgColor,
    this.buttonTextColor,
    this.isVoiceAnalysisOn,
    this.voiceAnalysisType,
    this.forceFrontCamera,
    this.showDisclaimer,
    this.height,
    this.weight,
    this.smoker,
    this.hypertension,
    this.bpMedication,
    this.diabetic,
    this.waistCircumference,
    this.heartDisease,
    this.depression,
    this.totalCholesterol,
    this.hdl,
    this.parentalHypertension,
    this.physicalActivity,
    this.healthyDiet,
    this.antiHypertensive,
    this.historyBloodGlucose,
    this.historyFamilyDiabetes,
    this.onReady,
    this.onAnalysisStart,
    this.onHealthAnalysisFinished,
    this.onFailedToGetHealthAnalysisResults,
    this.onVoiceAnalysisFinished,
    this.onFailedToGetVoiceAnalysisResults,
    this.onFailedToGetResults,
    this.videoElementDimensions,
    this.scanTimeRemaining,
    this.conditionStatus,
    this.onFailedToLoadPage,
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

    final Map<String, dynamic> config = {
      "videoToken": widget.videoToken,
      if (widget.age != null) "age": widget.age,
      if (widget.gender != null) "gender": widget.gender,
      if (widget.clientId != null) "clientId": widget.clientId,
      if (widget.noDesign != null) "noDesign": widget.noDesign,
      if (widget.buttonBgColor != null) "buttonBgColor": widget.buttonBgColor,
      if (widget.buttonTextColor != null)
        "buttonTextColor": widget.buttonTextColor,
      if (widget.containerId != null) "containerId": widget.containerId,
      if (widget.faceOutline != null) "faceOutline": widget.faceOutline,
      if (widget.showResults != null) "showResults": widget.showResults,
      if (widget.isVoiceAnalysisOn != null)
        "isVoiceAnalysisOn": widget.isVoiceAnalysisOn,
      if (widget.voiceAnalysisType != null)
        "voiceAnalysisType": widget.voiceAnalysisType,
      if (widget.forceFrontCamera != null)
        "forceFrontCamera": widget.forceFrontCamera,
      if (widget.showDisclaimer != null)
        "showDisclaimer": widget.showDisclaimer,
      if (widget.height != null) "height": widget.height,
      if (widget.weight != null) "weight": widget.weight,
      if (widget.smoker != null) "smoker": widget.smoker,
      if (widget.hypertension != null) "hypertension": widget.hypertension,
      if (widget.bpMedication != null) "bpMedication": widget.bpMedication,
      if (widget.diabetic != null) "diabetic": widget.diabetic,
      if (widget.waistCircumference != null)
        "waistCircumference": widget.waistCircumference,
      if (widget.heartDisease != null) "heartDisease": widget.heartDisease,
      if (widget.depression != null) "depression": widget.depression,
      if (widget.totalCholesterol != null)
        "totalCholesterol": widget.totalCholesterol,
      if (widget.hdl != null) "hdl": widget.hdl,
      if (widget.parentalHypertension != null)
        "parentalHypertension": widget.parentalHypertension,
      if (widget.physicalActivity != null)
        "physicalActivity": widget.physicalActivity,
      if (widget.healthyDiet != null) "healthyDiet": widget.healthyDiet,
      if (widget.antiHypertensive != null)
        "antiHypertensive": widget.antiHypertensive,
      if (widget.historyBloodGlucose != null)
        "historyBloodGlucose": widget.historyBloodGlucose,
      if (widget.historyFamilyDiabetes != null)
        "historyFamilyDiabetes": widget.historyFamilyDiabetes,
    };

    final configString = jsonEncode(config);
    _base64Config = base64Encode(utf8.encode(configString));
  }

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialUrlRequest: URLRequest(
        url: WebUri("https://d7l7gdulxyf5g.cloudfront.net/flutter.html"),
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

                switch (event) {
                  case 'onReady':
                    if (widget.onReady != null) widget.onReady!(payload);
                    break;
                  case 'onAnalysisStart':
                    if (widget.onAnalysisStart != null)
                      widget.onAnalysisStart!(payload);
                    break;
                  case 'onHealthAnalysisFinished':
                    if (widget.onHealthAnalysisFinished != null)
                      widget.onHealthAnalysisFinished!(payload);
                    break;
                  case 'onFailedToGetHealthAnalysisResults':
                    if (widget.onFailedToGetHealthAnalysisResults != null)
                      widget.onFailedToGetHealthAnalysisResults!(payload);
                    break;
                  case 'onVoiceAnalysisFinished':
                    if (widget.onVoiceAnalysisFinished != null)
                      widget.onVoiceAnalysisFinished!(payload);
                    break;
                  case 'onFailedToGetVoiceAnalysisResults':
                    if (widget.onFailedToGetVoiceAnalysisResults != null)
                      widget.onFailedToGetVoiceAnalysisResults!(payload);
                    break;
                  case 'onFailedToGetResults':
                    if (widget.onFailedToGetResults != null)
                      widget.onFailedToGetResults!(payload);
                    break;
                  case 'videoElementDimensions':
                    if (widget.videoElementDimensions != null)
                      widget.videoElementDimensions!(payload);
                    break;
                  case 'scanTimeRemaining':
                    if (widget.scanTimeRemaining != null)
                      widget.scanTimeRemaining!(payload);
                    break;
                  case 'conditionStatus':
                    if (widget.conditionStatus != null)
                      widget.conditionStatus!(payload);
                    break;
                  case 'onFailedToLoadPage':
                    if (widget.onFailedToLoadPage != null)
                      widget.onFailedToLoadPage!(payload);
                    break;
                  default:
                    if (widget.onError != null)
                      widget.onError!("Unknown event: $event");
                    break;
                }
              } else {
                if (widget.onError != null)
                  widget.onError!("Invalid event data structure");
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
