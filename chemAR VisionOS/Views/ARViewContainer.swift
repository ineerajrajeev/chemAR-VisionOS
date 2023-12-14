import SwiftUI
import RealityKit
import RealityKitContent

struct ARViewContainer: View {
    @State private var electronRotations: [Double] = []
    @State private var electronEntities: [Entity] = []
    
    let attachmentID = "attachmentID"
    
    @Environment(ViewModel.self) private var model
    
    let animationTimer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

    var body: some View {
        HStack {
                       
            RealityView { content, attachments in
                // Nucleus element
                if let nucleus = try? await Entity(named: "Nucleus", in: realityKitContentBundle) {
                    content.add(nucleus)
                    nucleus.position = [0, 0, 0]
                    nucleus.scale = [0.25, 0.25, 0.25]
                    nucleus.setSunlight(intensity: 0.1)
                    

                    // Looping over shells
                    for (shellIndex, electronCount) in model.element.shells.enumerated() {
                        let electronRadius = Float(shellIndex + 1) * 0.05
                        
                        // Check if orbit on
                        var duration: Double = model.orbitOn ? calculateRotationDuration(for: shellIndex): .infinity
                        
                        
                        // Looping over electrons
                        for i in 0..<electronCount {
                            let angle = 360.0 / Float(electronCount) * Float(i)
                            let x = electronRadius * cos(angle * .pi / 180)
                            let z = electronRadius * sin(angle * .pi / 180)
                            let electron = try? await Entity(named: "Electron", in: realityKitContentBundle)
                            
                            
                            // If valid electron entity
                            if let electronEntity = electron {
                                content.add(electronEntity)
                                electronEntity.position = [x, 0, z] // Set computed position
                                electronEntity.scale = [0.15, 0.15, 0.15] // Set Scale
                                electronEntity.setSunlight(intensity: 0.05) // Set Image based lighting
                                

                                // Orbit around the nucleus
                                let orbit = OrbitAnimation(
                                    name: "Electron_Orbit_\(shellIndex)_\(i)",
                                    duration: duration,
                                    axis: [0, 1, 0],
                                    startTransform: electronEntity.transform,
                                    bindTarget: .transform,
                                    repeatMode: .repeat
                                )
                                
                                
                                // Add animation to scene
                                let animation = try? AnimationResource.generate(with: orbit)
                                electronEntity.playAnimation(animation!) // Play animation
                                electronEntities.append(electronEntity)
                            }
                        }
                    }
                }
            } update: { content, attachments in
                print("Updates")
            } attachments: {
                Attachment(id: attachmentID){
                    
                }
            }
            .overlay(content: {
                ARElementDetails(info: model.element)
            })
            
            .gesture(SpatialTapGesture()
                .onEnded{ value in
                    model.orbitOn = !model.orbitOn
                    print("Gesture detected")
                    print(model.orbitOn)
                })
        }
    }
    
    
    // Calculate rotation duration for each electron
    private func calculateRotationDuration(for shellIndex: Int) -> Double {
        let baseDuration = 40.0
        let durationFactor = 0.5
        let duration = baseDuration / (1.0 + durationFactor * Double(shellIndex))
        return duration
    }
}
