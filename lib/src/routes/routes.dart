import 'package:flutter/material.dart'; // Importa o pacote Flutter para construção de interfaces.
import 'package:calculadora_de_calorias_diarias/src/pages/main_page.dart'; // Importa a página principal.
import 'package:calculadora_de_calorias_diarias/src/pages/result_calories_page.dart'; // Importa a página de resultados.
import 'package:calculadora_de_calorias_diarias/src/pages/history_page.dart'; // Importa a página de histórico.
import 'package:calculadora_de_calorias_diarias/src/controllers/controller.dart'; // Importa o controlador principal.

/// Classe que gerencia as rotas da aplicação.
class Routes {
  // Constantes que definem os caminhos das rotas.
  static const String mainPage = '/'; // Rota da página principal.
  static const String resultCaloriesPage =
      '/result'; // Rota da página de resultados.
  static const String historyPage =
      '/history'; // Nova rota para a página de histórico.

  /// Método que gera rotas com base nos [settings] fornecidos.
  ///
  /// Parâmetros:
  /// - [settings]: Informações sobre a rota solicitada.
  /// - [mainController]: O controlador principal da aplicação.
  ///
  /// Retorna um objeto [Route<dynamic>] que representa a rota desejada.
  static Route<dynamic> generateRoute(
      RouteSettings settings, MainController mainController) {
    switch (settings.name) {
      case mainPage:
        // Retorna a rota da página principal.
        return MaterialPageRoute(
          builder: (context) => MainPage(
            title: 'Calculadora de Calorias Diárias', // Título da página.
            mainController:
                mainController, // Passa o controlador para a página.
          ),
        );
      case resultCaloriesPage:
        // Recupera os valores necessários a partir de settings.arguments.
        final arguments = settings.arguments as Map<String, dynamic>;
        final double calories = arguments['calories'];
        final String goal = arguments['goal'];
        final double weight = arguments['weight']; // Adiciona o peso.
        final double height = arguments['height']; // Adiciona a altura.
        final int age = arguments['age']; // Adiciona a idade.

        // Retorna a rota da página de resultados.
        return MaterialPageRoute(
          builder: (context) => ResultCaloriesPage(
            calories: calories, // Passa o total de calorias.
            isMaleSelected:
                mainController.isMaleSelected, // Estado de seleção do gênero.
            goal: goal, // Passa o objetivo.
            weight: weight, // Passa o peso.
            height: height, // Passa a altura.
            age: age, // Passa a idade.
            mainController: mainController, // Passa o controlador.
          ),
        );
      case historyPage: // Adiciona o caso para a nova rota de histórico.
        return MaterialPageRoute(
          builder: (context) => HistoryPage(
            mainController: mainController, // Passa o controlador.
            isMaleSelected:
                mainController.isMaleSelected, // Estado de seleção do gênero.
          ),
        );
      default:
        // Caso não corresponda a nenhuma rota conhecida, retorna à página principal.
        return MaterialPageRoute(
          builder: (context) => MainPage(
            title: 'Calculadora de Calorias Diárias', // Título da página.
            mainController: mainController, // Passa o controlador.
          ),
        );
    }
  }
}
