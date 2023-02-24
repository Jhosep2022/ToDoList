import 'package:flutter/material.dart';

class FichaTarea extends StatelessWidget {
  final String titulo;
  final String subtitulo;
  final String descripcion;
  final String estado;

  FichaTarea({Key? key, required this.titulo, required this.estado, required this.descripcion, required this.subtitulo }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(15),
        child: Row(
          children: <Widget>[
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      titulo,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: 'FredokaOne',
                        fontSize: 20,
                        //fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      subtitulo,
                      style: const TextStyle(
                        fontFamily: 'FredokaOne',
                        color: Colors.deepPurpleAccent,
                        fontSize: 15,
                        //fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      descripcion,
                      style: const TextStyle(
                        fontFamily: 'FredokaOne',
                        fontStyle: FontStyle.italic,
                        color: Colors.deepPurpleAccent,
                        fontSize: 15,
                        //fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      estado,
                      style: const TextStyle(
                        fontFamily: 'FredokaOne',
                        fontStyle: FontStyle.italic,
                        color: Colors.blue,
                        fontSize: 10,
                        //fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
            )
          ],
        ),
    );
  }
}
