import 'package:flutter/material.dart';

class WidgetDemo extends StatefulWidget {
  const WidgetDemo({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WidgetDemoState createState() => _WidgetDemoState();
}

class _WidgetDemoState extends State<WidgetDemo> {
  bool _isChecked = false;
  bool _isSwitched = false;
  int _radioValue = 1;
  double _sliderValue = 0.5;
  String _textFieldValue = '';
  String _passwordFieldValue = '';

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        ElevatedButton(
          onPressed: () {
            // Button action
          },
          child: const Text('Elevated Button'),
        ),
        const SizedBox(height: 16),
        const Text('Text Widget'),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Radio<int>(
                value: 1,
                groupValue: _radioValue,
                onChanged: (int? value) {
                  setState(() {
                    _radioValue = value!;
                  });
                },
              ),
            ),
            const Expanded(child: Text('Radio Button')),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Checkbox(
              value: _isChecked,
              onChanged: (bool? value) {
                setState(() {
                  _isChecked = value!;
                });
              },
            ),
            const Text('Checkbox'),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Switch(
              value: _isSwitched,
              onChanged: (bool value) {
                setState(() {
                  _isSwitched = value;
                });
              },
            ),
            const Text('Toggle Button'),
          ],
        ),
        const SizedBox(height: 16),
        const SizedBox(height: 16),
        MaterialButton(
          onPressed: () {
            // Button action
          },
          color: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Radius Button', style: TextStyle(color: Colors.white)),
          ),
        ),
        const SizedBox(height: 16),
        const Icon(Icons.star, size: 50, color: Colors.blue),
        const SizedBox(height: 16),
        TextField(
          decoration: const InputDecoration(labelText: 'Input Field'),
          onChanged: (value) {
            setState(() {
              _textFieldValue = value;
            });
          },
        ),
        const SizedBox(height: 16),
        TextField(
          obscureText: true,
          decoration: const InputDecoration(labelText: 'Password Input Field'),
          onChanged: (value) {
            setState(() {
              _passwordFieldValue = value;
            });
          },
        ),
        const SizedBox(height: 16),
        PopupMenuButton<String>(
          onSelected: (value) {
            // Handle menu selection
          },
          itemBuilder: (BuildContext context) {
            return {'Menu Item 1', 'Menu Item 2', 'Menu Item 3'}
                .map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
          child: const Text('Menu'),
        ),
        const SizedBox(height: 16),
        ListTile(
          leading: const Icon(Icons.info),
          title: const Text('ListTile'),
          subtitle: const Text('Subtitle'),
          trailing: const Icon(Icons.arrow_forward),
          onTap: () {
            // Handle ListTile tap
          },
        ),
        const SizedBox(height: 16),
        Slider(
          value: _sliderValue,
          min: 0,
          max: 1,
          divisions: 10,
          label: '${(_sliderValue * 100).toStringAsFixed(0)}%',
          onChanged: (value) {
            setState(() {
              _sliderValue = value;
            });
          },
        ),
        const SizedBox(height: 16),
        AlertDialog(
          title: const Text('Dialog Title'),
          content: const Text('This is a sample dialog content.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Card(
          elevation: 4,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('This is a Card widget.'),
          ),
        ),
      ],
    );
  }
}
