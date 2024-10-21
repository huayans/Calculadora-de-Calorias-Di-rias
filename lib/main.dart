import 'package:flutter/material.dart';
import 'package:calculadora_de_calorias_diarias/src/controllers/controller.dart';
import 'package:calculadora_de_calorias_diarias/src/routes/routes.dart'; // Importa as rotas

/// Função principal que inicia o aplicativo.
void main() {
  // Criação do controlador principal que gerencia a lógica do aplicativo.
  final mainController = MainController();

  // Inicia o aplicativo chamando a classe MyApp e passando o controlador.
  runApp(MyApp(mainController: mainController));
}

/// Classe principal do aplicativo, que estende StatelessWidget.
class MyApp extends StatelessWidget {
  // Controlador principal que será utilizado em todo o aplicativo.
  final MainController mainController;

  // Construtor que recebe o controlador como parâmetro obrigatório.
  const MyApp({super.key, required this.mainController});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Desativa o banner de depuração no canto superior direito.
      debugShowCheckedModeBanner: false,
      // Título do aplicativo exibido na barra de título.
      title: 'Desafio Técnico',
      // Definição do tema do aplicativo.
      theme: ThemeData(primarySwatch: Colors.blue),
      // Rota inicial do aplicativo.
      initialRoute: Routes.mainPage,
      // Método de geração de rotas que utiliza o controlador.
      onGenerateRoute: (settings) => Routes.generateRoute(
          settings, mainController), // Chama o método de geração de rota
    );
  }
}
