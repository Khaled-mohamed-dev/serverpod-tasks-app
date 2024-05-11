import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:tasks_flutter/ui/views/create_task/create_task_view.form.dart';

import 'create_task_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: 'task'),
])
class CreateTaskView extends StackedView<CreateTaskViewModel>
    with $CreateTaskView {
  const CreateTaskView({super.key});

  @override
  Widget builder(
    BuildContext context,
    CreateTaskViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              if ((MediaQuery.of(context).viewInsets.bottom > 0)) {
                FocusScope.of(context).unfocus();
              } else {
                viewModel.back();
              }
            },
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black.withOpacity(.3),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Card(
                  color: const Color(0xff2F58E2),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Create new task',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        const SizedBox(height: 24),
                        TextField(
                          controller: taskController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Task Name',
                            hintStyle: TextStyle(color: Colors.grey[200]),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.white,
                              ),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Priority',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            Wrap(
                              spacing: 20,
                              children: ['High', 'Medium', 'Low', 'Very Low']
                                  .map((e) => GestureDetector(
                                        onTap: () {
                                          viewModel.priority = e;
                                        },
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(top: 20),
                                          decoration: BoxDecoration(
                                            color: viewModel.priority == e
                                                ? Colors.white
                                                : const Color(0xff2F58E2),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 1,
                                              style: BorderStyle.solid,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8, horizontal: 20),
                                            child: Text(
                                              e,
                                              style: TextStyle(
                                                fontWeight:
                                                    viewModel.priority == e
                                                        ? FontWeight.w600
                                                        : FontWeight.w400,
                                                color: viewModel.priority != e
                                                    ? Colors.white
                                                    : const Color(0xff2F58E2),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: IconButton(
                            color: Colors.white,
                            onPressed: () {
                              viewModel.createTask();
                            },
                            icon: const Icon(
                              Icons.add,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  CreateTaskViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      CreateTaskViewModel();

  @override
  void onDispose(CreateTaskViewModel viewModel) {
    disposeForm();
    super.onDispose(viewModel);
  }
}

extension DateTimeParse on String {
  DateTime dateTimeParse() {
    List<String> date = split('-');
    var year = date[0];
    var month = int.parse(date[1]) < 10 ? '0${date[1]}' : date[1];
    var day = int.parse(date[2]) < 10 ? '0${date[1]}' : date[1];
    return DateTime.parse('$year-$month-$day');
  }
}

extension DateFormat on DateTime {
  DateTime format() {
    var year = this.year;
    var month = this.month < 10 ? '0${this.month}' : this.month;
    var day = this.day < 10 ? '0${this.day}' : this.day;

    return DateTime.parse('$year-$month-$day');
  }
}
