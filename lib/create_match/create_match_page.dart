import 'package:fantagita/custom%20components/button.dart';
import 'package:fantagita/custom%20components/text_field.dart';
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

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year+1)
    );

    if (_picked != null) {
      setState(() {
        _startDateController.text = _picked.toString().split(" ")[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextField(controller: _nomeGitaController, hintText: "Nome della gita",),
          TextField(
            controller: _startDateController,
            decoration: const InputDecoration(
              labelText: "Data di inizio",
              filled: true,
              prefixIcon: Icon(Icons.calendar_today),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue)
              ),
            ),
            readOnly: true,
            onTap: () {_selectDate();},
          ),
          TextField(
            controller: _startDateController,
            decoration: const InputDecoration(
              labelText: "Data di fine",
              filled: true,
              prefixIcon: Icon(Icons.calendar_today),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue)
              ),
            ),
            readOnly: true,
            onTap: () {_selectDate();},
          ),

          CustomButton(
            onPressed: (){},
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
