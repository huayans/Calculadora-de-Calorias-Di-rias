import 'dart:convert'; // Importa o pacote para manipulação de JSON.
import 'package:calculadora_de_calorias_diarias/src/model/article.dart'; // Importa o modelo Article.
import 'package:http/http.dart'
    as http; // Importa o pacote http para fazer requisições.

/// Função assíncrona que busca artigos com base em um objetivo específico.
///
/// Parâmetro [goal]: O objetivo para filtrar os artigos retornados.
///
/// Retorna uma lista de objetos [Article].
Future<List<Article>> fetchArticles(String goal) async {
  // Realiza uma requisição GET para a API que fornece os artigos.
  final response =
      await http.get(Uri.parse('https://api.npoint.io/cd5cc92e412c4058c90d'));

  // Verifica se a requisição foi bem-sucedida (status code 200).
  if (response.statusCode == 200) {
    // Decodifica a resposta JSON.
    final data = jsonDecode(response.body);
    // Mapeia a lista de artigos, filtrando apenas aqueles que correspondem ao objetivo.
    final articles = (data['articles'] as List)
        .map((articleJson) =>
            Article.fromJson(articleJson)) // Converte JSON em objetos Article.
        .where((article) =>
            article.goal ==
            goal) // Filtra artigos com base no objetivo fornecido.
        .toList();

    // Retorna a lista de artigos filtrados.
    return articles;
  } else {
    // Lança uma exceção caso a requisição não tenha sido bem-sucedida.
    throw Exception('Falha ao carregar artigos');
  }
}
