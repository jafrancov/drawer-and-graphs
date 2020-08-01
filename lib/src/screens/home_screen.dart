import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  final String title;
  final barras = [
    ['Gráfica de barras simple', '/barrasSimple'],
    ['Gráfica de barras horizontal', '/barrasHorizontales'],
    ['Gráfica de barras redondeadas', '/barrasRedondeadas'],
    ['Gráfica de barras agrupadas', '/barrasAgrupadas'],
  ];

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: graficasCentral(context),
        ),
      ),
      drawer: Drawer(
        child: ListView(
            padding: EdgeInsets.zero,
            children: graficasDrawer(context)
        ),
      ),
    );
  }

  Widget divisor() {
    return Container(
      height: 0.3,
      color: Colors.grey,
    );
  }

  Widget grafica(BuildContext context, String titulo, String ruta) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Text(
            titulo,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      onTap: () {
        if (ruta != '') Navigator.pushNamed(context, ruta);
      },
    );
  }

  Widget drawerItem(BuildContext context, String titulo, String ruta) {
    return ListTile(
      title: Text(titulo),
      onTap: () {
        if (ruta != '') Navigator.pushNamed(context, ruta);
      },
    );
  }

  List<Widget> graficasCentral(BuildContext context) {
    List<Widget> titulos = List<Widget>();
    titulos.add(divisor());
    for (int i = 0; i < barras.length; i++) {
      titulos.add(grafica(context, barras[i][0], barras[i][1]));
      titulos.add(divisor());
    }
    return titulos;
  }

  List<Widget> graficasDrawer(BuildContext context) {
    List<Widget> titulos = List<Widget>();
    titulos.add(DrawerHeader(
      child: Text('Drawer Header'),
      decoration: BoxDecoration(
        color: Colors.blue,
      ),
    ));
    for (int i = 0; i < barras.length; i++) {
      titulos.add(drawerItem(context, barras[i][0], barras[i][1]));
    }
    return titulos;
  }
}
