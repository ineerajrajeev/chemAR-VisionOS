//
//  questionGenerator.swift
//  chemAR
//
//  Created by Neeraj Shetkar on 09/12/23.
//

import SwiftUI

func questionGenerator() -> (question: String, correctAnswer: String, options: [String], element: ElementInfo) {
    let someElement = elements.values.randomElement() ?? mockData
    
    let questions: [String: String] = [
        "number": "What is an atomic number of \(someElement.name)?",
        "block": "Which block does \(someElement.name) belong?",
        "atomicweight": "What is an atomic weight of \(someElement.name)?",
        "period": "Which period does \(someElement.name) belong to?",
        "symbol": "Which of the following is the symbol of \(someElement.name)?",
        "electrons": "How many electrons are there in \(someElement.name)?"
    ]
    
    let key: String = questions.keys.randomElement() ?? "symbol"
    
    let question: String = questions[key] ?? "Which of the following is the symbol of \(someElement.name)?"
    var optionsForQuiz: [String] = []
    var correctAnswer: String = ""
    
    if key == "number" || key == "electrons" {
        correctAnswer = "\(someElement.number)"
        optionsForQuiz.append("\(someElement.number)")
        while optionsForQuiz.count < 4 {
            let newItem = elements.values.randomElement() ?? mockData
            let newOption = newItem.number
            if newOption != someElement.number && !optionsForQuiz.contains("\(newOption)") {
                optionsForQuiz.append("\(newOption)")
            }
        }
    } else if key == "block" {
        correctAnswer = "\(someElement.block)"
        optionsForQuiz.append("\(someElement.block)")
        while optionsForQuiz.count < 4 {
            let newItem = elements.values.randomElement() ?? mockData
            let newOption = newItem.block
            if newOption != someElement.block && !optionsForQuiz.contains(newOption) {
                optionsForQuiz.append(newOption)
            }
        }
    } else if key == "atomicweight" {
        correctAnswer = "\(someElement.atomicWeight)"
        optionsForQuiz.append("\(someElement.atomicWeight)")
        while optionsForQuiz.count < 4 {
            let newItem = elements.values.randomElement() ?? mockData
            let newOption = newItem.atomicWeight
            if newOption != someElement.atomicWeight && !optionsForQuiz.contains("\(String(format: "%.1f", newOption))") {
                optionsForQuiz.append("\(String(format: "%.1f", newOption))")
            }
        }
    } else if key == "period" {
        correctAnswer = "\(someElement.period)"
        optionsForQuiz.append("\(someElement.period)")
        while optionsForQuiz.count < 4 {
            let newItem = elements.values.randomElement() ?? mockData
            let newOption = newItem.period
            if newOption != someElement.period && !optionsForQuiz.contains("\(newOption)") {
                optionsForQuiz.append("\(newOption)")
            }
        }
    } else if key == "symbol" {
        correctAnswer = "\(someElement.symbol)"
        optionsForQuiz.append("\(someElement.symbol)")
        while optionsForQuiz.count < 4 {
            let newItem = elements.values.randomElement() ?? mockData
            let newOption = newItem.symbol
            if newOption != someElement.symbol && !optionsForQuiz.contains("\(newOption)") {
                optionsForQuiz.append("\(newOption)")
            }
        }
    }
    optionsForQuiz.shuffle()

    return (question, correctAnswer, optionsForQuiz, someElement)
}
