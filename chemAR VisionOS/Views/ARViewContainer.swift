import SwiftUI
import RealityKit
import RealityKitContent

struct ARViewContainer: View {
    @State private var electronRotations: [Double] = []
    @State private var electronEntities: [Entity] = []
    @Environment(ViewModel.self) private var model
    
    let animationTimer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

    var body: some View {
        HStack {
            ARElementDetails(info: model.element)
            RealityView { content in
                if let nucleus = try? await Entity(named: "Nucleus", in: realityKitContentBundle) {
                    content.add(nucleus)
                    nucleus.position = [0, 0, 0]
                    nucleus.scale = [0.25, 0.25, 0.25]
                    nucleus.setSunlight(intensity: 0.1)

                    for (shellIndex, electronCount) in model.element.shells.enumerated() {
                        let electronRadius = Float(shellIndex + 1) * 0.05
                        
                        for i in 0..<electronCount {
                            let angle = 360.0 / Float(electronCount) * Float(i)
                            let x = electronRadius * cos(angle * .pi / 180)
                            let z = electronRadius * sin(angle * .pi / 180)
                            let electron = try? await Entity(named: "Electron", in: realityKitContentBundle)
                            if let electronEntity = electron {
                                content.add(electronEntity)
                                electronEntity.position = [x, 0, z]
                                electronEntity.scale = [0.1, 0.1, 0.1]
                                
                                let duration: Double = .infinity

                                // Orbit around the nucleus
                                let orbit = OrbitAnimation(
                                    name: "Electron_Orbit_\(shellIndex)_\(i)",
                                    duration: calculateRotationDuration(for: shellIndex),
                                    axis: [0, 1, 0],
                                    startTransform: electronEntity.transform,
                                    bindTarget: .transform,
                                    repeatMode: .repeat
                                )
                                let animation = try? AnimationResource.generate(with: orbit)
                                electronEntity.playAnimation(animation!)
                                electronEntities.append(electronEntity)
                            }
                        }
                    }
                }
            }
            .onReceive(animationTimer) { _ in
                updateElectronPositions()
            }
        }
    }

    private func setupRotations() {
        electronRotations = Array(repeating: 0.0, count: model.element.shells.reduce(0, +))
    }
    
    private func calculateRotationDuration(for shellIndex: Int) -> Double {
            let baseDuration = 10.0
            let durationFactor = 0.5
            let duration = baseDuration / (1.0 + durationFactor * Double(shellIndex))
            return duration
        }

    private func updateElectronPositions() {
        for (index, electronEntity) in electronEntities.enumerated() {
            let shellIndex = index % model.element.shells.count
            let electronCount = model.element.shells[shellIndex]
            let angle = 360.0 / Double(electronCount) * Double(index)
            let electronRadius = Float(shellIndex + 1) * 0.05
            let x = electronRadius * cos(Float(angle) * .pi / 180)
            let z = electronRadius * sin(Float(angle) * .pi / 180)
            electronEntity.position = [x, 0, z]
        }
    }
}

#Preview {
    ARViewContainer()
        .previewLayout(.sizeThatFits)
}
