import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _peso = 75;
  double _altura = 175;
  double? _resultadoIMC;
  String? _clasificacion;
  String? _mensaje;

  double calcularIMC() {
    double alturaM = _altura / 100;
    return _peso / (alturaM * alturaM);
  }

  void calcularResultado() {
    setState(() {
      _resultadoIMC = calcularIMC();
      if (_resultadoIMC! < 18.5) {
        _clasificacion = "Desnutrición";
        _mensaje =
            "Estás en desnutrición, se recomienda alimentarse mucho mejor";
      } else if (_resultadoIMC! >= 18.5 && _resultadoIMC! <= 24.9) {
        _clasificacion = "Normal";
        _mensaje = "Estás muy bien, sigue así, realiza mas actividad física";
      } else {
        _clasificacion = "Sobrepeso";
        _mensaje =
            "Estás en sobrepeso, se recomienda hacer mas ejercicio y dieta estricta";
      }
    });
  }

  Widget obtenerImagenResultado() {
    if (_resultadoIMC == null) return Container();
    if (_resultadoIMC! < 18.5) {
      return Image.asset('assets/img/desnutricion.png', height: 150);
    } else if (_resultadoIMC! >= 18.5 && _resultadoIMC! <= 24.9) {
      return Image.asset('assets/img/normal.png', height: 150);
    } else {
      return Image.asset('assets/img/sobrepeso.png', height: 150);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IMC App'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'Bienvenido, selecciona tu peso y altura',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 16),
                  Text('$_peso kg', style: TextStyle(fontSize: 18)),
                  Slider(
                    value: _peso,
                    min: 20,
                    max: 200,
                    divisions: 180,
                    activeColor: Colors.pink,
                    inactiveColor: Colors.pink.shade100,
                    label: _peso.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _peso = value.roundToDouble();
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  Text('$_altura cm', style: TextStyle(fontSize: 18)),
                  Slider(
                    value: _altura,
                    min: 100,
                    max: 220,
                    activeColor: Color.fromARGB(255, 233, 19, 90),
                    inactiveColor: Colors.pink.shade100,
                    label: _altura.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _altura = value.roundToDouble();
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      minimumSize: Size(double.infinity, 56),
                    ),
                    onPressed: () {
                      calcularResultado();
                    },
                    icon: Icon(Icons.play_arrow, color: Colors.white),
                    label:
                        Text('Calcular', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
            if (_resultadoIMC != null) ...[
              SizedBox(height: 32),
              Text(
                'Resultado:',
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              obtenerImagenResultado(),
              SizedBox(height: 16),
              Text(
                '${_resultadoIMC!.toStringAsFixed(1)} kg/m²',
                style: TextStyle(fontSize: 48, color: Colors.pink),
                textAlign: TextAlign.center,
              ),
              Text(
                _clasificacion!,
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text(
                _mensaje!,
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
