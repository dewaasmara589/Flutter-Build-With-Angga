import 'package:d_input/d_input.dart';
import 'package:d_method/d_method.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management_provider/providers/person_provider.dart';

class PersonPage extends StatefulWidget{
  const PersonPage({super.key});

  @override
  State<StatefulWidget> createState() => _PersonPageSatate();
}

class _PersonPageSatate extends State<PersonPage>{
  final edtName = TextEditingController();
  final edtAge = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PersonProvider(),
      // TODO Required add Builder before Scaffold
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Person'),
              centerTitle: true,
            ),
            body: ListView(
              padding: EdgeInsetsGeometry.all(20),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: DInput(
                        controller: edtName,
                        fillColor: Colors.blue[100],
                        hint: 'Name',
                        validator: (input) => input == '' ? "Don't leave empty" : null,
                      )
                    ),
                    IconButton(
                      onPressed: () {
                        if (edtName.text != ''){
                          DMethod.log('+' * 30);
                          context.read<PersonProvider>().updateName(edtName.text);
                        }
                      },
                      icon: Icon(Icons.save),
                    )
                  ],
                ),
                SizedBox(height: 10.0,),
                Row(
                  children: [
                    Expanded(
                      child: DInput(
                        controller: edtAge,
                        fillColor: Colors.blue[100],
                        hint: 'Age',
                        validator: (input) => input == '' ? "Don't leave empty" : null,
                      )
                    ),
                    IconButton(
                      onPressed: () {
                        if (edtAge.text != '') {
                          DMethod.log('-' * 30);
                          context.read<PersonProvider>().updateAge(int.parse(edtAge.text));
                        }
                      },
                      icon: Icon(Icons.save),
                    )
                  ],
                ),
                SizedBox(height: 20.0,),
                Builder(
                  builder: (context) {
                    DMethod.log('Build Name');
                    // String name = context.watch<PersonProvider>().data.name;

                    // Lebih baik gunakan select untuk spesifik object
                    String name = context.select((PersonProvider value) => value.data.name);
                    return Text('Name: $name');
                  }
                ),
                Builder(
                  builder: (context) {
                    DMethod.log('Build Age');
                    // int age = context.watch<PersonProvider>().data.age;

                    // Lebih baik gunakan select untuk spesifik object
                    int age = context.select<PersonProvider, int>((value) => value.data.age);
                    return Text('Age: $age');
                  }
                ),
              ],
            ),
          );
        }
      ),
    );
  }

}