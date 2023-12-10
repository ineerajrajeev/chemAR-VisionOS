//
//  randomElement.swift
//  chemAR
//
//  Created by Neeraj Shetkar on 09/12/23.
//

import Foundation

func getRandomElement(from elements: [String: ElementInfo]) -> ElementInfo? {
    guard let randomValue = elements.randomElement()?.value else {
        return nil
    }
    return randomValue
}
