import SwiftUI
import UIKit

struct TriviaView: View {
    @State private var selectedAnswer1: String = "a"
    @State private var showAlert1 = false
    @State private var selectedAnswer2: String = "a"
    @State private var showAlert2 = false
    @State private var selectedAnswer3: String = "a"
    @State private var showAlert3 = false
    @State private var selectedAnswer4: String = "a"
    @State private var showAlert4 = false
    @State private var selectedAnswer5: String = "a"
    @State private var showAlert5 = false
    @State private var selectedAnswer6: String = "a"
    @State private var showAlert6 = false
    @State private var selectedAnswer7: String = "a"
    @State private var showAlert7 = false
    @State private var showShareSheet = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Pregunta 1")) {
                    questionView(question: "Un material común para acolchar objetos en los paquetes está hecho de burbujas de aire atrapadas entre hojas de plástico. ¿Este material es más efectivo para evitar que los contenidos del paquete se muevan en el interior en:", options: ["a) un día caliente", "b) un día frío", "c) días calientes o fríos"], selectedAnswer: $selectedAnswer1, showAlert: $showAlert1, correctAnswer: "c")
                }

                Section(header: Text("Pregunta 2")) {
                    questionView(question: "En un día de invierno enciende su horno y la temperatura del aire dentro de su casa aumenta. Suponga que su casa tiene la cantidad normal de fuga entre el aire interior y el aire exterior. ¿El número de moles de aire en su habitación a la temperatura más alta:", options: ["a) es mayor que antes", "b) es menor que antes", "c) es igual que antes"], selectedAnswer: $selectedAnswer2, showAlert: $showAlert2, correctAnswer: "c")
                }

                Section(header: Text("Pregunta 3")) {
                    questionView(question: "Según la ley de Boyle, ¿qué sucede con el volumen de un gas si la presión se duplica y la temperatura se mantiene constante?", options: ["a) Se duplica", "b) Se reduce a la mitad", "c) Permanece igual"], selectedAnswer: $selectedAnswer3, showAlert: $showAlert3, correctAnswer: "b")
                }

                Section(header: Text("Pregunta 4")) {
                    questionView(question: "Si la temperatura de un gas ideal se triplica mientras se mantiene constante la presión, ¿qué sucede con el volumen del gas?", options: ["a) Se triplica", "b) Se reduce a la tercera parte", "c) Permanece igual"], selectedAnswer: $selectedAnswer4, showAlert: $showAlert4, correctAnswer: "a")
                }

                Section(header: Text("Pregunta 5")) {
                    questionView(question: "De acuerdo a la ley de Gay-Lussac, ¿qué sucede con la presión de un gas ideal si su temperatura se duplica mientras el volumen se mantiene constante?", options: ["a) Se duplica", "b) Se reduce a la mitad", "c) Permanece igual"], selectedAnswer: $selectedAnswer5, showAlert: $showAlert5, correctAnswer: "a")
                }

                Section(header: Text("Pregunta 6")) {
                    questionView(question: "Si se aumenta el número de partículas de un gas ideal en un recipiente de volumen constante, ¿qué sucede con la presión?", options: ["a) Aumenta", "b) Disminuye", "c) Permanece igual"], selectedAnswer: $selectedAnswer6, showAlert: $showAlert6, correctAnswer: "a")
                }

                Section(header: Text("Pregunta 7")) {
                    questionView(question: "¿Cuál es la constante de los gases ideales?", options: ["a) 8.314 J/(mol·K)", "b) 6.022 x 10^23 mol^-1", "c) 1.38 x 10^-23 J/K"], selectedAnswer: $selectedAnswer7, showAlert: $showAlert7, correctAnswer: "a")
                }
                
                Button("Share Results") {
                    showShareSheet.toggle()
                }
                .sheet(isPresented: $showShareSheet) {
                    ShareSheet(activityItems: [getResultsText()])
                }
            }
            .navigationTitle("Trivia")
            .navigationBarTitleDisplayMode(.large)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func questionView(question: String, options: [String], selectedAnswer: Binding<String>, showAlert: Binding<Bool>, correctAnswer: String) -> some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(question)
                .font(.system(size: 18))
                .foregroundColor(.primary)
            
            VStack(alignment: .leading, spacing: 10) {
                ForEach(options, id: \.self) { option in
                    Text(option)
                        .foregroundColor(.primary)
                }
            }
            .padding(.vertical)
            
            Picker("Selecciona una opción", selection: selectedAnswer) {
                ForEach(options, id: \.self) { option in
                    Text(option).tag(option)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding(.vertical)
            
            Button("Verificar") {
                showAlert.wrappedValue = true
            }
            .alert(isPresented: showAlert) {
                Alert(title: Text("Respuesta"),
                      message: Text(selectedAnswer.wrappedValue == options.first(where: { $0.hasPrefix(correctAnswer) }) ? "Correcta 😊" : "Incorrecta 🥺"),
                      dismissButton: .default(Text("OK")))
            }
        }
    }
    
    private func getResultsText() -> String {
        var results = "Resultado de Preguntas:\n"
        results += "Pregunta 1: \(selectedAnswer1)\n"
        results += "Pregunta 2: \(selectedAnswer2)\n"
        results += "Pregunta 3: \(selectedAnswer3)\n"
        results += "Pregunta 4: \(selectedAnswer4)\n"
        results += "Pregunta 5: \(selectedAnswer5)\n"
        results += "Pregunta 6: \(selectedAnswer6)\n"
        results += "Pregunta 7: \(selectedAnswer7)\n"
        return results
    }
}

struct ShareSheet: UIViewControllerRepresentable {
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

struct TriviaView_Previews: PreviewProvider {
    static var previews: some View {
        TriviaView()
    }
}
