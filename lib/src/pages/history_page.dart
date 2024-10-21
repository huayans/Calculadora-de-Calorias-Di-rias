import 'dart:convert'; // Importa a biblioteca para manipulação de JSON.
import 'package:calculadora_de_calorias_diarias/src/controllers/controller.dart'; // Importa o controlador principal da aplicação.
import 'package:flutter/material.dart'; // Importa componentes do Flutter para construção de interfaces.
import 'package:shared_preferences/shared_preferences.dart'; // Importa o pacote para persistência de dados.

class HistoryPage extends StatefulWidget {
  final bool
      isMaleSelected; // Armazena se o usuário selecionou masculino ou não.

  const HistoryPage({
    super.key,
    required MainController
        mainController, // Controlador principal da aplicação.
    required this.isMaleSelected, // Gênero selecionado.
  });

  @override
  _HistoryPageState createState() =>
      _HistoryPageState(); // Cria o estado da página.
}

class _HistoryPageState extends State<HistoryPage> {
  Map<String, dynamic>? recentData; // Armazena os dados do cálculo recente.

  @override
  void initState() {
    super.initState();
    _loadHistory(); // Carrega o histórico ao iniciar o estado.
  }

  // Método para carregar os dados do histórico.
  Future<void> _loadHistory() async {
    SharedPreferences prefs = await SharedPreferences
        .getInstance(); // Obtém as preferências compartilhadas.
    String? dataString = prefs.getString(
        'recent_calculation'); // Recupera a string do cálculo recente.

    if (dataString != null) {
      setState(() {
        recentData = jsonDecode(
            dataString); // Decodifica a string JSON e armazena os dados.
      });
    }
  }

  // Método para limpar o histórico.
  Future<void> _clearHistory() async {
    SharedPreferences prefs = await SharedPreferences
        .getInstance(); // Obtém as preferências compartilhadas.
    await prefs.remove('recent_calculation'); // Remove o cálculo recente.
    setState(() {
      recentData = null; // Limpa os dados carregados.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico de Cálculos'), // Título da AppBar.
        actions: [
          IconButton(
            icon: const Icon(Icons.clear), // Ícone para limpar histórico.
            onPressed: _clearHistory, // Chama o método para limpar histórico.
          ),
        ],
      ),
      body: Center(
        child: recentData != null // Verifica se há dados recentes.
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Dados de Entrada:',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold), // Estilo do título.
                    ),
                    Text(
                        widget.isMaleSelected
                            ? 'Homem'
                            : 'Mulher', // Exibe o gênero.
                        style: const TextStyle(fontSize: 18)),
                    Text('Peso: ${recentData!['weight']} kg', // Exibe o peso.
                        style: const TextStyle(fontSize: 18)),
                    Text(
                        'Altura: ${recentData!['height']} cm', // Exibe a altura.
                        style: const TextStyle(fontSize: 18)),
                    Text('Idade: ${recentData!['age']} anos', // Exibe a idade.
                        style: const TextStyle(fontSize: 18)),
                    const SizedBox(height: 20),
                    const Text(
                      'Resultados:',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight
                              .bold), // Estilo do título de resultados.
                    ),
                    Text(
                        'Calorias Recomendadas: ${recentData!['calories']} kcal', // Exibe as calorias recomendadas.
                        style: const TextStyle(fontSize: 18)),
                  ],
                ),
              )
            : const Text(
                'Nenhum histórico disponível.', // Mensagem caso não haja dados.
                style: TextStyle(fontSize: 24),
              ),
      ),
    );
  }
}
