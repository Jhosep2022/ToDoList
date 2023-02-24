import 'package:flutter/material.dart';
import 'package:login2/models/tipotarea.dart';

class AgregarEtiquetas extends StatefulWidget {
  const AgregarEtiquetas({Key? key}) : super(key: key);

  @override
  State<AgregarEtiquetas> createState() => _AgregarEtiquetasState();
}

class _AgregarEtiquetasState extends State<AgregarEtiquetas> {
  List<gesetiqueta> listaetiqueta = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('GESTIONAR ETIQUETA',style: TextStyle(
            fontFamily: 'PermanentMarker',

          ) ,),
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
                  //child: TextField(controller: listaetiqueta[index].name)),
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
            onPressed: _get,
            child: const Icon(Icons.save)
          ),
        ]));
  }

  void _add() {
    setState(() {
      listaetiqueta.add(gesetiqueta());
    });
  }

  void _get() {
    for (var i = 0; i < listaetiqueta.length; i++) {
      print("Campo de texto:");
      //print(listaetiqueta[i].name.text);
      print("Campo de select:");
      print(listaetiqueta[i]._selectedValue);
      print("--------------------------------");
    }
  }

  void _remove(int index) {
    setState(() {
      listaetiqueta.removeAt(index);
    });
  }
}

