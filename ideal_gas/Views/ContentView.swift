import SwiftUI
import CoreHaptics

struct ContentView: View {
    @StateObject private var viewModel = GasSimulationViewModel()
    
    private var hapticManager = HapticManager()
    
    var body: some View {
        TabView {
            TheoryView(viewModel: viewModel, hapticManager: hapticManager)
                .tabItem {
                    Label("Teoría", systemImage: "book.fill")
                }
            
            GasCalculatorView()
                .tabItem {
                    Label("Calculadora", systemImage: "function")
                }
            
            TriviaView()
                .tabItem {
                    Label("Trivia", systemImage: "graduationcap.fill")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
