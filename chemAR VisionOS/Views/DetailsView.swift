//
//  DetailsView.swift
//  chemAR VisionOS
//
//  Created by Neeraj Shetkar on 10/12/23.
//

import SwiftUI

struct Details: View {
    
    @Environment(\.colorScheme) var colorScheme
    let info: ElementInfo

    var body: some View {
        ZStack {
            HStack {
                // Atom shells, electrons animation
                VStack {
                    Atom(info: info)
                }
                    .frame(width: 450, height: 450)
                    .glassBackgroundEffect()
                Spacer()
                
                VStack {
                    // Title
                    HStack {
                        Text(info.name)
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                        
                        // Link to AR View
                        NavigationLink(
                            destination: ARViewContainer(),
                            label: {
                                Label("AR View", systemImage: "rotate.3d.fill")
                                    .clipShape(Capsule())
                            }
                        )
                    }
                    Spacer()
                    
                    // Description
                    Text("\(info.description)")
                        .padding()
                    
                    // Electron 
                    Text("Electronic Configuration")
                        .fontWeight(.bold)
                    Text(info.electron_configuration_semantic)
                    itemDetails(param1: "Atomic Weight", val1: String(format: "%.3f", info.atomicWeight),
                                param2: "Density", val2: info.density != nil ? String(format: "%.3f", info.density!) : "Not Available")
                    .padding()
                    itemDetails(param1: "Period", val1: "\(info.period)",
                                param2: "Block", val2: "\(info.block)")
                    .padding()
                    Spacer()
                }
                .font(.title2)
            }
        }
        .padding()
    }
}

#Preview {
    Details(info: mockData)
}
