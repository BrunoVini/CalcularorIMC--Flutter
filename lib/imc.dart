import 'package:flutter/material.dart';

class Imc extends StatefulWidget {
  @override
  _ImcState createState() => _ImcState();
}

class _ImcState extends State<Imc> {
  final TextEditingController _alturaController = TextEditingController();
  final TextEditingController _pesoController = TextEditingController();
  final key = GlobalKey<ScaffoldState>();
  var _result = '';
  var imc = 0;
  var _situation = '';

  _onItemTapped(int index) {
    if (index == 0) {
      _alturaController.clear();
      _pesoController.clear();
      setState(() {
        _result = '';
        _situation = '';
      });
    } else if (_alturaController.text.isEmpty || _pesoController.text.isEmpty) {
      key.currentState.showSnackBar(SnackBar(
        content: Text('Altura e Peso são obrigatórios'),
      ));
    } else {
      try {
        var weightDouble = double.parse(_pesoController.text);
        var heightDouble = double.parse(_alturaController.text);

        var imc = weightDouble / (heightDouble * heightDouble);

        setState(() {
          _result = 'Seu IMC é ${imc.toStringAsFixed(2)}';

          if (imc < 17) {
            _situation = 'Muito abaixo do peso';
          } else if ((imc >= 17) && (imc < 18.49)) {
            _situation = 'Abaixo do peso';
          } else if ((imc >= 18.50) && (imc < 24.99)) {
            _situation = 'Peso normal';
          } else if ((imc >= 25) && (imc < 29.99)) {
            _situation = 'Acima do peso';
          } else if ((imc >= 30) && (imc < 34.99)) {
            _situation = 'Obesidade I';
          } else if ((imc >= 35) && (imc < 39.99)) {
            _situation = 'Obesidade II (severa)';
          } else {
            _situation = 'Obesidade III (mórbida)';
          }
        });
      } catch (e) {
        try {
          var peso = _pesoController.text;
          var altura = _alturaController.text;

          var pesoSplit = peso.split(',');
          var alturaSplit = altura.split(',');

          if (pesoSplit.length == 1) {
            pesoSplit.add('0');
          }

          if (alturaSplit.length == 1) {
            alturaSplit.add('0');
          }

          if ((alturaSplit.length > 2) || (pesoSplit.length > 2)) {
            key.currentState.showSnackBar(SnackBar(
              content:
                  Text('Altura e Peso foram informados em formato inválido'),
            ));
          }

          var pesoArray = pesoSplit[0] + '.' + pesoSplit[1];
          var alturaArray = alturaSplit[0] + '.' + alturaSplit[1];

          var pesoDouble = double.parse(pesoArray);
          var alturaDouble = double.parse(alturaArray);

          var imc = pesoDouble / (alturaDouble * alturaDouble);

          setState(() {
            _result = 'Seu IMC é ${imc.toStringAsFixed(2)}';

            if (imc < 17) {
              _situation = 'Muito abaixo do peso';
            } else if ((imc >= 17) && (imc < 18.49)) {
              _situation = 'Abaixo do peso';
            } else if ((imc >= 18.50) && (imc < 24.99)) {
              _situation = 'Peso normal';
            } else if ((imc >= 25) && (imc < 29.99)) {
              _situation = 'Acima do peso';
            } else if ((imc >= 30) && (imc < 34.99)) {
              _situation = 'Obesidade I';
            } else if ((imc >= 35) && (imc < 39.99)) {
              _situation = 'Obesidade II (severa)';
            } else {
              _situation = 'Obesidade III (mórbida)';
            }
          });
        } catch (e) {
          key.currentState.showSnackBar(SnackBar(
            content: Text('Altura e Peso foram informados em formato inválido'),
          ));
        }

        // key.currentState.showSnackBar(SnackBar(
        //   content: Text('Altura e Peso foram informados em formato inválido'),
        // ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text('Cálculo IMC'),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            "assets/bike_pwa.png",
            width: 200,
          ),
          TextField(
            controller: _alturaController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
                hintText: 'Altura',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                icon: Icon(Icons.accessibility_new)),
          ),
          TextField(
            controller: _pesoController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
                hintText: 'Peso',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                icon: Icon(Icons.person)),
          ),
          Text('$_result', style: TextStyle(fontSize: 20)),
          Text('$_situation', style: TextStyle(fontSize: 20))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.indigo,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.clear, color: Colors.white),
              title: Text(
                'Limpar',
                style: TextStyle(color: Colors.white),
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.check, color: Colors.white),
              title: Text('Calcular', style: TextStyle(color: Colors.white))),
        ],
      ),
    );
  }
}
