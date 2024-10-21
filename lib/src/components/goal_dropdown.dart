import 'package:flutter/material.dart'; // Importa o pacote Flutter para construir a interface.

/// Um widget que representa um dropdown para seleção de objetivos (ex: perda ou ganho de peso).
class GoalDropdown extends StatelessWidget {
  final bool isMaleSelected; // Indica se o gênero masculino está selecionado.
  final List<String> items; // Lista de opções disponíveis no dropdown.
  final String title; // Título exibido como hint do dropdown.
  final String? selectedValue; // Armazena o valor selecionado atualmente.
  final ValueChanged<String?>
      onChanged; // Callback para atualizar o valor selecionado.

  // Construtor do widget, exige todos os parâmetros necessários.
  const GoalDropdown({
    super.key,
    required this.isMaleSelected,
    required this.items,
    required this.title,
    required this.selectedValue, // Parâmetro para o valor selecionado.
    required this.onChanged, // Callback para alterações.
  });

  @override
  Widget build(BuildContext context) {
    // Mapa que associa valores de objetivos em inglês a seus textos em português.
    final Map<String, String> goalTranslations = {
      'weight_loss': 'Perda de peso',
      'weight_gain': 'Ganho de peso',
    };

    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 16), // Espaçamento interno.
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8), // Bordas arredondadas.
        border: Border.all(
          color: isMaleSelected
              ? Colors.blue
              : Colors.pink, // Cor da borda baseada na seleção de gênero.
          width: 2, // Largura da borda.
        ),
      ),
      child: DropdownButton<String>(
        value: selectedValue, // Define o valor selecionado do dropdown.
        hint: Text(
          title, // Texto exibido quando nada é selecionado.
          style: TextStyle(
            fontSize: 18,
            color: isMaleSelected
                ? Colors.blue
                : Colors.pink, // Cor do texto baseada na seleção de gênero.
          ),
        ),
        icon: Icon(
          Icons.arrow_drop_down, // Ícone do dropdown.
          color: isMaleSelected ? Colors.blue : Colors.pink, // Cor do ícone.
          size: 30, // Tamanho do ícone.
        ),
        dropdownColor: isMaleSelected
            ? Colors.blue[50]
            : Colors.pink[50], // Cor do fundo do dropdown.
        underline:
            const SizedBox(), // Remove a linha subjacente padrão do dropdown.
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value, // Define o valor do item.
            child: Text(
              goalTranslations[value] ??
                  value, // Exibe a tradução ou o valor original se não houver tradução.
              style: TextStyle(
                fontSize: 18,
                color: isMaleSelected
                    ? Colors.blue
                    : Colors.pink, // Cor do texto baseada na seleção de gênero.
              ),
            ),
          );
        }).toList(), // Converte a lista de itens em DropdownMenuItems.
        onChanged:
            onChanged, // Executa a callback quando um item é selecionado.
      ),
    );
  }
}
