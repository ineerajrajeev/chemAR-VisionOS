//
//  variables.swift
//  chemAR VisionOS
//
//  Created by Neeraj Shetkar on 11/12/23.
//

import Foundation

@Observable
class ViewModel
{
    var navigationPath : [ElementInfo] = []
    var isShowingRocketCapsule : Bool = false
    var isShowingFullRocket : Bool = false
    var isShowingMixedRocket : Bool = false
    
    var capsuleRealityAreaId: String = "CapsuleRealityArea"
    var fullRocketRealityArea: String = "FullRocketRealityArea"
    var mixedRocketRealityArea: String = "MixedRocketRealityArea"
}
