//
//  arComponent.swift
//  chemAR
//
//  Created by Neeraj Shetkar on 08/12/23.
//

import SwiftUI
import ARKit

struct ARViewContainer: View {
//    @Environment(ViewModel.self) private var model
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    
    let info: ElementInfo
    var body: some View {
//        @Bindable var status = model
        HStack {
            Text("")
        }
    }
}

#Preview {
    ARViewContainer(info: mockData)
}
