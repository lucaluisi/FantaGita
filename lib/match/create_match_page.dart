import 'package:fantagita/custom%20components/button.dart';
import 'package:fantagita/custom%20components/text_field.dart';
import 'package:fantagita/services/database_service.dart';
import 'package:flutter/material.dart';

class CreateMatchPage extends StatefulWidget {
  const CreateMatchPage({super.key});

  @override
  State<CreateMatchPage> createState() => _CreateMatchPageState();
}

class _CreateMatchPageState extends State<CreateMatchPage> {
  final _nomeGitaController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();

  Future<void> _selectStartDate() async {
    DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 1));

    if (_picked != null) {
      setState(() {
        _startDateController.text = _picked.toString().split(" ")[0];
        _endDateController.text = _picked.toString().split(" ")[0];
      });
    }
  }

  Future<void> _selectEndDate() async {
    DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.tryParse(_startDateController.text) as DateTime,
        firstDate: DateTime.tryParse(_startDateController.text) as DateTime,
        lastDate: DateTime(DateTime.now().year + 1));

    if (_picked != null) {
      setState(() {
        _endDateController.text = _picked.toString().split(" ")[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextField(
            controller: _nomeGitaController,
            hintText: "Nome della gita",
          ),
          TextField(
            controller: _startDateController,
            decoration: const InputDecoration(
              labelText: "Data di inizio",
              filled: true,
              prefixIcon: Icon(Icons.calendar_today),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue)),
            ),
            readOnly: true,
            onTap: _selectStartDate,
          ),
          TextField(
            controller: _endDateController,
            decoration: const InputDecoration(
              labelText: "Data di fine",
              filled: true,
              prefixIcon: Icon(Icons.calendar_today),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue)),
            ),
            readOnly: true,
            onTap: _selectEndDate,
          ),
          CustomButton(
            onPressed: () {
              Database().createMatch(_nomeGitaController.text, _startDateController.text, _endDateController.text);
            },
            child: const Text(
              "Crea",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
