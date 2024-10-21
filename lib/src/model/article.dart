// Classe que representa um artigo relacionado à saúde e nutrição.
class Article {
  final int id; // Identificador único do artigo.
  final String goal; // Objetivo do artigo (ex: perda de peso, ganho de peso).
  final List<String> tags; // Lista de tags relacionadas ao artigo.
  final String title; // Título do artigo.
  final String author; // Autor do artigo.
  final String content; // Conteúdo do artigo.
  final String imageUrl; // URL da imagem associada ao artigo.
  final String publishedDate; // Data de publicação do artigo.

  // Construtor da classe, que recebe todos os parâmetros necessários.
  Article({
    required this.id,
    required this.goal,
    required this.tags,
    required this.title,
    required this.author,
    required this.content,
    required this.imageUrl,
    required this.publishedDate,
  });

  // Método de fábrica para criar uma instância da classe a partir de um JSON.
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'], // Obtém o ID do artigo.
      goal: json['goal'], // Obtém o objetivo do artigo.
      tags: List<String>.from(json['tags']), // Obtém a lista de tags.
      title: json['title'], // Obtém o título do artigo.
      author: json['author'], // Obtém o autor do artigo.
      content: json['content'], // Obtém o conteúdo do artigo.
      imageUrl: json['image_url'], // Obtém a URL da imagem.
      publishedDate: json['published_date'], // Obtém a data de publicação.
    );
  }

  // Método para traduzir o objetivo do artigo para o português.
  String traduzirGoal() {
    switch (goal) {
      case 'weight_loss':
        return 'Perda de Peso'; // Tradução para "weight_loss".
      case 'weight_gain':
        return 'Ganho de Peso'; // Tradução para "weight_gain".
      default:
        return 'Objetivo Desconhecido'; // Caso o objetivo não seja reconhecido.
    }
  }

  // Método para traduzir as tags do artigo para o português.
  List<String> traduzirTags() {
    return tags.map((tag) {
      switch (tag) {
        case 'diet':
          return 'Dieta'; // Tradução para "diet".
        case 'exercise':
          return 'Exercício'; // Tradução para "exercise".
        // Adicione mais traduções conforme necessário.
        default:
          return tag; // Retorna a tag original caso não haja tradução.
      }
    }).toList();
  }
}
