import 'package:daily_expense/Widgets/expense/expense_item.dart';
import 'package:daily_expense/providers/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpenseItems extends ConsumerWidget {
  const ExpenseItems({super.key, this.activeFilter});

  final String? activeFilter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allExpenses = ref.watch(expenseProvider);
    final expenseMethod = ref.read(expenseProvider.notifier);
    final filteredExpenses = expenseMethod.filterExpenseType(activeFilter);

    return ListView.builder(
      itemCount:
          activeFilter != null ? filteredExpenses.length : allExpenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(activeFilter != null
            ? filteredExpenses[index].id
            : allExpenses[index].id),
        direction:
            DismissDirection.horizontal, // Allow swiping in both directions
        background: Container(
          color: Colors.lightBlue, // Sky blue background for editing
          alignment: Alignment.centerLeft, // Align icon to the left
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Icon(
            Icons.edit,
            color: Colors.white,
          ),
        ),
        secondaryBackground: Container(
          color: Colors.red, // Red background for deleting
          alignment: Alignment.centerRight, // Align icon to the right
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
        onDismissed: (direction) {
          if (direction == DismissDirection.endToStart) {
            // If swiped left (delete)
            expenseMethod.onDelete(
                activeFilter != null
                    ? filteredExpenses[index]
                    : allExpenses[index],
                context);
          } else if (direction == DismissDirection.startToEnd) {
            // If swiped right (edit)
            expenseMethod.onEdit(
                activeFilter != null
                    ? filteredExpenses[index]
                    : allExpenses[index],
                context);
          }
        },
        child: ExpenseItem(activeFilter != null
            ? filteredExpenses[index]
            : allExpenses[index]),
      ),
    );
  }
}
