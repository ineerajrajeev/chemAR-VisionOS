//
//  BlocksView.swift
//  chemAR VisionOS
//
//  Created by Neeraj Shetkar on 10/12/23.
//

import SwiftUI

// Define blocks in Directory
enum Blocks: String, CaseIterable {
    case all = "*"
    case s = "s"
    case p = "p"
    case d = "d"
    case f = "f"
}

struct BlockView: View {
    @State private var searchTerm = "" // Search term
    @State private var selectedBlock: Blocks = .s // Selected block from picker

    var filteredElements: [String: ElementInfo] {
        // Show all elements if block is set to "all"
        if selectedBlock == .all {
            guard !searchTerm.isEmpty else { return elements }
            return elements.filter {
                $0.value.name.localizedCaseInsensitiveContains(searchTerm) ||
                $0.value.symbol.localizedCaseInsensitiveContains(searchTerm) ||
                String($0.value.number).localizedCaseInsensitiveContains(searchTerm)
            }
        } else {
            // Filter elements from a particular block
            let blockElements = Dictionary(uniqueKeysWithValues:
                elements.filter { filterElementsByBlock(block: selectedBlock.rawValue).keys.contains($0.key) }
            )
            guard !searchTerm.isEmpty else { return blockElements } // ALl elements in particular block if search block is empty
            return blockElements.filter {
                $0.value.name.localizedCaseInsensitiveContains(searchTerm) ||
                $0.value.symbol.localizedCaseInsensitiveContains(searchTerm)
            }
        }
    }
    
    var sortedElements: [ElementInfo] {
        filteredElements.values.sorted { $0.number < $1.number }
    } // Sort elements

    var body: some View {
        VStack {
            HStack {
                Text("\(selectedBlock.rawValue.uppercased()) Block")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                // Block title
            }
            .padding()
            
            SearchBar(searchTerm: $searchTerm) // Search bar
            
            // Picker element containing list of all blocks
            Picker(selection: $selectedBlock, label: Text("Block")) {
                ForEach(Blocks.allCases, id: \.self) {
                    Text("\($0.rawValue.uppercased()) Block")
                }
            }
            .pickerStyle(.segmented)
            .padding()
            
            // List of all sorted elements
            List(sortedElements, id: \.name) { element in
                NavigationLink(destination: Details(info: element)) {
                    ListItem(info: element)
                        .frame(maxWidth: .infinity)
                        .padding(8)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(blockColor(element.block))
                        )
                }
            }
        }
        .listStyle(PlainListStyle())
        .navigationBarTitleDisplayMode(.inline)
        .padding(10)
    }
    
    // Select color for a list item in given block
    func blockColor(_ block: String) -> Color {
        switch block {
        case "s": return Color("sblock_background")
        case "p": return Color("pblock_background")
        case "d": return Color("dblock_background")
        case "f": return Color("fblock_background")
        default: return Color.white
        }
    }
}

struct SearchBar: View {
    @Binding var searchTerm: String
    
    // Seaarch bar component
    var body: some View {
        HStack {
            TextField("Search element", text: $searchTerm)
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding([.leading, .trailing])
        }
    }
}
