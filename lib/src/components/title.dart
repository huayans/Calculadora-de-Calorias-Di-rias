import 'package:flutter/material.dart';

// Widget que exibe um título com cor baseada na seleção de gênero.
class DefaultTitle extends StatelessWidget {
  final String title; // O título a ser exibido.
  final bool isMaleSelected; // Parâmetro para determinar a cor do título.

  // Construtor do widget, que exige o título e a seleção de gênero como parâmetros.
  const DefaultTitle({
    super.key, // Chave opcional para o widget.
    required this.title, // O título é obrigatório.
    required this.isMaleSelected, // A seleção de gênero é obrigatória.
  });

  // Método que constrói a interface do widget.
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // O container ocupa toda a largura disponível.
      padding: const EdgeInsets.symmetric(
          horizontal: 20, vertical: 20), // Espaçamento interno do container.
      decoration: BoxDecoration(
        // Define a cor de fundo do container com base na seleção de gênero.
        color: isMaleSelected
            ? Colors.blue // Azul se o gênero masculino estiver selecionado.
            : Colors.pink, // Rosa se o gênero feminino estiver selecionado.
      ),
      child: Text(
        title, // Exibe o título passado como parâmetro.
        style: const TextStyle(
          color: Colors.white, // Cor do texto.
          fontSize: 20, // Tamanho da fonte.
        ),
      ),
    );
  }
}
