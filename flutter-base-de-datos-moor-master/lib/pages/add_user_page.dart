import 'package:bases_datos_moor/componentes/snack_message.dart';
import 'package:bases_datos_moor/data/moor_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddUserPage extends StatefulWidget {
  @override
  _AddUserPageState createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final _formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();

  final lastnameController = TextEditingController();

  bool _active = true;

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<AppDatabase>(context);

    return Center(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: usernameController,
              validator: (value) {
                return value.isEmpty
                    ? 'El campo username no puede estar vacio'
                    : null;
              },
              decoration: InputDecoration(
                hintText: 'Insert name',
                icon: Icon(Icons.person),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            TextFormField(
              controller: lastnameController,
              validator: (value) {
                return value.isEmpty
                    ? 'El lastname no puede estar vacio'
                    : null;
              },
              decoration: InputDecoration(
                hintText: 'Insert lastname',
                icon: Icon(Icons.info),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            SwitchListTile(
              title: Text('Activo'),
              value: _active,
              onChanged: (bool value){
                setState(() {
                  _active = value;
                });
              },
              secondary: const Icon(Icons.lightbulb_outline,),
            ),
            SizedBox(
              height: 15.0,
            ),
            RaisedButton(
              child: Text('Guardar'),
              onPressed: () {
                if (_formKey.currentState.validate()) {
//                  DBProvider.db
//                      .addUser(UserModel(name: usernameController.text));
                  database.userDao
                      .insertUser(User(name: usernameController.text, lastName: lastnameController.text, active: _active));
                  Scaffold.of(context).showSnackBar(snackMessage(
                      'El usuario ${usernameController.text} ha sido guardado'));
                  _formKey.currentState?.reset();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
