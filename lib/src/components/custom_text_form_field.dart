import 'package:flutter/material.dart'; // Importa o pacote Flutter para construção da interface.
import 'package:flutter/services.dart'; // Importa para usar o FilteringTextInputFormatter.

/// Um widget que representa um campo de texto customizado para entrada numérica.
class CustomTextFormField extends StatelessWidget {
  final String title; // Título do campo.
  final String hint; // Texto de dica que aparece no campo.
  final bool
      isMaleSelected; // Indica se o gênero masculino está selecionado, afetando a cor do campo.
  final Function(String)?
      onChanged; // Callback para capturar mudanças no valor do campo.

  // Construtor do widget, exige os parâmetros obrigatórios.
  const CustomTextFormField({
    super.key,
    required this.title,
    required this.hint,
    required this.isMaleSelected,
    this.onChanged, // Callback opcional para o campo.
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start, // Alinha os filhos no início da coluna.
      children: [
        Text(
          title, // Exibe o título do campo.
          style: TextStyle(
            fontSize: 16, // Tamanho da fonte do título.
            color: isMaleSelected
                ? Colors.blue
                : Colors.pink, // Cor do título baseada na seleção de gênero.
          ),
        ),
        TextFormField(
          keyboardType:
              TextInputType.number, // Define o tipo de teclado como numérico.
          decoration: InputDecoration(
            hintText: hint, // Texto de dica que aparece no campo.
            hintStyle: TextStyle(
              color: isMaleSelected
                  ? Colors.blue[300]
                  : Colors.pink[300], // Cor do texto de dica.
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: isMaleSelected
                    ? Colors.blue
                    : Colors
                        .pink, // Cor da borda quando o campo está habilitado.
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: isMaleSelected
                    ? Colors.blue
                    : Colors.pink, // Cor da borda quando o campo está em foco.
              ),
            ),
          ),
          onChanged:
              onChanged, // Chama o callback quando o valor do campo é alterado.
          inputFormatters: [
            FilteringTextInputFormatter
                .digitsOnly, // Permite apenas a entrada de dígitos.
            LengthLimitingTextInputFormatter(
                3), // Limita a entrada a 3 dígitos.
          ],
        ),
      ],
    );
  }
}
