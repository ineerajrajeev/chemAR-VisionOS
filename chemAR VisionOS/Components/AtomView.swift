import SwiftUI

struct Atom: View {
    let info: ElementInfo
    
    @State private var electronRotations: [Double] = []
    @Environment(\.colorScheme) var colorScheme
    let animationTimer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    
    var body: some View {
        LazyVStack {
            GeometryReader { geometry in
                ZStack {
                    // Nucleus
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 10, height: 10)
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    
                    // Electron shells
                    ForEach(info.shells.indices, id: \.self) { shellIndex in
                        if shellIndex < electronRotations.count {
                            let shell = info.shells[shellIndex]
                            let radius = CGFloat(shellIndex + 1) * 25
                            
                            // Shell circle
                            Circle()
                                .stroke(colorScheme == .dark ? Color.mint : Color.blue, lineWidth: 2)
                                .frame(width: radius * 2, height: radius * 2)
                                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                                .overlay(
                                    Text("\(shell)")
                                        .position(getTextPosition(for: shellIndex, in: geometry.size, radius: radius))
                                        .foregroundColor(colorScheme == .dark ? Color.white : Color.red)
                                        .font(.subheadline)
                                        .fontWeight(.bold)
                                )
                            
                            // Display electrons in each shell
                            ForEach(0..<shell, id: \.self) { electronIndex in
                                let angle = 360.0 / Double(shell) * Double(electronIndex) + electronRotations[shellIndex]
                                let rotationSpeed = 10.0 / Double(shellIndex + 1)
                                let rotatedAngle = angle + rotationSpeed
                                let xPos = cos(rotatedAngle * .pi / 180) * Double(radius) + Double(geometry.size.width / 2)
                                let yPos = sin(rotatedAngle * .pi / 180) * Double(radius) + Double(geometry.size.height / 2)
                                
                                // Display electron at its relative position
                                Circle()
                                    .fill(colorScheme == .dark ? Color.yellow : Color.red)
                                    .frame(width: 8, height: 8)
                                    .position(x: xPos, y: yPos)
                            }
                        }
                    }
                }
            }
            .padding()
            .onAppear {
                setupRotations()
            }
            .onReceive(animationTimer) { _ in
                animateRotations()
            }
        }
    }
    
    // Rotation angle
    private func setupRotations() {
        electronRotations = Array(repeating: 0.0, count: info.shells.count)
    }
    
    // Text position
    private func getTextPosition(for index: Int, in size: CGSize, radius: CGFloat) -> CGPoint {
            let angle = 360.0 / Double(info.shells.count) * Double(index)
            let xPos = cos(angle * .pi / 180) * Double(radius) + Double(size.width / 2)
            let yPos = sin(angle * .pi / 180) * Double(radius) + Double(size.height / 2)
            return CGPoint(x: xPos, y: yPos)
        }
    
    private func animateRotations() {
        for i in 0..<electronRotations.count {
            electronRotations[i] += 2.0 / Double(i + 1) // Adjust the rotation speed here
        }
    }
}

#Preview {
    Atom(info: mockData)
}
