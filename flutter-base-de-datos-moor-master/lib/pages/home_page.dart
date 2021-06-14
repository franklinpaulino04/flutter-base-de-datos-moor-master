import 'package:bases_datos_moor/pages/update_user_page.dart';
import 'package:flutter/material.dart';

import 'add_user_page.dart';
import 'list_user_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _menuItems = [
    {'label': 'Agregar Usuario', 'route': 0},
    {'label': 'Listar Usuarios', 'route': 1},
//    {'label': 'Actualizar Usuario', 'route': 2},
//    {'label': 'Eliminar Usuario', 'route': 3},
  ];

  int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    // usersBloc.listUsers();
    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD Usuarios con SQLite'),
      ),
      body: _getContentWidget(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.delete),
        onPressed: () {},
      ),
      drawer: Drawer(
        child: ListView(children: _menu(context)),
      ),
    );
  }

  Widget _menuHeader() {
    return DrawerHeader(
      decoration: BoxDecoration(
        //color: Colors.deepOrange,
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.2, 0.5, 0.8, 0.9],
            colors: [Colors.blue, Colors.green, Colors.orange, Colors.red]),
      ),
      child: Center(
        child: CircleAvatar(
          radius: 60.0,
          backgroundColor: Colors.transparent,
          backgroundImage: NetworkImage(
            'https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg',
          ),
        ),
      ),
    );
  }

  Widget menuItem(BuildContext context, Map item) {
    return ListTile(
      title: Text(item['label']),
      leading: Icon(Icons.play_circle_outline),
      onTap: () {
        setState(() {
          print(item['route']);
          _selectedPage = item['route'];
          Navigator.pop(context);
        });
      },
    );
  }

  List<Widget> _menu(BuildContext context) {
    List<Widget> list = List<Widget>();
    list.add(_menuHeader());
    for (Map it in _menuItems) {
      list.add(menuItem(context, it));
    }
    return list;
  }

  Widget _getContentWidget() {
    switch (_selectedPage) {
      case 0:
        return AddUserPage();
      case 1:
        return ListUserPage();
      case 2:
        return UpdatetUserPage();

      default:
        return Center(
            child: Text(
          "Error",
          style: TextStyle(fontSize: 32.0, color: Colors.red),
        ));
    }
  }
}
