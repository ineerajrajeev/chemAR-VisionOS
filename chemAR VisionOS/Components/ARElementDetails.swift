//
//  ARElementDetails.swift
//  chemAR VisionOS
//
//  Created by Neeraj Shetkar on 11/12/23.
//
import SwiftUI

struct ARElementDetails: View {
    
    @State private var info: ElementInfo
    
    @State private var orbitOn = false
    @State private var lightOn = false
    @State private var isShowing = false
    
    init(info: ElementInfo) {
        _info = State(initialValue: info)
        _orbitOn = State(initialValue: orbitOn)
        _lightOn = State(initialValue: lightOn)
        _isShowing = State(initialValue: isShowing)
    }
    
    func lightButton() {
        print(lightOn)
        lightOn = !lightOn
    }
    
    func orbitButton() {
        orbitOn = !orbitOn
    }

    var body: some View {
        VStack {
            Button {
                isShowing.toggle()
            } label: {
                Label("More Info", systemImage: "info.circle")
            }
            .controlSize(.mini)
            .font(.system(size: 10))
        }
        if isShowing {
            VStack {
                Text("\(info.name) (\(info.number))")
                    .font(.title3)
                
                Text(info.description)
                    .font(.caption2)
                
                HStack(alignment:.top) {
                    VStack(alignment:.leading) {
                        Toggle(isOn: $lightOn){
                            Text("Light \(!lightOn ? "Off" : "On")")
                                .font(.system(size: 8, weight:. bold))
                                .onChange(of: lightOn, {
                                    lightButton()
                                })
                        }
                    }
                    
                    VStack(alignment:.leading) {
                        Toggle(isOn: $orbitOn){
                            Text("Orbit \(!orbitOn ? "Off" : "On")")
                                .font(.system(size: 8, weight:. bold))
                                .onChange(of: orbitOn, {
                                    orbitButton()
                                })
                        }
                    }
                }
            }
            .padding(EdgeInsets(top: 5, leading: 25, bottom: 0, trailing: 25))
            .frame(width: 300, height: 200)
            .glassBackgroundEffect()
        }
    }
}


#Preview {
    ARElementDetails(info: mockData)
}
