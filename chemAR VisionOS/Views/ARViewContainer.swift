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
    let animationTimer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var info: ElementInfo
    
    var body: some View {
        RealityView { content in
            if let electron = try? await Entity(named: "Electron", in: realityKitContentBundle), let nucleus = try? await Entity(named: "Nucleus", in: realityKitContentBundle) {
                content.add(nucleus)
                content.add(electron)
                electron.scale = [0.2, 0.2, 0.2]
                nucleus.scale = [0.2, 0.2, 0.2]
                electron.position = [0.1, 0, 0]
            }
        }
    }
}


#Preview {
    ARViewContainer(info: mockData)
        .previewLayout(.sizeThatFits)
}
