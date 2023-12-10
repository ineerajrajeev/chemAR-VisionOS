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

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }.immersionStyle(selection: .constant(.full), in: .full)
    }
}
