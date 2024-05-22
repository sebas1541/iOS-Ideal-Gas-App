import Foundation
import Combine
import SwiftUI

class GasSimulationViewModel: ObservableObject {
    @Published var model = Model()
    private var timer: Timer?

    init() {
        startTimer()
    }

    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            self.model.updateParticles()
            self.objectWillChange.send()
        }
    }

    deinit {
        timer?.invalidate()
    }

    func updateParticleCount(_ count: Int) {
        model.updateParticleCount(count: count)
    }

    func calculatePressure(volume: Double, temperature: Double, substance: Double) -> Double {
        return model.calculatePressure(volume: volume, temperature: temperature, substance: substance)
    }

    var temperature: Double {
        get { model.valueTemperature }
        set {
            model.valueTemperature = newValue
            updateParticleSpeed()
            model.updatePressure()
        }
    }

    var volume: Double {
        get { model.valueVolume }
        set {
            model.valueVolume = newValue
            updateParticleSize()
            model.updatePressure()
        }
    }

    private func updateParticleSpeed() {
        model.particleSpeed = CGFloat(model.valueTemperature / 50)
    }

    private func updateParticleSize() {
        model.particleRadius = CGFloat(model.valueVolume / 100)
    }
}
