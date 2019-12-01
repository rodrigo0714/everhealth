import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;

void main() => runApp(EverHealth());

class EverHealth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListaTransferencias(),
      ),
    );
  }
}

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controladorCampoNumeroConta =
      TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Criando Transferencia'),
        ),
        body: Column(
          children: <Widget>[
            Editor(
              controlador: _controladorCampoNumeroConta,
              dica: '0000',
              rotulo: 'Numero da Conta',
            ),
            Editor(
              controlador: _controladorCampoValor,
              dica:'0.00',
              rotulo: 'Valor',
              icone: Icons.monetization_on,
            ),

            RaisedButton(
              child: Text('Confirmar'),
              onPressed: () => _criaTransferencia(context),
            )
          ],
        ));
  }

  void _criaTransferencia(BuildContext context) {
    final int numeroConta =
        int.tryParse(_controladorCampoNumeroConta.text);
    final double valor =
        double.tryParse(_controladorCampoValor.text);
    if (numeroConta != null && valor != null) {
      final transferenciaCriada = Transferencia(valor, numeroConta);
      debugPrint('Criando Transferencia');
      debugPrint ('$transferenciaCriada');
      Navigator.pop(context, transferenciaCriada);
    }
  }
}

class Editor extends StatelessWidget {
  final TextEditingController controlador;
  final String rotulo;
  final String dica;
  final IconData icone;

  Editor({this.controlador, this.rotulo, this.dica, this.icone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controlador,
        style: TextStyle(
          fontSize: 24.0,
        ),
        decoration: InputDecoration(
          icon: icone != null? Icon(icone) : null,
          labelText: rotulo,
          hintText: dica,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

class ListaTransferencias extends StatelessWidget {
  final List<Transferencia> _transferencias = List();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Transferencias'),
      ),
      body: ListView.builder(
        itemCount: _transferencias.length,
        itemBuilder: (context, indice){
         final transferencia = _transferencias[indice];
          return ListaTransferencias();
        },

      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add), onPressed: () {
       final Future <Transferencia> future = Navigator.push(context, MaterialPageRoute(builder: (context) {
          return FormularioTransferencia();
        }));
       future.then((transferenciaRecebida){
         debugPrint('Chegou no then do future');
         debugPrint('$transferenciaRecebida');
         _transferencias.add(transferenciaRecebida);
       });
      },
      ),
    );
  }
}

class ItemRelatorio extends StatelessWidget {
  final Transferencia _transferencia;

  ItemRelatorio(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(_transferencia.valor.toString()),
        subtitle: Text(_transferencia.valortotal.toString()),
      ),
    );
  }
}

class Transferencia {
  final double valor;
  final int valortotal;

  Transferencia(this.valor, this.valortotal);

  @override
  String toString() {
    return 'Transferencia{valor: $valor, valortotal: $valortotal}';
  }
}
