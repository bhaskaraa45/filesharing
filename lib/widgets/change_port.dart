import 'package:filesharing/colors.dart';
import 'package:filesharing/provider/port_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChangePort extends ConsumerStatefulWidget {
  const ChangePort({Key? key, required this.ports, required this.currentPort})
      : super(key: key);

  final List<int> ports;
  final int currentPort;

  @override
  ConsumerState<ChangePort> createState() => _ChangePortState();
}

class _ChangePortState extends ConsumerState<ChangePort> {
  int selectedPort = 8080;

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedPort = widget.currentPort;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // title: ,
      content: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            Text(
              'Select a port: ',
              style: TextStyle(
                  color: MyColors().textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            DropdownButton<int>(
              underline: Container(),
              value: selectedPort,
              onChanged: (int? value) {
                setState(() {
                  selectedPort = value!;
                });
              },
              items: widget.ports
                  .map<DropdownMenuItem<int>>(
                    (int port) => DropdownMenuItem<int>(
                      value: port,
                      child: Text(port.toString(),
                          style: TextStyle(
                              color: MyColors().textColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w500)),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            ref.watch(portProvider.notifier).state = selectedPort;
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
