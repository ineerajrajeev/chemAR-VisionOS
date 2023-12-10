//
//  filterDataView.swift
//  App
//
//  Created by Neeraj Shetkar on 07/12/23.
//

import Foundation

func filterElementsByBlock(block: String) -> [String: ElementInfo] {
    if block != "all" {
        let elements: [String: ElementInfo] = elements
        
        var blockElements: [String: ElementInfo] = [:]
        
        for (key, element) in elements {
            if element.block == block {
                blockElements[key] = element
            }
        }
        
        return blockElements
    } else {
        return elements
    }
}

