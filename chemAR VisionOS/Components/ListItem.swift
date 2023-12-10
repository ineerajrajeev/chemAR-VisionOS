//
//  Details.swift
//  App
//
//  Created by Neeraj Shetkar on 07/12/23.
//

import SwiftUI

struct ListItem: View {
    var info: ElementInfo

    var body: some View {
        ZStack {            
            VStack {
                HStack {
                    Text("\(info.number)")
                    Spacer()
                    Text("\(info.name)")
                        .fontWeight(.bold)
                    Spacer()
                    Text("(\(info.symbol))")
                        .fontWeight(.thin)
                        .font(.subheadline)
                }
                Spacer()
                HStack {
                    Text("Category: ")
                        .fontWeight(.bold)
                        .font(.subheadline)
                    Text("\(info.category.capitalized(with: .autoupdatingCurrent))")
                        .fontWeight(.thin)
                        .font(.subheadline)
                    Spacer()
                    Text("State: ")
                        .fontWeight(.bold)
                        .font(.subheadline)
                    Text("\(info.phase.capitalized(with: .autoupdatingCurrent))")
                        .fontWeight(.thin)
                        .font(.subheadline)
                }
            }
            .padding()
        }
    }
}

#Preview {
    ListItem(info: mockData)
}
