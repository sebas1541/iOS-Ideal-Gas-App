import SwiftUI

struct GasCalculatorView: View {
    @State private var unitSystem: UnitSystem = .si
    @State private var temperature: Double?
    @State private var volume: Double?
    @State private var amountOfSubstance: Double?
    @State private var pressure: Double = 0.0
    @FocusState private var isFieldFocused: Bool

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Seleccione el sistema de unidades")) {
                        Picker("Sistema de unidades", selection: $unitSystem) {
                            ForEach(UnitSystem.allCases, id: \.self) { system in
                                Text(system.rawValue.capitalized)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    
                    Section(header: Text("Ingrese los valores")) {
                        HStack {
                            Text("Temperatura (\(unitSystem == .si ? "K" : "°F"))")
                            Spacer()
                            TextField("Ingrese Valor", value: $temperature, format: .number)
                                .keyboardType(.decimalPad)
                                .multilineTextAlignment(.trailing)
                                .focused($isFieldFocused)
                        }
                        
                        HStack {
                            Text("Volumen (\(unitSystem == .si ? "m³" : "ft³"))")
                            Spacer()
                            TextField("Ingrese Valor", value: $volume, format: .number)
                                .keyboardType(.decimalPad)
                                .multilineTextAlignment(.trailing)
                                .focused($isFieldFocused)
                        }
                        
                        HStack {
                            Text("Cantidad de sustancia (\(unitSystem == .si ? "moles" : "moles"))")
                            Spacer()
                            TextField("Ingrese Valor", value: $amountOfSubstance, format: .number)
                                .keyboardType(.decimalPad)
                                .multilineTextAlignment(.trailing)
                                .focused($isFieldFocused)
                        }
                    }
                    
                    Section(header: Text("Presión Calculada")) {
                        Text("\(pressure, specifier: "%.2f") \(unitSystem == .si ? "Pa" : "psi")")
                    }
                }
                
                VStack {
                    Button(action: calculatePressure) {
                        Text("Calcular")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    Button(action: dismissKeyboard) {
                        Text("Cerrar Teclado")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding()
                            .background(Color(UIColor.systemGray5))
                            .foregroundColor(.primary)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle("Calculadora Gas Ideal")
            .navigationBarTitleDisplayMode(.large)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func calculatePressure() {
        guard let temp = temperature, let vol = volume, let substance = amountOfSubstance else {
            return
        }
        
        let tempConverted = unitSystem == .si ? temp : (temp + 459.67) * 5/9 // Convert °F to K
        let volConverted = unitSystem == .si ? vol : vol * 0.0283168 // Convert ft³ to m³
        let gasConstant = unitSystem == .si ? 8.314 : 10.7316 // J/(mol·K) for SI, ft³·psi/(mol·R) for Imperial
        
        pressure = (tempConverted * gasConstant * substance) / volConverted
        
        if unitSystem == .imperial {
            pressure *= 14.6959 // Convert Pa to psi
        }
    }
    
    func dismissKeyboard() {
        isFieldFocused = false
    }
}

enum UnitSystem: String, CaseIterable {
    case si = "si"
    case imperial = "imperial"
}

struct GasCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        GasCalculatorView()
    }
}
