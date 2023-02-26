import 'package:flutter/material.dart';

class FichaTarea extends StatelessWidget {
  final String titulo;
  final String subtitulo;
  final String descripcion;
  final String estado;

  FichaTarea({Key? key, required this.titulo, required this.estado, required this.descripcion, required this.subtitulo }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.cyan[50],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
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
                          fontSize: 25,
                          //fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        subtitulo,
                        style: const TextStyle(
                          fontFamily: 'FredokaOne',
                          color: Colors.deepPurpleAccent,
                          fontSize: 20,
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
                          fontSize: 15,
                          //fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
              )
            ],
          ),
      ),
    );
  }
}
