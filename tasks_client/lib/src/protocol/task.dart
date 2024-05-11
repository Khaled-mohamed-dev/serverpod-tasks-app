/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

/// Holds a note with a text written by the user.
abstract class Task extends _i1.SerializableEntity {
  Task._({
    this.id,
    required this.text,
    required this.priority,
    required this.date,
    required this.isChecked,
  });

  factory Task({
    int? id,
    required String text,
    required String priority,
    required DateTime date,
    required bool isChecked,
  }) = _TaskImpl;

  factory Task.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return Task(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      text: serializationManager.deserialize<String>(jsonSerialization['text']),
      priority: serializationManager
          .deserialize<String>(jsonSerialization['priority']),
      date:
          serializationManager.deserialize<DateTime>(jsonSerialization['date']),
      isChecked: serializationManager
          .deserialize<bool>(jsonSerialization['isChecked']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// The contents of the note.
  String text;

  String priority;

  DateTime date;

  bool isChecked;

  Task copyWith({
    int? id,
    String? text,
    String? priority,
    DateTime? date,
    bool? isChecked,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'text': text,
      'priority': priority,
      'date': date.toJson(),
      'isChecked': isChecked,
    };
  }
}

class _Undefined {}

class _TaskImpl extends Task {
  _TaskImpl({
    int? id,
    required String text,
    required String priority,
    required DateTime date,
    required bool isChecked,
  }) : super._(
          id: id,
          text: text,
          priority: priority,
          date: date,
          isChecked: isChecked,
        );

  @override
  Task copyWith({
    Object? id = _Undefined,
    String? text,
    String? priority,
    DateTime? date,
    bool? isChecked,
  }) {
    return Task(
      id: id is int? ? id : this.id,
      text: text ?? this.text,
      priority: priority ?? this.priority,
      date: date ?? this.date,
      isChecked: isChecked ?? this.isChecked,
    );
  }
}
