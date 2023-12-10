//
//  BlocksView.swift
//  chemAR VisionOS
//
//  Created by Neeraj Shetkar on 10/12/23.
//

import SwiftUI

enum Blocks: String, CaseIterable {
    case all = "*"
    case s = "s"
    case p = "p"
    case d = "d"
    case f = "f"
}

struct BlockView: View {
    @State private var searchTerm = ""
    @State private var selectedBlock: Blocks = .s

    var filteredElements: [String: ElementInfo] {
        if selectedBlock == .all {
            guard !searchTerm.isEmpty else { return elements }
            return elements.filter {
                $0.value.name.localizedCaseInsensitiveContains(searchTerm) ||
                $0.value.symbol.localizedCaseInsensitiveContains(searchTerm) ||
                String($0.value.number).localizedCaseInsensitiveContains(searchTerm)
            }
        } else {
            let blockElements = Dictionary(uniqueKeysWithValues:
                elements.filter { filterElementsByBlock(block: selectedBlock.rawValue).keys.contains($0.key) }
            )
            guard !searchTerm.isEmpty else { return blockElements }
            return blockElements.filter {
                $0.value.name.localizedCaseInsensitiveContains(searchTerm) ||
                $0.value.symbol.localizedCaseInsensitiveContains(searchTerm)
            }
        }
    }
    
    var sortedElements: [ElementInfo] {
        filteredElements.values.sorted { $0.number < $1.number }
    }

    var body: some View {
        VStack {
            HStack {
                Text("\(selectedBlock.rawValue.uppercased()) Block")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding()
            SearchBar(searchTerm: $searchTerm)
            
            Picker(selection: $selectedBlock, label: Text("Block")) {
                ForEach(Blocks.allCases, id: \.self) {
                    Text("\($0.rawValue.uppercased()) Block")
                }
            }
            .pickerStyle(.segmented)
            .padding()
            
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

struct BlockView_Previews: PreviewProvider {
    static var previews: some View {
        BlockView()
    }
}

