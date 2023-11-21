import 'package:flutter/material.dart';

// import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String? _currency = 'USD';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          // color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            ListTile(
              title: TextField(
                style: TextStyle(
                  fontSize: 24.0,
                ),
                decoration: InputDecoration(
                  labelText: 'Enter Budget',
                ),

                // controller: amountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                // onSubmitted: (_) => _submitData(),
              ),

              // trailing: DropdownButton<String>(
              //   value: _currency,
              //   onChanged: (value) {
              //     setState(() {
              //       _currency = value;
              //     });
              //   },
              //   items: [
              //     DropdownMenuItem(child: Text('USD'), value: 'USD'),
              //     DropdownMenuItem(child: Text('EUR'), value: 'EUR'),
              //     DropdownMenuItem(child: Text('GBP'), value: 'GBP'),
              //   ],
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
