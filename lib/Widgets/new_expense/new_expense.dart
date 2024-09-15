import 'package:daily_expense/Widgets/new_expense/form_components/datepicker_field.dart';
import 'package:daily_expense/Widgets/new_expense/form_components/input_field.dart';
import 'package:daily_expense/enums/categories.dart';
import 'package:daily_expense/model/expense_model.dart';
import 'package:flutter/material.dart';

import '../../data/my_expenses.dart';
import '../../enums/expense_type.dart';
import '../feedback/Alert.dart';
import 'form_components/dropdown_field.dart';

class NewExpense extends StatefulWidget {
  const NewExpense(this.onSave,
      {super.key, required this.mode, this.expense, this.display});

  final void Function(ExpenseModel expense) onSave;
  final String mode;
  final ExpenseModel? expense;
  final String? display;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final List<ExpenseModel> expenseList = myExpenses;
  late final ExpenseModel expense;
  late final String mode;

  late TextEditingController titleController;
  late TextEditingController amountController;

  late Categories selectedCategory;
  late ExpenseType selectedType;
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();

    // Initialize the mode and expense
    mode = widget.mode;
    expense = widget.expense ??
        ExpenseModel(
            '', Categories.food, 0, ExpenseType.income, DateTime.now());

    // Initialize the controllers with existing values or defaults
    titleController =
        TextEditingController(text: mode == 'edit' ? expense.title : '');
    amountController = TextEditingController(
        text: mode == 'edit' ? expense.amount.toString() : '');

    // Initialize other fields
    selectedCategory = mode == 'edit' ? expense.category : Categories.food;
    selectedType = mode == 'edit' ? expense.type : ExpenseType.income;
    selectedDate = mode == 'edit' ? expense.createAt : DateTime.now();
  }

  void onSelectCategory(Enum value) {
    setState(() {
      selectedCategory = value as Categories;
    });
  }

  void onSelectType(Enum value) {
    setState(() {
      selectedType = value as ExpenseType;
    });
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
      context: context,
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  void onSaveAction() {
    bool titleIsInvalid = titleController.text.isEmpty;
    bool amountIsInvalid = amountController.text.isEmpty;

    if (titleIsInvalid || amountIsInvalid) {
      showDialog(context: context, builder: (ctx) => Alert(ctx));
    } else {
      ExpenseModel expense = ExpenseModel(
        titleController.text,
        selectedCategory,
        double.parse(amountController.text),
        selectedType,
        selectedDate,
      );
      widget.onSave(expense);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget title = const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Text(
        'Add new expense',
        textAlign: TextAlign.left,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );

    if (widget.display == 'screen') {
      title = const SizedBox();
    }

    return Container(
      // 80% of screen height
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(16, 38, 50, 1),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title,
          InputField(
            inputController: titleController,
            label: 'Title',
          ),
          DropDownField(
            onSelect: onSelectCategory,
            label: 'Category',
            data: Categories.values,
            value: selectedCategory,
          ),
          InputField(
            inputController: amountController,
            label: 'Amount',
            type: 'number',
          ),
          DropDownField(
            onSelect: onSelectType,
            label: 'Type',
            data: ExpenseType.values,
            value: selectedType,
          ),
          DatePickerField(
            onSelectDate: _presentDatePicker,
            dateValue: selectedDate,
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: const Size(100, 55),
              ),
              onPressed: onSaveAction,
              child: Text(
                mode == 'new' ? 'Save' : 'Update',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Dispose of the controllers when the widget is disposed of
    titleController.dispose();
    amountController.dispose();
    super.dispose();
  }
}
