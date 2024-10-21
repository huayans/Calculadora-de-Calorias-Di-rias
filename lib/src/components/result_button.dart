import 'package:flutter/material.dart';

// Widget que representa um botão para calcular resultados, com cor variável.
class ResultButton extends StatelessWidget {
  final bool isMaleSelected; // Para determinar a cor do botão.
  final VoidCallback onPressed; // Callback para lidar com o clique do botão.

  // Construtor do widget, que exige a seleção de gênero e a função de clique como parâmetros.
  const ResultButton({
    super.key, // Chave opcional para o widget.
    required this.isMaleSelected, // A seleção de gênero é obrigatória.
    required this.onPressed, // A ação ao clicar é obrigatória.
  });

  // Método que constrói a interface do widget.
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed, // Ação que será executada ao pressionar o botão.
      style: ElevatedButton.styleFrom(
        backgroundColor: isMaleSelected
            ? Colors
                .blue // Cor de fundo azul se o gênero masculino estiver selecionado.
            : Colors
                .pink, // Cor de fundo rosa se o gênero feminino estiver selecionado.
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(30), // Bordas do botão arredondadas.
        ),
      ),
      child: const Text(
        'Calcular', // Texto exibido no botão.
        style: TextStyle(
          fontSize: 18, // Tamanho da fonte do texto.
          color: Colors.white, // Cor do texto do botão.
        ),
      ),
    );
  }
}
