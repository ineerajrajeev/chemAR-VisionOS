//
//  iPadHome.swift
//  chemAR
//
//  Created by Neeraj Shetkar on 09/12/23.
//

import SwiftUI
import TipKit

struct FavoriteLandmarkTip: Tip {
    private var facts: [String] = [
        "Beryllium is two-thirds the density of aluminum and has six times the specific stiffness of steel by weight. Beryllium ceramics are used to focus and control eye surgery lasers.",
        "Helium atoms are so light that they can escape Earth's gravity! Helium is used in rocket propulsion (to pressurize fuel tanks, especially those for liquid hydrogen, because only helium is still a gas at liquid-hydrogen temperature)",
        "Although it’s rare on Earth, Hydrogen is the most common element in the universe. Hydrogen can be combined with carbon dioxide to make methanol or dimethyl ether (DME) which are important transport fuels.",
        "Lithium is the lightest of all the metals and can easily float on water. Lithium chloride is one of the most hygroscopic (absorbs moisture from the air) materials known and is used in air conditioning and industrial drying systems (as is lithium bromide).",
        "The amount of carbon on Earth is relatively constant; it’s simply transformed from one form to another by the carbon cycle. Impure carbon (e.g. charcoal from wood and coke from coal) is used in metal smelting. The iron and steel industries depend on it.",
        "Fluorine is the most receptive and electronegative of all the chemical elements. It doesn’t respond with oxygen, helium, neon, and argon.",
        "Neon is mainly found in stars. Neon is the 5th most common element in the universe but comprises only 0.0018% of the Earth's atmosphere.",
        "Oxygen is the third most abundant element in the universe; however, its reactivity made it relatively rare in Earth's early atmosphere.",
        "Although abundant on Earth, sodium is never naturally found in its pure form; it forms compounds with other elements.",
        "Hydrogen (H) is the first element and oganesson (O) is the last element (Og).",
        "The first Periodic Table was produced by Russian chemist Dmitri Mendeleev. The contemporary Periodic Table groups elements with increasing atomic numbers as opposed to Mendeleev's table, which arranges elements according to their rising atomic weight.",
        "The Periodic Table is controlled by the International Union of Pure Applied Chemistry IUPAC.",
        "The element that is most prevalent in the universe is hydrogen (H). It accounts for roughly 75% of the entire observable cosmos.",
        "The second most prevalent element in the universe is helium. Over 99% of the observable universe is made up of hydrogen and helium.",
        "The first element to be created artificially was technetium (Tc). In 1937, it was first synthesised.",
        "All the periodic table element symbols are missing one letter: J.",
        "The most recent names of the four elements are 113, 115, 117, and 118. Nihonium (Nh), Moscovium (Mc), Tennessine (Ts), and Oganesson were authorised as the names and symbols for these elements by the International Union of Pure and Applied Chemistry on November 28, 2016. (Og).",
        "Which superhero is your favourite? Thor, the Nordic god of thunder, is the name of the element thorium (Th)."
    ]
    
    var title: Text {
        Text("Atomic fun fact")
    }

    var message: Text? {
        Text(facts.randomElement()!)
    }

    var image: Image? {
        Image(systemName: "atom")
    }
}

struct HomeView: View {
    @Environment(ViewModel.self) private var model
    
    // Show/ Dismiss window
    @Environment(\.openWindow) var openWindow
    @Environment(\.dismissWindow) var dismissWindow
    
    var favoriteLandmarkTip = FavoriteLandmarkTip()

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
                            
                            // More info
                            NavigationLink("More Info", destination: Details(info: info))
                            
                            // AR View button firing up AR View window
                            Button("AR View", action: {
                                if !model.showWindow {
                                    model.element = info
                                    openWindow(id: "AR_View")
                                    model.showWindow = true
                                } else {
                                    if info.number == model.element.number {
                                        dismissWindow(id: "AR_View")
                                        model.showWindow = false
                                    } else {
                                        model.element = info
                                    }
                                    
                                }
                                
                            })
                        }
                        Spacer()
                        
                        // Content view
                        ScrollView {
                                VStack {
                                    TipView(favoriteLandmarkTip, arrowEdge: .bottom)
                                    HStack {
                                        Spacer()
                                        // 2D Atom Model
                                        Atom(info: info)
                                            .padding()
                                            .frame(width: 450, height: 450)
                                            .glassBackgroundEffect()
                                        Spacer()
                                    }
                                }
                                .task {
                                    try? Tips.configure([
                                        .displayFrequency(.daily),
                                        .datastoreLocation(.applicationDefault)
                                    ])
                                }
                                Spacer()
                                VStack {
                                    Text("\(info.description)\n") // Description of an element
                                    Text("Electronic Configuration")
                                        .fontWeight(.bold)
                                    Text(info.electron_configuration_semantic) // Electronic configuration
                                    itemDetails(param1: "Atomic Weight", val1: String(format: "%.3f", info.atomicWeight),
                                                param2: "Nature", val2: info.category)
                                    .padding()
                                    itemDetails(param1: "Period", val1: "\(info.period)",
                                                param2: "Block", val2: "\(info.block)")
                                    .padding()
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
