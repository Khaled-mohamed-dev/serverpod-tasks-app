// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String TaskValueKey = 'task';

final Map<String, TextEditingController> _CreateTaskViewTextEditingControllers =
    {};

final Map<String, FocusNode> _CreateTaskViewFocusNodes = {};

final Map<String, String? Function(String?)?> _CreateTaskViewTextValidations = {
  TaskValueKey: null,
};

mixin $CreateTaskView {
  TextEditingController get taskController =>
      _getFormTextEditingController(TaskValueKey);

  FocusNode get taskFocusNode => _getFormFocusNode(TaskValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_CreateTaskViewTextEditingControllers.containsKey(key)) {
      return _CreateTaskViewTextEditingControllers[key]!;
    }

    _CreateTaskViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _CreateTaskViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_CreateTaskViewFocusNodes.containsKey(key)) {
      return _CreateTaskViewFocusNodes[key]!;
    }
    _CreateTaskViewFocusNodes[key] = FocusNode();
    return _CreateTaskViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    taskController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    taskController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          TaskValueKey: taskController.text,
        }),
    );

    if (_autoTextFieldValidation || forceValidate) {
      updateValidationData(model);
    }
  }

  bool validateFormFields(FormViewModel model) {
    _updateFormData(model, forceValidate: true);
    return model.isFormValid;
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller in _CreateTaskViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _CreateTaskViewFocusNodes.values) {
      focusNode.dispose();
    }

    _CreateTaskViewTextEditingControllers.clear();
    _CreateTaskViewFocusNodes.clear();
  }
}

extension ValueProperties on FormStateHelper {
  bool get hasAnyValidationMessage => this
      .fieldsValidationMessages
      .values
      .any((validation) => validation != null);

  bool get isFormValid {
    if (!_autoTextFieldValidation) this.validateForm();

    return !hasAnyValidationMessage;
  }

  String? get taskValue => this.formValueMap[TaskValueKey] as String?;

  set taskValue(String? value) {
    this.setData(
      this.formValueMap..addAll({TaskValueKey: value}),
    );

    if (_CreateTaskViewTextEditingControllers.containsKey(TaskValueKey)) {
      _CreateTaskViewTextEditingControllers[TaskValueKey]?.text = value ?? '';
    }
  }

  bool get hasTask =>
      this.formValueMap.containsKey(TaskValueKey) &&
      (taskValue?.isNotEmpty ?? false);

  bool get hasTaskValidationMessage =>
      this.fieldsValidationMessages[TaskValueKey]?.isNotEmpty ?? false;

  String? get taskValidationMessage =>
      this.fieldsValidationMessages[TaskValueKey];
}

extension Methods on FormStateHelper {
  setTaskValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[TaskValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    taskValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      TaskValueKey: getValidationMessage(TaskValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _CreateTaskViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _CreateTaskViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      TaskValueKey: getValidationMessage(TaskValueKey),
    });
