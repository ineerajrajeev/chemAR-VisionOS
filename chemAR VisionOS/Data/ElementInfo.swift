import Foundation

struct ElementInfo: Identifiable {
    let id = UUID()
    let name: String
    let shells: [Int]
    let appearance: String
    let electron_configuration_semantic: String
    let atomicWeight: Float
    let category: String
    let density: Float?
    let discovered_by: String?
    let melting_point: Float?
    let boiling_point: Float?
    let period: Int
    let group: Int
    let phase: String
    let description: String
    let symbol: String
    let block: String
    let number: Int
    let electron_affinity: Float?
    let molar_heat: Float?
}
