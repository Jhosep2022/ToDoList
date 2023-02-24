
class Tarea{
  String _nombre, _tiempo, _tipotarea, _estado;
  Tarea(this._nombre, this._tiempo, this._tipotarea, this._estado);

  String get nombre => _nombre;
  String get tiempo => _tiempo;
  String get tipotarea => _tipotarea;
  String get estado => _estado;

  set nombre(String nuevoNombre) {
    if(nuevoNombre.length <= 255) {
      this._nombre = nuevoNombre;
    }
  }
  set tiempo(String nuevoTiempo)  => this._tiempo = nuevoTiempo;
  set tipotarea(String nuevoTipotarea)  => this._tipotarea = nuevoTipotarea;
  set estado(String nuevoEstado) => this._estado = nuevoEstado;

}