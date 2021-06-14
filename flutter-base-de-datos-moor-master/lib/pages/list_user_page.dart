import 'package:bases_datos_moor/componentes/message_box.dart';
import 'package:bases_datos_moor/componentes/snack_message.dart';
import 'package:bases_datos_moor/data/moor_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListUserPage extends StatefulWidget {
  @override
  _ListUserPageState createState() => _ListUserPageState();
}

class _ListUserPageState extends State<ListUserPage> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<AppDatabase>(context);

    return FutureBuilder<List<User>>(
      future: database.userDao.getAllUsers(),
      builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.data.length == 0) {
          return Center(
            child: Text(
              'No hay usuarios registrados',
              style: TextStyle(fontSize: 28.0, color: Colors.red),
            ),
          );
        }
        return ListView(
          children: _listaMapUsers(context, snapshot.data, database),
        );
      },
    );
  }

  List<Widget> _listaMapUsers(
      BuildContext context, List<User> users, AppDatabase database) {
    return users.map((user) {
      return Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.redAccent,
          child: Row(
            children: [
              Icon(
                Icons.delete_forever,
                color: Colors.white,
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                'ELIMINAR',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        secondaryBackground: Container(
          color: Colors.greenAccent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'ACTUALIZAR',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                width: 10.0,
              ),
              Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ],
          ),
        ),
        onDismissed: (direction) {
          if (direction == DismissDirection.startToEnd) {
            _delete(user, database);
          } else if (direction == DismissDirection.endToStart) {
            _update(user, database);
          }
        },
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(
                Icons.perm_identity,
                color: user.active ? Colors.blue : Colors.grey,
              ),
              title: Text('${user?.name}  ${user?.lastName}'),
              subtitle: Text('CI: ${user.id} creado el ${user.created}'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pushNamed(context, 'user_details', arguments: 'user');
              },
            ),
            Divider(
              thickness: 2.0,
              color: Colors.lightBlue,
              indent: 70.0,
              endIndent: 20.0,
            )
          ],
        ),
      );
    }).toList();
  }

  void _delete(User user, AppDatabase database) {
    messageBox(
        context: context,
        icon: Icons.delete_forever,
        title: '¿Eliminara el usuario?',
        content:
            Text('${user.name.toUpperCase()} ${user.lastName.toUpperCase()}'),
        onPressOkBtn: () {
          setState(() {
            //DBProvider.db.deleteUserById(user.id);
            database.userDao.deleteUser(user);
          });
          Navigator.of(context).pop();
        },
        onPressCancelBtn: () {
          setState(() {});
          Navigator.of(context).pop();
        });
  }

  void _update(User user, AppDatabase database) {
    usernameController.text = user.name;
    lastNameController.text = user.lastName;
    Widget form = Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFormField(
            controller: usernameController,
            validator: (value) {
              return value.isEmpty
                  ? 'El campo username no puede estar vacio'
                  : null;
            },
            decoration: InputDecoration(
              hintText: 'Insert username',
              icon: Icon(Icons.person),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          TextFormField(
            controller: lastNameController,
            validator: (value) {
              return value.isEmpty ? 'El lastName no puede estar vacio' : null;
            },
            decoration: InputDecoration(
              hintText: 'Insert lastname',
              icon: Icon(Icons.info_outline),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          RaisedButton(
            child: Text('Actualizar'),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                //DBProvider.db.updateUser(user);
                database.userDao.updateUser(User(
                    id: user.id,
                    active: user.active,
                    name: usernameController.text,
                    lastName: lastNameController.text,
                    created: user.created));
                setState(() {});
                Scaffold.of(context).showSnackBar(snackMessage(
                    'El usuario ${usernameController.text} ha sido actualizado'));
                _formKey.currentState?.reset();
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
    messageBox(
      context: context,
      icon: Icons.edit,
      title: 'Actualizar el usuario',
      content: form,
      onPressCancelBtn: () {
        setState(() {});
        Navigator.of(context).pop();
      },
    );
  }
}
