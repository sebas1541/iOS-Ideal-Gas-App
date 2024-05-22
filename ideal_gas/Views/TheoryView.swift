import SwiftUI

struct TheoryView: View {
    @ObservedObject var viewModel: GasSimulationViewModel
    var hapticManager: HapticManager
    
    @State private var pressure: Double = 1.0
    @State private var volume: Double = 1.0
    @State private var temperature: Double = 300.0 
    private let gasConstant: Double = 8.314
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Teoría de los Gases Ideales")) {
                    introductionSection
                    theorySection(title: "Componentes Principales", content: """
                    Presión (P):
                    
                    La fuerza que ejerce el gas sobre las paredes del recipiente.

                    Volumen (V):
                    
                    El espacio que ocupa el gas.

                    Temperatura (T):
                    
                    Una medida de la energía cinética promedio de las partículas del gas.

                    Número de Partículas (N):
                    La cantidad de moléculas o átomos en el gas.
                    """)
                    
                    theorySection(title: "Ecuación del Gas Ideal", content: """
                    La ecuación de estado para un gas ideal es:
                    PV = nRT
                    
                    Donde:
                    
                    P es la presión del gas,
                    V es el volumen del gas,
                    n es el número de moles del gas,
                    R es la constante universal de los gases ideales,
                    T es la temperatura del gas en kelvin.
                    
                    Esta ecuación describe el comportamiento del gas en términos de sus propiedades macroscópicas.
                    """)
                    
