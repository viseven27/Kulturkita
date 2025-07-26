//
//  ARAlternatives.swift
//  Kulturkita
//
//  Created by Alvin Justine on 26/07/25.
//

import SwiftUI
import RealityKit
import ARKit
import Combine

struct ARAlternatives: UIViewRepresentable {
    
    class Coordinator: NSObject {
        var cancellables = Set<AnyCancellable>()
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        // Start AR session with world tracking
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        arView.session.run(config, options: [.resetTracking, .removeExistingAnchors])
        
        // Automatically add lighting
        arView.automaticallyConfigureSession = true


        // Load the model and place it 0.5m in front of the camera
        ModelEntity.loadAsync(named: "boat_v3")
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("❌ Failed to load model: \(error.localizedDescription)")
                case .finished:
                    print("✅ Model loading finished")
                }
            }, receiveValue: { model in
                print("✅ Model loaded and ready")

                model.scale = SIMD3<Float>(repeating: 0.2)

                let anchor = AnchorEntity(world: .zero) // anchored at world origin
                model.position = [0, 0, -0.5]           // move it in front of the camera
 // use camera-relative placement
                model.position = [0, 0, -0.5] // half a meter in front
                anchor.addChild(model)

                arView.scene.anchors.append(anchor)
            })
            .store(in: &context.coordinator.cancellables)
        
        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {
        // no updates needed
    }
}
