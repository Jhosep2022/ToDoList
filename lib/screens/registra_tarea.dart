import 'package:flutter/material.dart';
import 'package:login2/models/tarea.dart';
import 'package:login2/screens/etiquetas.dart';
import 'package:login2/screens/listaTarea.dart';


class nuevaTarea extends StatefulWidget {
  final Tarea tarea;
  final String appbarTitle;
  ListaTareasState listaTareasState;
  int position;

  nuevaTarea(this.tarea, this.appbarTitle, this.listaTareasState, [this.position = -1]);

  @override
  State<nuevaTarea> createState() => NuevaTareaState( this.tarea, this.appbarTitle, this.listaTareasState, this.position);
}

class NuevaTareaState extends State<nuevaTarea> {
  ListaTareasState listaTareasState;
  String titulo;
  Tarea tarea;
  int posicion;
  bool marcado = false;

  NuevaTareaState(this.tarea, this.titulo, this.listaTareasState, this.posicion);

  TextEditingController tareaController = TextEditingController();
  TextEditingController tipoController = TextEditingController();
  TextEditingController _date = TextEditingController();
  List<String> items = ['Trabajo', 'Casa', 'Personal'];
  String? value = 'Trabajo';


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(1),
      child: Scaffold(
        key: GlobalKey<ScaffoldState>(),
        appBar: AppBar(
          leading: GestureDetector(
            child: Icon(Icons.close),
            onTap: () {
              Navigator.pop(context);
              listaTareasState.actualizarLisView();
            },
          ),
          centerTitle: true,
          title: Text('REGISTRA TU TAREA',style: TextStyle(fontFamily: 'PermanentMarker',)),
          backgroundColor: Colors.deepPurpleAccent,
        ),

        body: Form(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      controller: tareaController,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        labelText: 'Tarea',
                        hintText: 'Ejemplo: Lavar los platos',
                        prefixIcon: Icon(Icons.add_task),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                      onChanged: (value) {
                        actualizarTarea();
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(// con esto editamos la lista en base al listado
                      padding: EdgeInsets.only(right: 50.0),
                      child: _estaEditando() ? CheckboxListTile(
                        title: Text('Completada'),
                        value: marcado,
                        onChanged: (bool? value) {
                          setState(() {
                            marcado = value!;
                          });
                        },
                      )
                          :Container(height: 2,)
                  ),
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: TextFormField(
                      controller: _date,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.calendar_today_rounded),
                        labelText: "Fecha de Entrega",
                        hintText: 'Ejemplo: 2021-10-10',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                      onTap: () async{
                        DateTime? pickeddate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100)
                        );

                        if(pickeddate != null){
                          setState(() {
                            _date.text = pickeddate.toString();
                          });
                        }
                      },
                      onChanged: (value) {
                        actualizarTarea();
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 250.0,
                        height: 100.0,
                        child: Container(
                          child: DropdownButtonFormField<String>(
                            value: value,
                            items: items.map((e) => DropdownMenuItem<String>(
                                child: Text(e),
                                value: e)
                            ).toList(),
                            onChanged: (String? newvalue) {
                              setState(() {
                                value = newvalue;

                              });
                              tipoController.text = value!;
                              actualizarTarea();
                            },
                            decoration: const InputDecoration(
                              iconColor: Colors.deepPurpleAccent,
                              labelText: 'Tipo de Tarea', labelStyle: TextStyle(color: Colors.deepPurpleAccent),
                              prefixIcon: Icon(Icons.category,color: Colors.deepPurpleAccent),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              ),
                            ),

                          ),
                        ),
                      ),
                      FloatingActionButton(

                        backgroundColor: Colors.deepPurpleAccent,
                        onPressed: () {
                          final route = MaterialPageRoute(
                              builder: (context) => AgregarEtiquetas());
                          Navigator.push(context, route);

                        },
                        tooltip: 'Gestionar Etiqueta',
                        child: const Icon(Icons.edit),
                      ),
                    ],

                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        disabledColor: Colors.grey,
                        color: Colors.deepPurpleAccent,
                        onPressed: (){
                          setState(() {
                            _guardar();
                          });
                        },
                        child: const Text('Guardar',style: TextStyle(color: Colors.white)),
                      ),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        disabledColor: Colors.grey,
                        color: Colors.deepPurpleAccent,
                        onPressed: (){
                          Navigator.pop(context);
                          listaTareasState.actualizarLisView();
                        },
                        child: const Text('Cancelar',style: TextStyle(color: Colors.white),),
                      ),
                    ],
                  )
                ],
              ),
            )
        ),
      ),
    );
  }

  void _guardar(){
    tarea.estado ="";
    if (_estaEditando()){
      if(marcado){
        tarea.estado = "Completada";
      }
    }
    tarea.nombre = tareaController.text;
    tarea.tipotarea = tipoController.text;
    tarea.tiempo = _date.text;

    if (_comprobarCampos()){
      if (!_estaEditando()) {
        listaTareasState.listaTareas.add(tarea);
      }else{
        listaTareasState.listaTareas[posicion] = tarea;
        listaTareasState.actualizarLisView();
        Navigator.pop(context);
        mostrarSnackBar('Tarea Guardada');
      }
    }
  }
  bool _comprobarCampos(){
    bool res = true;
    if (tareaController.text.isEmpty){
      mostrarSnackBar('El campo de tarea no puede estar vacio');
      res = false;
    }
    return res;
  }
  void mostrarSnackBar(String mensaje){
    final snackBar = SnackBar(
      content: Text(mensaje),
      duration: Duration(seconds: 1, milliseconds: 500),
      backgroundColor: Colors.deepPurpleAccent,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  void actualizarTarea(){
    tarea.nombre = tareaController.text;
    tarea.tipotarea = tipoController.text;
    tarea.tiempo = _date.text;

  }

  bool _estaEditando(){
    bool editando = true;
    if (posicion == -1){
      editando = false;
    }
    return editando;
  }
}