                    theorySection(title: "Suposiciones del Gas Ideal", content: """
                    
                    Las suposiciones principales para un gas ideal incluyen:
                    
                    Las partículas de gas no tienen volumen.
                    
                    Las colisiones entre partículas de gas y entre las partículas y las paredes del recipiente son perfectamente elásticas.
                    
                    No existen fuerzas de atracción o repulsión entre las partículas de gas.
                    
                    Las partículas están en movimiento constante y aleatorio.
                    """)
                }
                
                Section(header: Text("Leyes de los Gases Ideales")) {
                    lawSection(title: "Ley de Boyle", description: "La Ley de Boyle establece que a temperatura constante, la presión de un gas es inversamente proporcional a su volumen.", formula: "P1 * V1 = P2 * V2")
                    lawSection(title: "Ley de Charles", description: "La Ley de Charles establece que a presión constante, el volumen de un gas es directamente proporcional a su temperatura.", formula: "V1 / T1 = V2 / T2")
                    lawSection(title: "Ley de Gay-Lussac", description: "La Ley de Gay-Lussac establece que a volumen constante, la presión de un gas es directamente proporcional a su temperatura.", formula: "P1 / T1 = P2 / T2")
                }
                
                Section(header: Text("Gráfico de la Ecuación del Gas Ideal")) {
                    dynamicIdealGasGraph
                }
                
                Section(header: Text("Simulación de Partículas")) {
                    simulationSection
                }
            }
            .navigationTitle("Gases Ideales")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarItems(trailing:
                Link(destination: URL(string: "https://chat.openai.com/")!) {
                    Text("Search")
                }
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private var introductionSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Introducción")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.primary)
            
            Text("""
            Un gas ideal es un gas teórico compuesto por partículas en movimiento aleatorio que interactúan solo a través de colisiones elásticas. Obedece la ley de los gases ideales y es útil para hacer predicciones en física y química.
            """)
                .font(.system(size: 18))
                .foregroundColor(.primary)
            
            Image("IdealGas")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
                .cornerRadius(8)
                .shadow(radius: 2)
        }
        .padding(.vertical)
    }
    
    private func theorySection(title: String, content: String) -> some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(title)
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.primary)
            
            ForEach(content.split(separator: "\n\n"), id: \.self) { paragraph in
                VStack(alignment: .leading, spacing: 5) {
                    Text(paragraph)
                        .font(.system(size: 18))
                        .foregroundColor(.primary)
                }
            }
        }
        .padding(.vertical)
    }
    
    private func lawSection(title: String, description: String, formula: String) -> some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(title)
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.primary)
            
            Text(description)
                .font(.system(size: 18))
                .foregroundColor(.primary)
            
            Text(formula)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
        }
        .padding(.vertical)
    }
    
    private var dynamicIdealGasGraph: some View {
        VStack(alignment: .leading, spacing: 15) {
            GeometryReader { geometry in
                ZStack {
                    // X-axis
                    Path { path in
                        path.move(to: CGPoint(x: 0, y: geometry.size.height - 20))
                        path.addLine(to: CGPoint(x: geometry.size.width, y: geometry.size.height - 20))
                    }
                    .stroke(Color.black, lineWidth: 2)
                    
                    // Y-axis
                    Path { path in
                        path.move(to: CGPoint(x: 20, y: geometry.size.height))
                        path.addLine(to: CGPoint(x: 20, y: 0))
                    }
                    .stroke(Color.black, lineWidth: 2)
                    
                    // Plotting the points based on the Ideal Gas Law
                    Path { path in
                        let width = geometry.size.width - 40
                        let height = geometry.size.height - 40
                        let volumeRange = stride(from: 0.1, to: 10.0, by: 0.1)
                        let maxVolume = volumeRange.max()!
                        let maxPressure = (gasConstant * temperature) / 0.1
                        
                        path.move(to: CGPoint(x: 20, y: height))
                        
                        for volume in volumeRange {
                            let pressure = (gasConstant * temperature) / volume
                            let x = 20 + width * (volume / maxVolume)
                            let y = height - (height * (pressure / maxPressure))
                            
                            path.addLine(to: CGPoint(x: x, y: y))
                        }
                    }
                    .stroke(Color.blue, lineWidth: 2)
                    
                    // X-axis label
                    Text("Volumen (V)")
                        .position(x: geometry.size.width / 2, y: geometry.size.height - 10)
                    
                    // Y-axis label
                    Text("Presión (P)")
                        .rotationEffect(.degrees(-90))
                        .position(x: 10, y: geometry.size.height / 2)
                }
            }
            .frame(height: 200)
        }
        .padding(.vertical)
    }
    
    private var simulationSection: some View {
        VStack(spacing: 20) {
            Text("Movimiento de Partículas")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            GeometryReader { geometry in
                Canvas { context, size in
                    for particle in viewModel.model.particles {
                        context.fill(
                            Path(ellipseIn: CGRect(x: particle.x, y: particle.y, width: viewModel.model.particleRadius * 2, height: viewModel.model.particleRadius * 2)),
                            with: .color(.blue)
                        )
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(10)
                .shadow(radius: 3)
            }
            .frame(height: 350)
            .padding(.horizontal)

            controlSliders
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 3)
        .listRowInsets(EdgeInsets())
    }
    
    private var controlSliders: some View {
        VStack(spacing: 15) {
            sliderRow(label: "Temperatura", value: $viewModel.temperature, range: 100...1000)
            sliderRow(label: "Volumen", value: $viewModel.volume, range: 100...1000)
            sliderRow(label: "Partículas", value: Binding(
                get: { Double(viewModel.model.particles.count) },
                set: { viewModel.updateParticleCount(Int($0)); hapticManager.triggerHaptic() }
            ), range: 10...500)
            Text("Presión: \(String(format: "%.2f", viewModel.model.valuePressure)) Pa")
                .font(.system(size: 14))
                .foregroundColor(.primary)
        }
    }
    
    private func sliderRow(label: String, value: Binding<Double>, range: ClosedRange<Double>) -> some View {
        HStack {
            Text("\(label): \(Int(value.wrappedValue))")
                .font(.system(size: 14))
                .foregroundColor(.primary)
            Slider(value: value, in: range, step: 1, onEditingChanged: { _ in
                hapticManager.triggerHaptic()
            })
        }
        .padding(.horizontal)
    }
}

struct TheoryView_Previews: PreviewProvider {
    static var previews: some View {
        TheoryView(viewModel: GasSimulationViewModel(), hapticManager: HapticManager())
    }
}
