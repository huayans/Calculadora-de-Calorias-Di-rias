import 'package:calculadora_de_calorias_diarias/src/controllers/controller.dart'; // Importa o controlador principal.
import 'package:calculadora_de_calorias_diarias/src/model/article.dart'; // Importa o modelo de artigo.
import 'package:calculadora_de_calorias_diarias/src/model/calorieCalculation.dart'; // Importa o modelo de cálculo de calorias.
import 'package:calculadora_de_calorias_diarias/src/routes/routes.dart'; // Importa as rotas.
import 'package:calculadora_de_calorias_diarias/src/service/article_service.dart'; // Importa o serviço de artigos.
import 'package:flutter/material.dart'; // Importa o pacote Flutter para construção de interfaces.

/// Página que exibe os resultados do cálculo de calorias.
class ResultCaloriesPage extends StatefulWidget {
  final double calories; // Calorias diárias calculadas.
  final bool isMaleSelected; // Gênero selecionado.
  final String goal; // Objetivo do usuário.
  final double weight; // Peso do usuário.
  final double height; // Altura do usuário.
  final int age; // Idade do usuário.
  final MainController mainController; // Controlador principal.

  const ResultCaloriesPage({
    super.key,
    required this.calories,
    required this.goal,
    required this.isMaleSelected,
    required this.weight,
    required this.height,
    required this.age,
    required this.mainController,
  });

  @override
  _ResultCaloriesPageState createState() => _ResultCaloriesPageState();
}

class _ResultCaloriesPageState extends State<ResultCaloriesPage> {
  late Future<List<Article>>
      articles; // Variável para armazenar a lista de artigos.

  @override
  void initState() {
    super.initState();
    // Chama a função para buscar artigos com base no objetivo do usuário.
    articles = fetchArticles(widget.goal);

    // Salva o cálculo ao inicializar a página.
    CalorieCalculation calculation = CalorieCalculation(
      weight: widget.weight,
      height: widget.height,
      age: widget.age,
      gender:
          widget.isMaleSelected ? 'Masculino' : 'Feminino', // Define o gênero.
      calories: widget.calories, // Define as calorias calculadas.
      recommendedCalories: widget.calories, // Define as calorias recomendadas.
      goal: widget.goal,
      activityLevel: 'N/A', // Nível de atividade (opcional).
    );

    // Salva a última calculadora.
    widget.mainController.saveCalculation(calculation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resultado')), // Cabeçalho da página.
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Calorias Diárias: ${widget.calories.toStringAsFixed(2)}', // Exibe as calorias calculadas.
                style: const TextStyle(fontSize: 36),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Objetivo: ${widget.goal == 'Perda de Peso' ? 'Ganho de Peso' : 'Perda de Peso'}', // Exibe o objetivo do usuário.
                style: const TextStyle(fontSize: 24),
              ),
            ),
            FutureBuilder<List<Article>>(
              future: articles, // Espera a lista de artigos ser carregada.
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child:
                          CircularProgressIndicator()); // Exibe um indicador de carregamento.
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text(
                          'Erro: ${snapshot.error}')); // Exibe erro, se houver.
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                      child: Text(
                          'Nenhum artigo encontrado.')); // Mensagem se não houver artigos.
                } else {
                  return Column(
                    children: snapshot.data!.map<Widget>((article) {
                      return ListTile(
                        title: Text(article
                            .traduzirGoal()), // Exibe o título do artigo.
                        subtitle: Text(
                          '${article.author} - Tags: ${article.traduzirTags().join(', ')}', // Exibe autor e tags do artigo.
                        ),
                        onTap: () {
                          _showArticleDetails(
                              article); // Exibe detalhes do artigo ao clicar.
                        },
                      );
                    }).toList(),
                  );
                }
              },
            ),
            // Botão para acessar o histórico
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    Routes.historyPage,
                    arguments: {
                      'calories': widget.calories,
                      'goal': widget.goal,
                      'weight': widget.weight,
                      'height': widget.height,
                      'age': widget.age,
                    },
                  ); // Navega para a página de histórico.
                },
                child: const Text('Ver Histórico'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Exibe os detalhes de um artigo em um modal.
  void _showArticleDetails(Article article) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(article.title,
                    style: const TextStyle(
                        fontSize: 24)), // Exibe o título do artigo.
                const SizedBox(height: 8),
                Text('Autor: ${article.author}'), // Exibe o autor do artigo.
                const SizedBox(height: 8),
                Text(article.content), // Exibe o conteúdo do artigo.
              ],
            ),
          ),
        );
      },
    );
  }
}
