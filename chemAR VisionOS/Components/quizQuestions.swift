//
//  quizQuestions.swift
//  chemAR
//
//  Created by Neeraj Shetkar on 09/12/23.
//
import SwiftUI

struct QuizQuestions: View {
    // Check for Color Scheme
    @Environment(\.colorScheme) var colorScheme
    
    // Boolean variables to show/un show the components
    @State private var showMessage = false
    @State private var ans = false
    
    // Question related variables
    @State private var question = questionGenerator()
    @State private var correctAnswer = ""
    @State private var options = [String]()
    @State private var showCard = false
    @State private var cardData: ElementInfo
    
    
    // Messages
    let successMessages: [String] = ["Excellent", "Good job", "Great", "You seem to be a champion", "Keep it up", "Good", "Keep moving"]
    
    let failureMessages: [String] = ["Oops!", "Try again", "Not quite", "Incorrect", "Keep practicing", "Missed it", "Wrong answer"]

    // Initiating variables
    init() {
        let info = questionGenerator()
        self._correctAnswer = State(initialValue: info.correctAnswer)
        self._options = State(initialValue: info.options)
        self._cardData = State(initialValue: info.element)
    }

    var body: some View {
        ZStack {
            VStack {
                if showMessage {
                    VStack {
                        Text(ans ? "\(successMessages.randomElement()!)": "\(failureMessages.randomElement()!)")
                            .foregroundStyle(ans ? Color.green : Color.red)
                    }
                    .font(.title2)
                    .padding()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                showMessage = false
                            }
                        }
                    }
                } else {
                    // When not to show messages
                    Text(" ")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(ans ? Color.green : Color.red)
                        .padding()
                }
                VStack {
                    Text("Quiz")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("\(question.question)") // Question
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding()
                    
                    HStack {
                        // Options
                        ForEach(options, id: \.self) { option in
                            Button(action: {
                                if (option == correctAnswer) {
                                    ans = true
                                    showMessage = true
                                    cardData = question.element
                                    updateQuestion()
                                } else {
                                    ans = false
                                    showMessage = true
                                }
                            }) {
                                Text(option)
                                    .padding()
                                    .frame(width: 80, height: 50)
                                    .clipShape(Capsule())
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
                .padding()
                .glassBackgroundEffect()
                Spacer()
                
                // Show Card
                if showMessage {
                    VStack {
                        if (ans) {
                            VStack {
                                Text("\(cardData.name) (\(cardData.number))")
                                    .font(.title)
                                    .fontWeight(.bold)
                                itemDetails(param1: "Phase", val1: cardData.phase,
                                            param2: "Shells", val2: String(cardData.shells.count))
                                    .padding()
                                itemDetails(param1: "Atomic Weight", val1: String(format: "%.3f", cardData.atomicWeight),
                                            param2: "Density", val2: cardData.density != nil ? String(format: "%.3f", cardData.density!) : "Not Available")
                                    .padding()
                                itemDetails(param1: "Period", val1: "\(cardData.period)",
                                            param2: "Block", val2: "\(cardData.block)")
                                    .padding()
                            }
                            .padding()
                            .glassBackgroundEffect()
                        }
                    }
                    .font(.title2)
                    .padding()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                showMessage = false
                            }
                        }
                    }
                } else {
                    // When not to show messages
                    Text(" ")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(ans ? Color.green : Color.red)
                        .padding()
                }
            }
            .padding()
        }
        .onAppear {
            correctAnswer = question.correctAnswer
            options = question.options
            cardData = question.element
        }
    }
    
    func updateQuestion() {
        question = questionGenerator()
        correctAnswer = question.correctAnswer
        options = question.options
    }
}

#Preview {
    QuizQuestions()
}

