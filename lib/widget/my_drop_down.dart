import 'package:flutter/material.dart';

import '../provider/zk_login_provider.dart';

const List<String> list = <String>[
  'Devnet',
  'Testnet',
  'Mainnet',
];

class MyDropDown extends StatefulWidget {
  const MyDropDown({super.key});

  @override
  State<MyDropDown> createState() => _MyDropDownState();
}

class _MyDropDownState extends State<MyDropDown> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provider.setSuiClient('Devnet');
  }

  String dropdownValue = list.first;
  ZkLoginProvider provider = ZkLoginProvider.getInstance();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 110,
      child: InputDecorator(
        decoration: const InputDecoration(border: OutlineInputBorder()),
        child: DropdownButton<String>(
          dropdownColor: Color(0xff323035),
          underline: const SizedBox(),
          value: dropdownValue,
          items: list.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: const TextStyle(color: Colors.white),
              ),
            );
          }).toList(),
          onChanged: (value) {
            provider.setSuiClient(value!);
          },
        ),
      ),
    );
  }
}
