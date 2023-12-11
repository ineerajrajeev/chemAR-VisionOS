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
    let animationTimer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    
    var info: ElementInfo
    var body: some View {
        RealityView { content in
            if let scene = try? await Entity(named: "Immersive", in: realityKitContentBundle) {
                content.add(scene)
            }
        }
    }
    
    // Rotation angle
    private func setupRotations() {
        electronRotations = Array(repeating: 0.0, count: info.shells.count)
    }
    
    // Text position
    private func getTextPosition(for index: Int, in size: CGSize, radius: CGFloat) -> CGPoint {
            let angle = 360.0 / Double(info.shells.count) * Double(index)
            let xPos = cos(angle * .pi / 180) * Double(radius) + Double(size.width / 2)
            let yPos = sin(angle * .pi / 180) * Double(radius) + Double(size.height / 2)
            return CGPoint(x: xPos, y: yPos)
        }
    
    private func animateRotations() {
        for i in 0..<electronRotations.count {
            electronRotations[i] += 2.0 / Double(i + 1) // Adjust the rotation speed here
        }
    }
}

#Preview {
    ARViewContainer(info: mockData)
        .previewLayout(.sizeThatFits)
}
