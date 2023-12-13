//
//  chemAR_VisionOSApp.swift
//  chemAR VisionOS
//
//  Created by Neeraj Shetkar on 10/12/23.
//

import SwiftUI

@main
struct chemAR_VisionOSApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .windowStyle(.plain)
        
        WindowGroup(id: "AR_View") {
            ARViewContainer(info: mockData)
        }
        .windowStyle(.volumetric)
        .defaultSize(width: 1000, height: 1000, depth: 1000)
    }
}
