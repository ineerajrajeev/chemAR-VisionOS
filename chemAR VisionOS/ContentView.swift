//
//  ContentView.swift
//  chemAR VisionOS
//
//  Created by Neeraj Shetkar on 10/12/23.

import SwiftUI
import RealityKit
import RealityKitContent
import TipKit

struct ContentView: View {
    
    struct ElementTip: Tip {
        let info: ElementInfo
        var title: Text {
            Text("What is \(info.name) ?")
        }
        var message: Text? {
            Text("You can get to know new elements everytime you open an app")
        }
        var image: Image? {
            Image(systemName: "atom")
        }
    }
    
    var body: some View {
        ZStack {
            NavigationStack {
                VStack {
                    TabView {
                        VStack {
                            HomeView()
                        }
                        .tabItem {
                            Label("Home", systemImage: "house")
                        }
                        BlockView()
                            .tabItem {
                                Label("Directory", systemImage: "book.pages")
                            }
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
