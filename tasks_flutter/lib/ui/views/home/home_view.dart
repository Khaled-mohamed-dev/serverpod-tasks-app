import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tasks_client/tasks_client.dart';
import 'package:tasks_flutter/app/app.locator.dart';
import 'package:tasks_flutter/hero_dialogue_route.dart';
import 'package:tasks_flutter/ui/views/create_task/create_task_view.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({super.key});

  @override
  void onViewModelReady(HomeViewModel viewModel) {
    viewModel.fetchTasks();
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffF5F7FA),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // viewModel.goToCreateTask();
            Navigator.push(
              context,
              HeroDialogRoute(
                builder: (context) => const CreateTaskView(),
              ),
            );
          },
          backgroundColor: const Color(0xff2F58E2),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          label: const Text('Create task'),
          icon: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(32, 32, 32, 12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(viewModel.date.formatDate()),
                      const SizedBox(height: 8),
                      const Text(
                        'Tasks',
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                  MaterialButton(
                    padding: const EdgeInsets.all(0),
                    shape: const CircleBorder(),
                    onPressed: () async {
                      var newDate = await showDatePicker(
                        context: context,
                        initialDate: viewModel.date,
                        firstDate:
                            DateTime.now().subtract(const Duration(days: 365)),
                        lastDate: DateTime.now().add(
                          const Duration(days: 365),
                        ),
                      );
                      viewModel.changeDate(newDate ?? viewModel.date);
                    },
                    color: const Color(0xff58D4F1),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.date_range_rounded,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Row(
                  children: [
                    FilterStatus(text: 'All'),
                    SizedBox(width: 20),
                    FilterStatus(text: 'Completed'),
                    SizedBox(width: 20),
                    FilterStatus(text: 'Not completed'),
                  ],
                ),
              ),
              Expanded(
                child: Builder(
                  builder: (context) {
                    if (viewModel.isBusy) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (viewModel.hasError) {
                      return Center(child: Text(viewModel.modelError.body));
                    }

                    List<Task> tasks = viewModel.tasks;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: tasks.length,
                      itemBuilder: (_, index) {
                        return TaskCard(
                          task: tasks[index],
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      locator<HomeViewModel>();
}

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.task,
  });
  final Task task;

  @override
  Widget build(BuildContext context) {
    var viewModel = getParentViewModel<HomeViewModel>(context, listen: false);
    bool isChecked = task.isChecked;
    return GestureDetector(
      onTap: () {
        viewModel.editTask(task.copyWith(isChecked: !isChecked));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(25)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16),
          child: Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Transform.scale(
                  scale: 1.2,
                  child: IgnorePointer(
                    child: Checkbox(
                      fillColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.selected)) {
                          return const Color(0xff1AFF00);
                        }
                        return Colors.grey;
                      }),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      value: isChecked,
                      onChanged: (bool? value) {},
                    ),
                  ),
                ),
              ),
              AnimatedContainer(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: 4,
                height: 48,
                decoration: BoxDecoration(
                  color: !isChecked
                      ? const Color(0xffFF006F)
                      : const Color(0xff1AFF00),
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                        color: !isChecked
                            ? const Color(0xffFF006F)
                            : const Color(0xff1AFF00),
                        blurRadius: 10)
                  ],
                ),
                duration: const Duration(milliseconds: 350),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.text,
                      style: TextStyle(
                        fontSize: 14,
                        decoration: isChecked
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      task.priority,
                      style: TextStyle(
                        color: getPriorityColor(task.priority),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {
                    viewModel.deleteTask(task);
                  },
                  icon: const Icon(Icons.remove))
            ],
          ),
        ),
      ),
    );
  }
}

Color getPriorityColor(String priority) {
  if (priority == 'High') {
    return const Color(0xffD3180C);
  } else if (priority == 'Medium') {
    return const Color(0xffF59E0B);
  } else if (priority == 'Low') {
    return const Color(0xff198155);
  }
  return Colors.grey;
}

class FilterStatus extends StatelessWidget {
  const FilterStatus({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    var viewModel = getParentViewModel<HomeViewModel>(context);
    bool isSelected = viewModel.filter == text;
    return GestureDetector(
      onTap: () {
        viewModel.changeFilter(text);
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xff2F58E2) : Colors.transparent,
          border:
              !isSelected ? Border.all(color: const Color(0xff2F58E2)) : null,
          borderRadius: BorderRadius.circular(
            8,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : const Color(0xff2F58E2),
              fontWeight: isSelected ? FontWeight.bold : null,
            ),
          ),
        ),
      ),
    );
  }
}
