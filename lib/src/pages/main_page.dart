import 'package:calculadora_de_calorias_diarias/src/routes/routes.dart'; // Importa as rotas do aplicativo
import 'package:flutter/material.dart'; // Importa o pacote Flutter para componentes UI
import 'package:calculadora_de_calorias_diarias/src/components/custom_text_form_field.dart'; // Importa o componente de campo de texto personalizado
import 'package:calculadora_de_calorias_diarias/src/components/goal_dropdown.dart'; // Importa o componente de dropdown de objetivos
import 'package:calculadora_de_calorias_diarias/src/components/result_button.dart'; // Importa o botão para calcular o resultado
import 'package:calculadora_de_calorias_diarias/src/components/title.dart'; // Importa o componente de título
import 'package:calculadora_de_calorias_diarias/src/controllers/controller.dart'; // Importa o controlador principal
import 'package:shared_preferences/shared_preferences.dart'; // Importa o pacote para armazenar preferências

/// Página principal da calculadora de calorias diárias.
class MainPage extends StatefulWidget {
  final String title; // Título da página
  final MainController
      mainController; // Controlador principal para gerenciar estados

  const MainPage({
    super.key,
    required this.title,
    required this.mainController,
  });

  @override
  State<MainPage> createState() => _MainPageState(); // Cria o estado da página
}

class _MainPageState extends State<MainPage> {
  String? selectedGoal; // Objetivo selecionado pelo usuário
  String? selectedActivityLevel; // Nível de atividade física selecionado
  String? weight; // Peso do usuário
  String? height; // Altura do usuário
  String? age; // Idade do usuário

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // Permite rolagem se necessário
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DefaultTitle(
              // Título da calculadora
              title: 'Calculadora de Calorias Diárias',
              isMaleSelected: widget
                  .mainController.isMaleSelected, // Define o gênero selecionado
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                // Botões para selecionar gênero
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    iconSize: 100,
                    onPressed: () {
                      setState(() {
                        widget.mainController.isMaleSelected =
                            true; // Seleciona masculino
                      });
                    },
                    icon: Icon(
                      Icons.man,
                      color: widget.mainController.isMaleSelected
                          ? Colors.blue
                          : Colors.grey, // Cor do ícone baseado na seleção
                    ),
                  ),
                  IconButton(
                    iconSize: 100,
                    onPressed: () {
                      setState(() {
                        widget.mainController.isMaleSelected =
                            false; // Seleciona feminino
                      });
                    },
                    icon: Icon(
                      Icons.woman,
                      color: !widget.mainController.isMaleSelected
                          ? Colors.pink
                          : Colors.grey, // Cor do ícone baseado na seleção
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GoalDropdown(
                // Dropdown para selecionar objetivo
                isMaleSelected: widget.mainController.isMaleSelected,
                items: const [
                  'weight_loss', // Perda de peso
                  'weight_gain' // Ganho de peso
                ],
                title: 'Selecione um objetivo',
                selectedValue: selectedGoal,
                onChanged: (value) {
                  setState(() {
                    selectedGoal = value; // Atualiza o objetivo selecionado
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GoalDropdown(
                // Dropdown para selecionar nível de atividade
                isMaleSelected: widget.mainController.isMaleSelected,
                items: const [
                  'Sedentário', // Sedentário
                  'Levemente ativo', // Levemente ativo
                  'Moderadamente ativo', // Moderadamente ativo
                  'Muito ativo' // Muito ativo
                ],
                title: 'Nível de atividade física',
                selectedValue: selectedActivityLevel,
                onChanged: (value) {
                  setState(() {
                    selectedActivityLevel =
                        value; // Atualiza o nível de atividade selecionado
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextFormField(
                // Campo para inserir peso
                title: 'Peso',
                hint: 'Digite seu peso',
                isMaleSelected: widget.mainController.isMaleSelected,
                onChanged: (value) {
                  weight = value; // Armazena o peso inserido
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextFormField(
                // Campo para inserir altura
                title: 'Altura',
                hint: 'Digite sua altura',
                isMaleSelected: widget.mainController.isMaleSelected,
                onChanged: (value) {
                  height = value; // Armazena a altura inserida
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextFormField(
                // Campo para inserir idade
                title: 'Idade',
                hint: 'Digite sua idade',
                isMaleSelected: widget.mainController.isMaleSelected,
                onChanged: (value) {
                  age = value; // Armazena a idade inserida
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: ResultButton(
                  // Botão para calcular o resultado
                  isMaleSelected: widget.mainController.isMaleSelected,
                  onPressed: () async {
                    try {
                      // Verifica se todos os campos estão preenchidos
                      if (selectedGoal == null ||
                          selectedActivityLevel == null ||
                          weight == null ||
                          height == null ||
                          age == null) {
                        throw Exception(
                            'Todos os campos devem ser preenchidos.');
                      }

                      // Calcula as calorias
                      double result = widget.mainController.calculateCalories(
                        selectedGoal,
                        selectedActivityLevel,
                        weight,
                        height,
                        age,
                      );

                      // Armazena o resultado nas preferências
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setDouble('last_calories',
                          result); // Armazena as calorias calculadas
                      await prefs.setString(
                          'last_goal',
                          selectedGoal ??
                              ''); // Armazena o objetivo selecionado

                      // Navega para a página de resultados
                      Navigator.pushNamed(
                        context,
                        Routes.resultCaloriesPage,
                        arguments: {
                          'calories': result,
                          'goal': selectedGoal,
                          'weight': double.tryParse(weight ?? '0') ?? 0,
                          'height': double.tryParse(height ?? '0') ?? 0,
                          'age': int.tryParse(age ?? '0') ?? 0,
                        },
                      );
                    } catch (e) {
                      // Exibe uma mensagem de erro para o usuário
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(e.toString()), // Mensagem de erro
                          backgroundColor:
                              Colors.red, // Cor do fundo da snackbar
                        ),
                      );
                      print('Erro ao navegar: $e'); // Log de erro
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
