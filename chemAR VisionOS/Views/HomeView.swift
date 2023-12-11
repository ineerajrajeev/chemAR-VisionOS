//
//  iPadHome.swift
//  chemAR
//
//  Created by Neeraj Shetkar on 09/12/23.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = false

    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    
    let info = getRandomElement(from: elements)!
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                HStack(spacing: 0) {
                    VStack(alignment: .leading, spacing: 20) {
                        HStack {
                            Text(info.name)
                                .font(.title)
                                .fontWeight(.bold)
                            Spacer()
                            Toggle("AR View", isOn: $showImmersiveSpace)
                                .toggleStyle(.button)
                        }
                        .onChange(of: showImmersiveSpace) { _, newValue in
                            Task {
                                if newValue {
                                    switch await openImmersiveSpace(id: "ImmersiveSpace") {
                                    case .opened:
                                        immersiveSpaceIsShown = true
                                    case .error, .userCancelled:
                                        fallthrough
                                    @unknown default:
                                        immersiveSpaceIsShown = false
                                        showImmersiveSpace = false
                                    }
                                } else if immersiveSpaceIsShown {
                                    await dismissImmersiveSpace()
                                    immersiveSpaceIsShown = false
                                }
                            }
                        }
                        Spacer()
                        ScrollView {
                                HStack {
                                    Spacer()
                                    Atom(info: info)
                                        .padding()
                                        .frame(width: 450, height: 450)
                                        .glassBackgroundEffect()
                                    Spacer()
                                }
                                Spacer()
                                VStack {
                                    Text("\(info.description)\n")
                                    Text("Electronic Configuration")
                                        .fontWeight(.bold)
                                    Text(info.electron_configuration_semantic)
                                    itemDetails(param1: "Atomic Weight", val1: String(format: "%.3f", info.atomicWeight),
                                                param2: "Density", val2: info.density != nil ? String(format: "%.3f", info.density!) : "Not Available")
                                    itemDetails(param1: "Period", val1: "\(info.period)",
                                                param2: "Block", val2: "\(info.block)")
                                }
                                .padding()
                            }
                        }
                        .padding()
                        .font(.title2)
                        .frame(width: geometry.size.width * 0.5)
                    VStack {
                        QuizQuestions()
                    }
                    .padding()
                    .frame(width: geometry.size.width * 0.5)
                }
            }
        }
    }
}


#Preview {
    HomeView()
}
