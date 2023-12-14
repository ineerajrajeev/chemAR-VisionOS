// Credits to Apple for this example
// This sets Image based lighting for model obejcts
import RealityKit

extension Entity {
    func setSunlight(intensity: Float?) {
        if let intensity {
            Task {
                // Use file "ImageBasedLight" for lighting
                guard let resource = try? await EnvironmentResource(named: "ImageBasedLight") else { return }
                let iblComponent = ImageBasedLightComponent(
                    source: .single(resource),
                    intensityExponent: intensity)
                
                components.set(iblComponent)
                components.set(ImageBasedLightReceiverComponent(imageBasedLight: self))
            }
        } else {
            components.remove(ImageBasedLightComponent.self)
            components.remove(ImageBasedLightReceiverComponent.self)
        }
    }
}
