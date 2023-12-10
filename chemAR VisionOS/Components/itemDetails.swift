//
//  itemDetails.swift
//  chemAR
//
//  Created by Neeraj Shetkar on 08/12/23.
//

import SwiftUI

struct itemDetails: View {
    let param1: String
    let val1: String
    
    let param2: String
    let val2: String
    
    var body: some View {
        VStack {
            HStack {
                Text(param1)
                    .fontWeight(.bold)
                    .font(.title2)
                Spacer()
                Text(param2)
                    .fontWeight(.bold)
                    .font(.title2)
            }
            HStack {
                Text(val1)
                Spacer()
                Text(val2)
            }
        }
    }
}

#Preview {
    itemDetails(param1: "Atomic Weight", val1: "1.001", param2: "Density", val2: "1.002")
}
