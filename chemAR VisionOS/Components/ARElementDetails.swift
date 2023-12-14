//
//  ARElementDetails.swift
//  chemAR VisionOS
//
//  Created by Neeraj Shetkar on 11/12/23.
//
import SwiftUI

struct ARElementDetails: View {
    
    @Environment(ViewModel.self) private var model
    
    @State private var info: ElementInfo
    
    @State private var orbitOn = false
    @State private var lightOn = false
    
    init(info: ElementInfo) {
        _info = State(initialValue: info)
    }
    
    func lightButton() {
        model.lightOn = !model.lightOn
    }
    
    func orbitButton() {
        model.orbitOn = !model.orbitOn
    }

    var body: some View {
        VStack {
            Text("\(info.name) (\(info.number))")
                .font(.title3)
            VStack {
                HStack {
                    Text("Atomic Weight")
                        .fontWeight(.bold)
                    Spacer()
                    Text("Density")
                        .fontWeight(.bold)
                }
                HStack {
                    Text(String(format: "%.3f", info.atomicWeight))
                    Spacer()
                    Text(info.density != nil ? String(format: "%.3f", info.density!) : "Not Available")
                }
            }
            .padding()
            
            VStack {
                HStack {
                    Text("Period")
                        .fontWeight(.bold)
                        .font(.title3)
                    Spacer()
                    Text("Block")
                        .fontWeight(.bold)
                        .font(.title3)
                }
                HStack {
                    Text("\(info.period)")
                    Spacer()
                    Text("\(info.block)")
                }
            }
            .padding()
        }
        .padding(EdgeInsets(top: 5, leading: 25, bottom: 0, trailing: 25))
        .frame(width: 300, height: 200)
        .glassBackgroundEffect()
    }
}


#Preview {
    ARElementDetails(info: mockData)
}
