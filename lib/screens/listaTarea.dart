import 'package:flutter/material.dart';
import 'package:login2/models/tarea.dart';
import 'package:login2/screens/registra_tarea.dart';
import 'package:login2/widgets/fichatarea.dart';


class ListaTareas extends StatefulWidget {
  const ListaTareas({Key? key}) : super(key: key);
  @override
  State<ListaTareas> createState() => ListaTareasState();
}

class ListaTareasState extends State<ListaTareas> {
  List<Tarea> listaTareas = [];
  @override
  Widget build(BuildContext context) {
    if (listaTareas == null) {
      listaTareas = [];
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('TAREAS PENDIENTES',
            style: TextStyle(fontFamily: 'PermanentMarker',)),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: ListView.builder(
        itemCount: listaTareas.length,
        itemBuilder: (BuildContext context, int posicion) {
          final item = listaTareas[posicion];
          return GestureDetector(
            onTap: () {
              _editaTarea(listaTareas[posicion], this, posicion);
            },
            child: Dismissible(
              background: Container(
                color: Colors.grey,
                child: const Icon(Icons.delete),
              ),
              key: Key(item.nombre),
              onDismissed: (direction) {
                setState(() {
                  listaTareas.removeAt(posicion);
                });
              },
              child: Card(
                margin: const EdgeInsets.all(5.0),
                child: FichaTarea(
                  titulo: item.nombre,
                  subtitulo: item.tiempo,
                  descripcion: item.tipotarea,
                  estado: item.estado,
                ),
              ),
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent,
        tooltip: 'Nueva Tarea',
        child: const Icon(Icons.task),
        onPressed: () {

          _crearTarea(this);
        },

      ),
    );
  }
  void _crearTarea(ListaTareasState obj){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => nuevaTarea(Tarea(" "," "," "," "), 'Nueva Tarea', obj)));
    actualizarLisView();
  }

  void _editaTarea(Tarea tarea, ListaTareasState obj, int posicion) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => nuevaTarea(tarea, 'Editar Tarea', obj, posicion)),
    );
  }
  void eliminar(int posicion){
    this.listaTareas.removeAt(posicion);
    actualizarLisView();
  }
  void actualizarLisView(){
    setState(() {
      listaTareas = listaTareas;
    });
  }


}




