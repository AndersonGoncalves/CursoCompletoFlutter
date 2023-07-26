import 'package:despesas_pessoais/components/adaptative_button.dart';
import 'package:despesas_pessoais/components/adaptative_date_picker.dart';
import 'package:despesas_pessoais/components/adaptative_text_field.dart';
import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit, {super.key}) {
    print('Constructor TransactionForm');
  }

  @override
  State<TransactionForm> createState() {
    print('createState() TransactionForm');
    return _TransactionFormState();
  }
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime? _selectedDate = DateTime.now();

  _TransactionFormState() {
    print('_TransactionFormState() TransactionForm');
  }

  ///Chamado uma vez para o componente
  ///Usado com maior frequencia, sempre que precisar carregar
  ///alguma coisa no estado do componente
  @override
  void initState() {
    super.initState();
    print('initState() _TransactionFormState');
  }

  ///Serve para comparar o Widget antigo e o novo
  @override
  void didUpdateWidget(TransactionForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    //widget //Acesso ao componente novo (Widget atual)
    //oldWidget //Componente antigo (pega um atributo antes de criar a arvode de elementos nova)
    print('didUpdateWidget() _TransactionFormState');
  }

  //Chamado quando fecha o formulario
  @override
  void dispose() {
    super.dispose();
    print('dispose() _TransactionFormState');
  }

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }

    widget.onSubmit(title, value, _selectedDate!);
  }

  @override
  Widget build(BuildContext context) {
    print('build() _TransactionFormState');
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AdaptaviveTextField(
                label: 'Título',
                controller:
                    _titleController, //onChanged: (newTitle) => _titleController.text = newTitle,
                onSubmitted: (_) => _submitForm(),
              ),
              AdaptaviveTextField(
                label: 'Valor (R\$)',
                controller: _valueController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitForm(),
              ),
              AdaptativeDatePicker(
                selectedDate: _selectedDate,
                onDateChanged: (newDate) {
                  setState(() {
                    _selectedDate = newDate;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: AdaptativeButton(
                      'Nova Transação',
                      _submitForm,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
