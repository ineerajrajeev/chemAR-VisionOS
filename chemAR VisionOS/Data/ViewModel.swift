import Foundation

class ViewModel: Observable
{
    var navigationPath : [ElementInfo] = []
    var lightOn : Bool = false
    var element : ElementInfo = mockData
    @Published var orbitOn: Bool = true
    var showWindow: Bool = false
}
