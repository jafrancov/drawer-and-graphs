import 'package:charts_flutter/flutter.dart' as charts;
import 'package:drawer/api/materia_api.dart';
import 'package:flutter/material.dart';

class BarrasRedondeadas extends StatefulWidget {
  BarrasRedondeadas({Key key}) : super(key: key);

  @override
  _BarrasRedondeadasState createState() => _BarrasRedondeadasState();
}

class _BarrasRedondeadasState extends State<BarrasRedondeadas> {
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
        title: Text('Barras redondeadas'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : CustomRoundedBars.withDataFromApi(),
    );
  }
}

class CustomRoundedBars extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  CustomRoundedBars(this.seriesList, {this.animate});

  factory CustomRoundedBars.withSampleData() {
    return new CustomRoundedBars(
      _createSampleData(),
      animate: false,
    );
  }

  factory CustomRoundedBars.withDataFromApi() {
    return new CustomRoundedBars(
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
          cornerStrategy: const charts.ConstCornerStrategy(30)),
    );
  }

  static List<charts.Series<CalificacionMateria, String>> _createDataFromApi() {
    return [
      new charts.Series<CalificacionMateria, String>(
        id: 'Calificaciones',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (CalificacionMateria materias, _) => materias.nombre,
        measureFn: (CalificacionMateria materias, _) => materias.calificacion,
        data: _BarrasRedondeadasState.data,
      )
    ];
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<CalificacionMateria, String>> _createSampleData() {
    final data = [
      new CalificacionMateria('M1', 5),
      new CalificacionMateria('M2', 25),
      new CalificacionMateria('M3', 100),
      new CalificacionMateria('M4', 75),
    ];

    return [
      new charts.Series<CalificacionMateria, String>(
        id: 'Calificaciones',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (CalificacionMateria materias, _) => materias.nombre,
        measureFn: (CalificacionMateria materias, _) => materias.calificacion,
        data: data,
      )
    ];
  }
}

/// Sample ordinal data type.
class CalificacionMateria {
  final String nombre;
  final int calificacion;

  CalificacionMateria(this.nombre, this.calificacion);
}
