// ignore_for_file: unused_local_variable

import 'dart:js_interop' as js;

import 'package:web/web.dart' as web;

void main() {
  // https://dart.dev/interop/js-interop

  const dataKey = 'data';
  final localStorage = web.window.localStorage;

  final input = Input.getById('dataInput');

  final saveButton = Button.getById('saveButton')
    ..addCallback(() {
      final value = savedValue = input.value;
      switch (value) {
        case String text when text.isNotEmpty:
          localStorage.setItem(dataKey, value);
        default:
          localStorage.removeItem(dataKey);
      }
    });

  final loadButton = Button.getById('loadButton')
    ..addCallback(() {
      savedValue = input.value = localStorage.getItem(dataKey) ?? '';
    });

  final clearButton = Button.getById('clearButton')
    ..addCallback(() {
      clearInput();
    });
}

@js.JS()
external String savedValue;

@js.JS()
external void clearInput();

extension type Input._(web.Element _input) implements web.EventTarget, js.JSObject {
  factory Input.getById(String id) {
    final element = web.document.getElementById(id);
    if (element == null) throw UnsupportedError('InputElement with id $id not found');
    return Input._(element);
  }

  /// The current value of the input field.
  external String get value;

  /// Sets the value of the input field.
  external set value(String value);
}

extension type Button._(web.Element _button) implements web.Element {
  factory Button.getById(String id) {
    final element = web.document.getElementById(id);
    if (element == null) throw UnsupportedError('ButtonElement with id $id not found');
    return Button._(element);
  }

  js.JSFunction addCallback(void Function() callback) {
    final callbackJS = (web.Event event) {
      callback();
    }.toJS;
    addEventListener('click', callbackJS);
    return callbackJS;
  }

  void removeCallback(js.JSFunction callback) => removeEventListener('click', callback);
}
