import 'package:calculadora_de_calorias_diarias/src/routes/routes.dart'; // Importa as rotas definidas no aplicativo.
import 'package:flutter/material.dart'; // Importa o pacote Flutter para construir a interface.

/// Um botão que navega para a página de histórico quando pressionado.
class HistoryButton extends StatelessWidget {
  // Construtor do widget. O parâmetro key é opcional.
  const HistoryButton({super.key});

  // Método que constrói a interface do widget.
  @override
  Widget build(BuildContext context) {
    return Center(
      // Centraliza o botão na tela.
      child: ElevatedButton(
        onPressed: () {
          // Navega para a página de histórico ao pressionar o botão.
          Navigator.pushNamed(context, Routes.historyPage);
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black, // Cor do texto do botão.
          backgroundColor: Colors.white, // Cor de fundo do botão.
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0), // Bordas arredondadas.
            side: const BorderSide(
                color: Colors.black), // Bordas pretas ao redor do botão.
          ),
          elevation: 5, // Sombra do botão para efeito de elevação.
        ),
        child: const Text(
          'Ver Histórico', // Texto exibido no botão.
          style: TextStyle(fontSize: 18), // Tamanho da fonte do texto.
        ),
      ),
    );
  }
}
