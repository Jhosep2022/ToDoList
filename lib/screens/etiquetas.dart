import 'package:flutter/material.dart';
import 'package:login2/models/tarea.dart';



class AgregarEtiquetas extends StatefulWidget {
  final gesetiqueta listaetiqueta;
  final String appbarTitle;
  int position;

  AgregarEtiquetas(this.listaetiqueta, this.appbarTitle, [this.position = -1]);

  @override
  State<AgregarEtiquetas> createState() => _AgregarEtiquetasState();
}

class _AgregarEtiquetasState extends State<AgregarEtiquetas> {
  List<gesetiqueta> listaetiqueta = [];
  TextEditingController etiquetaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('GESTIONAR ETIQUETA',style: TextStyle(
            fontFamily: 'PermanentMarker',
          )),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: ListView.builder(
          itemCount: listaetiqueta.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.all(20),
              child: Row(children: [
                Expanded(
                  flex: 9,
                  child: TextField(
                      controller: etiquetaController,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        labelText:'Etiqueta',
                        hintText:'Ejemplo: Trabajo',
                        prefixIcon: Icon(Icons.add_task),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                  )
                ),
                Expanded(
                    flex: 2,
                    child: FloatingActionButton(
                      backgroundColor: Colors.deepPurpleAccent,
                      onPressed: () => _remove(index),
                      child: const Icon(Icons.delete)
                    )),
              ]),
            );
          },
        ),
        floatingActionButton:
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          FloatingActionButton(
              backgroundColor: Colors.deepPurpleAccent,
              onPressed: _add,
              child: const Icon(Icons.add)),
          FloatingActionButton(
            backgroundColor: Colors.deepPurpleAccent,
              onPressed: (){
                setState(() {
                  _guardar();
                });
              },
            child: const Icon(Icons.save)
          ),
        ]));
  }
  void _guardar(){
    listaetiqueta.tipoetiqueta = etiquetaController.text;
    Navigator.pop(context, listaetiqueta);
  }

  void _add() {
    setState(() {
      listaetiqueta.add(gesetiqueta(etiquetaController.text));
    });
  }


  void _remove(int index) {
    setState(() {
      listaetiqueta.removeAt(index);
    });
  }
}

