import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

enum FlashMessageType { warning, success, danger }

class FlashMessageService {
  final context = StackedService.navigatorKey!.currentContext!;

  showMessage(
      {required String title,
      required String message,
      FlashMessageType? type}) {
    Flushbar(
      title: title,
      margin: const EdgeInsets.all(20),
      borderRadius: BorderRadius.circular(15),
      message: message,
      duration: const Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: _flashMessageColor(type),
    ).show(context);
  }

  Color _flashMessageColor(FlashMessageType? type) {
    switch (type) {
      case FlashMessageType.warning:
        return const Color(0xffF59E0B);
      case FlashMessageType.success:
        return const Color(0xff198155);
      case FlashMessageType.danger:
        return const Color(0xffD3180C);
      default:
        return const Color(0xff2F58E2);
    }
  }
}
