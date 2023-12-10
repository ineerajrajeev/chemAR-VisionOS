import Foundation

struct ElementInfo: Identifiable {
    let id = UUID()
    let name: String
    let shells: [Int]
    let electron_configuration_semantic: String
    let atomicWeight: Double
    let category: String
    let density: Double?
    let period: Int
    let group: Int
    let phase: String
    let description: String
    let symbol: String
    let block: String
    let number: Int
}
