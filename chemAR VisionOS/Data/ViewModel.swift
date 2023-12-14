import Foundation

class ViewModel: Observable
{
    var navigationPath : [ElementInfo] = []
    var lightOn : Bool = false
    var element : ElementInfo = mockData
    @Published var orbitOn: Bool = false
    var showWindow: Bool = false
}
