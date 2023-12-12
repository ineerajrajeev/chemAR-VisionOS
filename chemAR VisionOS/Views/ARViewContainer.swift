//
//  ImmersiveView.swift
//  chemAR
//
//  Created by Neeraj Shetkar on 11/12/23.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ARViewContainer: View {
    @State private var electronRotations: [Double] = []
    @Environment(\.colorScheme) var colorScheme
    @State private var atom: Entity?
    let animationTimer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var info: ElementInfo
    
    var body: some View {
        RealityView { content in
            if let scene = try? await Entity(named: "ProtonComponent", in: realityKitContentBundle) {
                content.add(scene)
                self.atom = scene
            }
            if let scene = try? await Entity(named: "ElectronComponent", in: realityKitContentBundle) {
                content.add(scene)
                self.atom = scene
                setupRotations()
            }
        }
        .onAppear {
            setupRotations()
        }
        .onReceive(animationTimer) { _ in
            animateRotations()
        }
    }
    
    private func setupRotations() {
        guard let atom = atom else { return }
        electronRotations = Array(repeating: 0.0, count: info.shells.count)
        animateRotations()
    }

    private func animateRotations() {
        guard let atom = atom else { return }
        for i in 0..<electronRotations.count {
            let rotationAngle = 2.0 / Float(i + 1) // Adjust the rotation speed here
            electronRotations[i] += Double(rotationAngle)
            let rotation = SIMD3<Float>(0, 1, 0) // Rotate around Y-axis
            var transform = Transform()
            transform.rotation = simd_quatf(angle: Float(electronRotations[i]), axis: rotation)
            atom.transform = transform
        }
    }
}


#Preview {
    ARViewContainer(info: mockData)
        .previewLayout(.sizeThatFits)
}
