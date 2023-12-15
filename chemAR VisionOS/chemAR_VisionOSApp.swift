//
//  chemAR_VisionOSApp.swift
//  chemAR VisionOS
//
//  Created by Neeraj Shetkar on 10/12/23.
//

import SwiftUI

@main
struct chemAR_VisionOSApp: App {
    
    @State private var model = ViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(model)
        }
        .windowStyle(.plain)
        .defaultSize(width: 1500, height: 1150)
        
        WindowGroup(id: "AR_View") {
            ARViewContainer()
                .environment(model)
        }
        .windowStyle(.volumetric)
        .defaultSize(width: 1500, height: 100)
    }
}
