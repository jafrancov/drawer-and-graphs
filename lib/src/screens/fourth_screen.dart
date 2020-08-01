import 'package:charts_flutter/flutter.dart' as charts;
import 'package:drawer/api/materia_api.dart';
import 'package:flutter/material.dart';

class BarrasAgrupadas extends StatefulWidget {
  BarrasAgrupadas({Key key}) : super(key: key);

  @override
  _BarrasAgrupadasState createState() => _BarrasAgrupadasState();
}

class _BarrasAgrupadasState extends State<BarrasAgrupadas> {
  ApiService apiservice;
  static List<CalificacionMateria> data;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    apiservice = ApiService();
    getAllMaterias();
  }

  void getAllMaterias() async {
    data = List();
    var materias = await apiservice.getMaterias();
    setState(() {
      materias.forEach((element) {
        data.add(new CalificacionMateria(element.nombre, element.calificacion));
      });
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barras agrupadas'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : GroupedBars.withDataFromApi(),
    );
  }
}

class GroupedBars extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  GroupedBars(this.seriesList, {this.animate});

  factory GroupedBars.withSampleData() {
    return new GroupedBars(
      _createSampleData(),
      animate: false,
    );
  }

  factory GroupedBars.withDataFromApi() {
    return new GroupedBars(
      _createDataFromApi(),
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
      defaultRenderer: new charts.BarRendererConfig(
          groupingType: charts.BarGroupingType.grouped, strokeWidthPx: 2.0),
    );
  }

  static List<charts.Series<CalificacionMateria, String>> _createDataFromApi() {
    return [
      new charts.Series<CalificacionMateria, String>(
        id: 'Calificaciones1',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (CalificacionMateria materias, _) => materias.nombre,
        measureFn: (CalificacionMateria materias, _) => materias.calificacion,
        data: _BarrasAgrupadasState.data,
      ),
      new charts.Series<CalificacionMateria, String>(
        id: 'Calificaciones2',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
//        fillColorFn: (_, __) => charts.MaterialPalette.transparent,
        domainFn: (CalificacionMateria materias, _) => materias.nombre,
        measureFn: (CalificacionMateria materias, _) => materias.calificacion,
        data: _BarrasAgrupadasState.data,
      ),
      new charts.Series<CalificacionMateria, String>(
        id: 'Calificaciones3',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        fillColorFn: (_, __) =>
            charts.MaterialPalette.blue.shadeDefault.lighter,
        domainFn: (CalificacionMateria materias, _) => materias.nombre,
        measureFn: (CalificacionMateria materias, _) => materias.calificacion,
        data: _BarrasAgrupadasState.data,
      ),
    ];
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<CalificacionMateria, String>> _createSampleData() {
    final data = [
      new CalificacionMateria('M1', 85),
      new CalificacionMateria('M2', 95),
      new CalificacionMateria('M3', 100),
      new CalificacionMateria('M4', 90),
    ];

    return [
      new charts.Series<CalificacionMateria, String>(
        id: 'Calificaciones1',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (CalificacionMateria materias, _) => materias.nombre,
        measureFn: (CalificacionMateria materias, _) => materias.calificacion,
        data: data,
      ),
      new charts.Series<CalificacionMateria, String>(
        id: 'Calificaciones2',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
//        fillColorFn: (_, __) => charts.MaterialPalette.transparent,
        domainFn: (CalificacionMateria materias, _) => materias.nombre,
        measureFn: (CalificacionMateria materias, _) => materias.calificacion,
        data: data,
      ),
      new charts.Series<CalificacionMateria, String>(
        id: 'Calificaciones3',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        fillColorFn: (_, __) =>
        charts.MaterialPalette.blue.shadeDefault.lighter,
        domainFn: (CalificacionMateria materias, _) => materias.nombre,
        measureFn: (CalificacionMateria materias, _) => materias.calificacion,
        data: data,
      ),

    ];
  }
}

/// Sample ordinal data type.
class CalificacionMateria {
  final String nombre;
  final int calificacion;

  CalificacionMateria(this.nombre, this.calificacion);
}
