//
//  DetailsView.swift
//  chemAR VisionOS
//
//  Created by Neeraj Shetkar on 10/12/23.
//

import SwiftUI

struct Details: View {
    
    @Environment(ViewModel.self) private var model
    // Show/ Dismiss window
    @Environment(\.openWindow) var openWindow
    @Environment(\.dismissWindow) var dismissWindow

    
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
                        Button("AR View", action: {
                            if !model.showWindow {
                                openWindow(id: "AR_View")
                                model.element = info
                                model.showWindow = true
                            } else {
                                if info.number == model.element.number {
                                    model.showWindow = false
                                    dismissWindow(id: "AR_View")
                                } else {
                                    dismissWindow(id: "AR_View")
                                    model.element = info
                                    openWindow(id: "AR_View")
                                }
                            }
                            
                        })
                    }
                    Spacer()
                    
                    // Description
                    Text("\(info.description)")
                        .padding()
                    
                    // Electron 
                    Text("Electronic Configuration")
                        .fontWeight(.bold)
                    Text(info.electron_configuration_semantic)
                    itemDetails(param1: "Discovered By", val1: info.discovered_by != nil ? info.discovered_by! : "Not Available",
                                param2: "Appearance", val2: info.appearance != "None" ? info.appearance : "Not Available")
                    .padding()
                    itemDetails(param1: "Atomic Weight", val1: String(format: "%.3f", info.atomicWeight),
                                param2: "Density", val2: info.density != nil ? String(format: "%.3f", info.density!) : "Not Available")
                    .padding()
                    itemDetails(param1: "Period", val1: "\(info.period)",
                                param2: "Block", val2: "\(info.block)")
                    .padding()
                    itemDetails(param1: "Melting Point", val1: info.melting_point != nil ? String(format: "%.3f", info.melting_point!) : "Not Available",
                                param2: "Boiling Point", val2: info.boiling_point != nil ? String(format: "%.3f", info.boiling_point!) : "Not Available")
                    .padding()
                    itemDetails(param1: "Electron affinity", val1: info.electron_affinity != nil ? String(format: "%.3f", info.electron_affinity!) : "Not Available",
                                param2: "Molar heat", val2: info.molar_heat != nil ? String(format: "%.3f", info.molar_heat!) : "Not Available")
                    .padding()
                    Spacer()
                }
                .font(.title2)
            }
        }
        .padding()
    }
}
