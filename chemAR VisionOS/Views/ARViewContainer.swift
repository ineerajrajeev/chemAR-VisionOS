import SwiftUI
import RealityKit
import RealityKitContent

struct ARViewContainer: View {
    @State private var electronRotations: [Double] = []
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
                        let electronRadius = CGFloat(shellIndex + 1) * 0.05
                        
                        for i in 0..<electronCount {
                            let angle = 360.0 / Double(electronCount) * Double(i)
                            let electron = try? await Entity(named: "Electron", in: realityKitContentBundle)
                            let x = electronRadius * cos(angle * .pi / 180)
                            let z = electronRadius * sin(angle * .pi / 180)
                            electron?.setSunlight(intensity: 0.1)
                            if let electronEntity = electron {
                                content.add(electronEntity)
                                electronEntity.position = [Float(x), 0, Float(z)] // Adjust as needed
                                electronEntity.scale = [0.1, 0.1, 0.1]
                                electronRotations.append(0.0)
                            }
                        }
                    }
                }
            }
            .onAppear {
                setupRotations()
            }
            .onReceive(animationTimer) { _ in
                animateRotations()
            }
        }
    }

    private func setupRotations() {
        electronRotations = Array(repeating: 0.0, count: model.element.shells.reduce(0, +))
    }

    private func animateRotations() {
        for i in 0..<electronRotations.count {
            electronRotations[i] += 2.0 // Adjust the rotation speed here
            // Update the rotation or transform of each electron entity here based on 'electronRotations[i]'
        }
    }
}

#Preview {
    ARViewContainer()
        .previewLayout(.sizeThatFits)
}
