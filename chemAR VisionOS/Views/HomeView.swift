//
//  iPadHome.swift
//  chemAR
//
//  Created by Neeraj Shetkar on 09/12/23.
//

import SwiftUI

struct HomeView: View {
    @Environment(ViewModel.self) private var model
    
    // Show/ Dismiss window
    @Environment(\.openWindow) var openWindow
    @Environment(\.dismissWindow) var dismissWindow
    
    @State private var showWindow: Bool = false

    let info = getRandomElement(from: elements)! // Get random element from elements to show information on home screen
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                
                // Title bar
                HStack(spacing: 0) {
                    VStack(alignment: .leading, spacing: 20) {
                        HStack {
                            // Name of an random element selected to be shown on home screen
                            Text(info.name)
                                .font(.title)
                                .fontWeight(.bold)
                            Spacer()
                            
                            // AR View button firing up AR View window
                            Button("AR View", action: {
                                if !showWindow {
                                    openWindow(id: "AR_View")
                                    model.element = info
                                    showWindow = true
                                } else {
                                    dismissWindow(id: "AR_View")
                                    showWindow = false
                                }
                                
                            })
                        }
                        Spacer()
                        
                        // Content view
                        ScrollView {
                                HStack {
                                    Spacer()
                                    // 2D Atom Model
                                    Atom(info: info)
                                        .padding()
                                        .frame(width: 450, height: 450)
                                        .glassBackgroundEffect()
                                    Spacer()
                                }
                                Spacer()
                                VStack {
                                    Text("\(info.description)\n") // Description of an element
                                    Text("Electronic Configuration")
                                        .fontWeight(.bold)
                                    Text(info.electron_configuration_semantic) // Electronic configuration
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
                        QuizQuestions() // Quiz question component
                    }
                    .padding()
                    .frame(width: geometry.size.width * 0.5)
                }
            }
        }
    }
}
