import 'package:bloc_flutterando/enderecomodel.dart';
import 'package:bloc_flutterando/myhomepage_bloc.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MyHomePageBloc bloc = MyHomePageBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextField(
                onChanged: (value) {
                  bloc.input.add(value);
                },
                decoration: InputDecoration(
                  hintText: 'Difite seu CEP',
                  border: OutlineInputBorder(),
                ),
              ),
              Center(
                child: StreamBuilder<EnderecoModel>(
                  stream: bloc.output,
                  initialData: EnderecoModel(
                    cep: '',
                    logradouro: '',
                    complemento: '',
                    bairro: '',
                    localidade: '',
                    uf: '',
                    ibge: '',
                    gia: '',
                    ddd: '',
                    siafi: '',
                  ),
                  builder: (context, snapshot) {
                    EnderecoModel model = snapshot.data;

                    if (snapshot.hasError) {
                      return Text(
                        'Erro na pesquisa',
                        style: TextStyle(color: Colors.red),
                      );
                    }
                    return Text(
                        'Logradouro: ${model?.logradouro} \nBairro: ${model?.bairro} \nCidade: ${model?.localidade} \nUF: ${model?.uf}');
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
