import 'package:flutter/material.dart';
import 'package:login2/screens/listaTarea.dart';
import '../models/tarea.dart';

final items = ['Trabajo', 'Casa', 'Personal', 'Estudio'];

class nuevaTarea extends StatefulWidget {
  final Tarea tarea;
  final String appbarTitle;
  ListaTareasState listaTareasState;
  int position;

  nuevaTarea(this.tarea, this.appbarTitle, this.listaTareasState,
      [this.position = -1]);

  @override
  State<nuevaTarea> createState() => NuevaTareaState(
      this.tarea, this.appbarTitle, this.listaTareasState, this.position);
}

class NuevaTareaState extends State<nuevaTarea> {
  _AddEtiqueta() {
    setState(() {
      showDialog(
              context: context,
              builder: (context) => _addEtiqueta(tarea: Tarea("", "", "", "")))
          .then(
        (value) {
          setState(() {});
        },
      );
    });
  }

  _EliminarEtiqueta() {
    setState(() {
      showDialog(
          context: context,
          builder: (context) =>
              _eliminarEtiqueta(tarea: Tarea("", "", "", ""))).then(
        (value) {
          setState(() {});
        },
      );
    });
  }

  ListaTareasState listaTareasState;
  String titulo;
  Tarea tarea;
  int posicion;
  bool marcado = false;
  String item = '';

  NuevaTareaState(
      this.tarea, this.titulo, this.listaTareasState, this.posicion);

  TextEditingController tareaController = TextEditingController();
  TextEditingController tipoController = TextEditingController();
  TextEditingController _date = TextEditingController();

  String? value = '';

  @override
  Widget build(BuildContext context) {
    tareaController.text = tarea.nombre;
    tipoController.text = tarea.tipotarea;
    _date.text = tarea.tiempo;
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
          title: Text('REGISTRA TU TAREA',
              style: TextStyle(
                fontFamily: 'PermanentMarker',
              )),
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
              Padding(
                  // con esto editamos la lista en base al listado
                  padding: EdgeInsets.only(right: 50.0),
                  child: _estaEditando()
                      ? CheckboxListTile(
                          title: Text('Completada'),
                          value: marcado,
                          onChanged: (bool? value) {
                            setState(() {
                              marcado = value!;
                            });
                          },
                        )
                      : Container(
                          height: 2,
                        )),
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
                  onTap: () async {
                    DateTime? pickeddate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100));
                    if (pickeddate != null) {
                      setState(() {
                        _date.text = pickeddate.toString();
                        final splitted = _date.text.split(' ');
                        _date.text = splitted[0];
                        tarea.tiempo = _date.text;
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
                    child: Container(child: FormField(
                      builder: (FormFieldState<String> state) {
                        return InputDecorator(
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.category,
                              color: Colors.deepPurpleAccent,
                            ),
                            labelText: 'Tipo de Tarea',
                            labelStyle: TextStyle(
                              color: Colors.deepPurpleAccent,
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                          child: DropdownButton(
                            hint: Text('Etiqueta'),
                            value: item,
                            onChanged: (String? value_new) {
                              setState(() {
                                item = value_new.toString();
                              });
                              tipoController.text = item;
                              tarea.tipotarea = tipoController.text;
                              actualizarTarea();
                            },
                            items: [
                              const DropdownMenuItem(
                                child: Text('Seleccionar Etiqueta'),
                                value: '',
                              ),
                              for (var i = 0; i < items.length; i++)
                                DropdownMenuItem(
                                  child: Text(items[i]),
                                  value: items[i],
                                ),
                            ],
                          ),
                        );
                      },
                    )),
                  ),
                  FloatingActionButton(
                    backgroundColor: Colors.deepPurpleAccent,
                    onPressed: () {
                      setState(() {
                        _AddEtiqueta();
                      });
                    },
                    tooltip: 'Gestionar Etiqueta',
                    child: const Icon(Icons.edit),
                  ),
                  FloatingActionButton(
                    backgroundColor: Colors.deepPurpleAccent,
                    onPressed: () {
                      setState(() {
                        _EliminarEtiqueta();
                      });
                    },
                    tooltip: 'Gestionar Etiqueta',
                    child: const Icon(Icons.delete_forever_rounded),
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
                    onPressed: () {
                      setState(() {
                        _guardar();
                      });
                    },
                    child: const Text('Guardar',
                        style: TextStyle(color: Colors.white)),
                  ),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    disabledColor: Colors.grey,
                    color: Colors.deepPurpleAccent,
                    onPressed: () {
                      Navigator.pop(context);
                      listaTareasState.actualizarLisView();
                    },
                    child: const Text(
                      'Cancelar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          ),
        )),
      ),
    );
  }

  void _guardar() {
    tarea.estado = "";
    if (_estaEditando()) {
      if (marcado) {
        tarea.estado = "Completada";
      }
    }
    tarea.nombre = tareaController.text;
    tarea.tipotarea = tipoController.text;
    tarea.tiempo = _date.text;

    if (_comprobarCampos()) {
      if (!_estaEditando()) {
        listaTareasState.listaTareas.add(tarea);
      } else {
        listaTareasState.listaTareas[posicion] = tarea;
        listaTareasState.actualizarLisView();
        Navigator.pop(context);
        mostrarSnackBar('Tarea Guardada');
      }
    }
  }

  bool _comprobarCampos() {
    bool res = true;
    if (tareaController.text.isEmpty) {
      mostrarSnackBar('El campo de tarea no puede estar vacio');
      res = false;
    }
    return res;
  }

  void mostrarSnackBar(String mensaje) {
    final snackBar = SnackBar(
      content: Text(mensaje),
      duration: Duration(seconds: 1, milliseconds: 500),
      backgroundColor: Colors.deepPurpleAccent,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void actualizarTarea() {
    tarea.nombre = tareaController.text;
    tarea.tipotarea = tipoController.text;
    tarea.tiempo = _date.text;
  }

  bool _estaEditando() {
    bool editando = true;
    if (posicion == -1) {
      editando = false;
    }
    return editando;
  }
}

class _addEtiqueta extends StatefulWidget {
  final Tarea tarea;
  _addEtiqueta({Key? key, required this.tarea}) : super(key: key);

  @override
  State<_addEtiqueta> createState() => _addEtiquetaState();
}

class _addEtiquetaState extends State<_addEtiqueta> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text("Editar Etiqueta"),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          height: MediaQuery.of(context).size.height * 0.4,
          child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: TextFormField(
                    initialValue: items[index],
                    decoration: InputDecoration(
                      hintText: 'Etiqueta',
                      icon: Icon(Icons.edit),
                    ),
                    onChanged: (value) {
                      setState(() {
                        items[index] = value;
                      });
                    },
                  ),
                );
              }),
        ),
        actions: [
          //bototn agregar
          TextButton(
            onPressed: () {
              setState(() {
                items.add("");
              });
            },
            child: Text("Agregar"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text("Salir"),
          )
        ]);
  }
}

class _eliminarEtiqueta extends StatefulWidget {
  final Tarea tarea;
  _eliminarEtiqueta({Key? key, required this.tarea}) : super(key: key);

  @override
  State<_eliminarEtiqueta> createState() => _eliminarEtiquetaState();
}

class _eliminarEtiquetaState extends State<_eliminarEtiqueta> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text("Eliminar Descripción"),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          height: MediaQuery.of(context).size.height * 0.4,
          child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(items[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        items.removeAt(index);
                      });
                    },
                  ),
                );
              }),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text("Salir"),
          ),
        ]);
  }
}
