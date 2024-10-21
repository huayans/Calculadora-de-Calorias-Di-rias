import 'dart:convert';
import 'package:calculadora_de_calorias_diarias/src/model/calorieCalculation.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Classe responsável por controlar a lógica do cálculo de calorias.
class MainController {
  bool isMaleSelected =
      true; // Variável booleana para verificar se o gênero masculino está selecionado.

  // Alterna a seleção do gênero.
  void checkMale() {
    isMaleSelected = !isMaleSelected;
  }

  // Método para calcular as calorias diárias com base nos parâmetros fornecidos.
  double calculateCalories(
    String? selectedGoal, // Objetivo selecionado (ex: perda de peso).
    String? selectedActivityLevel, // Nível de atividade selecionado.
    String? weight, // Peso do usuário.
    String? height, // Altura do usuário.
    String? age, // Idade do usuário.
  ) {
    // Verifica se os campos de entrada estão preenchidos.
    if (weight == null || height == null || age == null) {
      throw Exception('Todos os campos devem ser preenchidos.');
    }

    // Converte os valores de entrada para os tipos apropriados.
    double weightValue = double.tryParse(weight) ?? 0;
    double heightValue = double.tryParse(height) ?? 0;
    int ageValue = int.tryParse(age) ?? 0;

    // Cálculo da Taxa Metabólica Basal (TMB).
    double tmb;
    if (isMaleSelected) {
      // Fórmula de TMB para homens.
      tmb = 88.362 +
          (13.397 * weightValue) +
          (4.799 * heightValue) -
          (5.677 * ageValue);
    } else {
      // Fórmula de TMB para mulheres.
      tmb = 447.593 +
          (9.247 * weightValue) +
          (3.098 * heightValue) -
          (4.330 * ageValue);
    }

    // Determina o fator de atividade física com base no nível de atividade selecionado.
    double activityFactor;
    switch (selectedActivityLevel) {
      case 'Sedentário':
        activityFactor = 1.2; // Pouca ou nenhuma atividade.
        break;
      case 'Levemente ativo':
        activityFactor = 1.375; // Atividades leves.
        break;
      case 'Moderadamente ativo':
        activityFactor = 1.55; // Atividades moderadas.
        break;
      case 'Muito ativo':
        activityFactor = 1.725; // Atividades intensas.
        break;
      default:
        activityFactor = 1.0; // Padrão se não for reconhecido.
    }

    // Calcula as calorias totais.
    double totalCalories = tmb * activityFactor;

    // Ajusta as calorias totais de acordo com o objetivo.
    if (selectedGoal == 'Perda de Peso') {
      totalCalories *= 0.8; // Reduzir 20% para perda de peso.
    } else if (selectedGoal == 'Ganho de Peso') {
      totalCalories *= 1.15; // Aumentar 15% para ganho de peso.
    }

    // Cria uma instância de CalorieCalculation com os dados do cálculo.
    CalorieCalculation calculation = CalorieCalculation(
      weight: weightValue,
      height: heightValue,
      age: ageValue,
      calories: totalCalories,
      gender: isMaleSelected ? 'Masculino' : 'Feminino', // Gênero do usuário.
      recommendedCalories: totalCalories, // Calorias recomendadas.
      goal: selectedGoal, // Objetivo do cálculo.
      activityLevel: selectedActivityLevel, // Nível de atividade.
    );

    // Salva o cálculo realizado.
    saveCalculation(calculation);
    return totalCalories; // Retorna as calorias totais calculadas.
  }

  // Método para salvar o cálculo recente nas preferências do usuário.
  Future<void> saveCalculation(CalorieCalculation calculation) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = json.encode(calculation.toJson());
    await prefs.setString('recent_calculation',
        jsonString); // Atualiza a chave para 'recent_calculation'.
  }

  // Método para recuperar o último cálculo salvo nas preferências do usuário.
  Future<CalorieCalculation?> getLastCalculation() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('recent_calculation');
    if (jsonString != null) {
      return CalorieCalculation.fromJson(
          json.decode(jsonString)); // Retorna o cálculo decodificado.
    }
    return null; // Retorna nulo se não houver cálculo salvo.
  }

  // Método para limpar o cálculo salvo nas preferências do usuário.
  Future<void> clearCalculation() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('recent_calculation'); // Remove o cálculo recente.
  }
}
