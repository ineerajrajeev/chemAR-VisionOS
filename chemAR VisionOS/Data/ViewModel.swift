import Foundation

@Observable
class ViewModel
{
    var navigationPath : [ElementInfo] = []
    var lightOn : Bool = false
    var element : ElementInfo = mockData
    var orbitOn: Bool = false
}
