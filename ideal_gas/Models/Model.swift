import Foundation
import CoreGraphics

struct Particle {
    var x: CGFloat
    var y: CGFloat
}

class Model: ObservableObject {
    static let width: CGFloat = 350
    static let height: CGFloat = 350
    static let gasConstant: Double = 8.314

    @Published var particles: [Particle] = []
    @Published var particleRadius: CGFloat = 2.5
    @Published var particleSpeed: CGFloat = 9.0
    @Published var valuePressure: Double = 0.0
    @Published var valueTemperature: Double = 0.0
    @Published var valueVolume: Double = 0.0
    @Published var valueAmountSubstance: Double = 0.0

    init() {
        updateParticleCount(count: 200)
    }

    func updateParticleCount(count: Int) {
        if count < particles.count {
            particles = Array(particles.prefix(count))
        } else {
            for _ in particles.count..<count {
                let x = CGFloat.random(in: particleRadius...(Model.width - particleRadius))
                let y = CGFloat.random(in: particleRadius...(Model.height - particleRadius))
                particles.append(Particle(x: x, y: y))
            }
        }
        updatePressure()
    }

    func updateParticles() {
        for i in particles.indices {
            let angle = CGFloat.random(in: 0..<360) * .pi / 180
            let dx = cos(angle) * particleSpeed * CGFloat.random(in: 0.5...1.5)
            let dy = sin(angle) * particleSpeed * CGFloat.random(in: 0.5...1.5)

            particles[i].x += dx
            particles[i].y += dy

        
            particles[i].x = max(particleRadius, min(Model.width - particleRadius, particles[i].x))
            particles[i].y = max(particleRadius, min(Model.height - particleRadius, particles[i].y))
        }
    }

    func calculatePressure(volume: Double, temperature: Double, substance: Double) -> Double {
        return (temperature * Model.gasConstant * substance) / volume
    }

    func updatePressure() {
        valuePressure = calculatePressure(volume: valueVolume, temperature: valueTemperature, substance: Double(particles.count))
    }
}
