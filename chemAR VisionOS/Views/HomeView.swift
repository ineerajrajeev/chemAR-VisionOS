//
//  iPadHome.swift
//  chemAR
//
//  Created by Neeraj Shetkar on 09/12/23.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.colorScheme) var colorScheme
    
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
                            NavigationLink(
                                destination: ARViewContainer(info: info),
                                label: {
                                    Label("AR View", systemImage: "rotate.3d.fill")
                                        .frame(width: 150, height: 50)
                                        .clipShape(Capsule())
                                }
                            )
                        }
                        Spacer()
                        ScrollView {
                            HStack {
                                Spacer()
                                Atom(info: info)
                                    .frame(width: 450, height: 450)
                                    .glassBackgroundEffect()
                                Spacer()
                            }
                            Spacer()
                            Text("\(info.description)\n")
                            Text("Electronic Configuration")
                                .fontWeight(.bold)
                            Text(info.electron_configuration_semantic)
                            itemDetails(param1: "Atomic Weight", val1: String(format: "%.3f", info.atomicWeight),
                                        param2: "Density", val2: info.density != nil ? String(format: "%.3f", info.density!) : "Not Available")
                            itemDetails(param1: "Period", val1: "\(info.period)",
                                        param2: "Block", val2: "\(info.block)")
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
