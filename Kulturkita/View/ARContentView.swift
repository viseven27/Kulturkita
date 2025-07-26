//
//  ARContentView.swift
//  Kulturkita
//
//  Created by Alvin Justine on 23/07/25.
//

import SwiftUI
import RealityKit        // 1️⃣ RealityKit for AnchorEntity, ModelEntity, etc.
import ARKit            // 1️⃣ ARKit for ARImageAnchor, ARSession, ARWorldTrackingConfiguration
import Combine          // 1️⃣ Combine for AnyCancellable

struct ARContentView: UIViewRepresentable {
    // Hold onto our ARView so coordinator can add anchors to it
    class Coordinator: NSObject, ARSessionDelegate {
        weak var arView: ARView?                // ③ wire in ARView
        private var cancellables = Set<AnyCancellable>()
        
        // This is called whenever ARKit adds a new anchor
        func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
            for anchor in anchors {
                guard let imgAnchor = anchor as? ARImageAnchor,
                  imgAnchor.referenceImage.name == "boat_image"
                else { continue }
                
                // ② RealityKit AnchorEntity init takes the anchor _without_ the "anchor:" label
                let anchorEntity = AnchorEntity(world: imgAnchor.transform)
                
                
                // Even if you don't yet have boat_v3.usdz, this compiles:
//                ModelEntity.loadAsync(named: "boat_v3")
//                  .sink(receiveCompletion: { _ in },
//                        receiveValue: { model in
//                            model.scale = [0.2, 0.2, 0.2]
//                            anchorEntity.addChild(model)
//                        })
//                  .store(in: &self.cancellables)
//                
//                // Add to the scene
//                arView?.scene.addAnchor(anchorEntity)
                
                ModelEntity.loadAsync(named: "boat_v3")
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .failure(let error):
                            print("❌ Failed to load model: \(error.localizedDescription)")
                        case .finished:
                            print("✅ Model load finished")
                        }
                    }, receiveValue: { model in
                        model.scale = [0.2, 0.2, 0.2]
                        anchorEntity.addChild(model)
                        print("✅ Model added to anchor")
                    })
                    .store(in: &self.cancellables)
                    arView?.scene.addAnchor(anchorEntity)
                
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        // ③ give the coordinator a reference so it can call arView.scene.addAnchor(...)
        context.coordinator.arView = arView
        
        // Configure image detection
        let config = ARWorldTrackingConfiguration()
        if let images = ARReferenceImage.referenceImages(
            inGroupNamed: "AR Resources", bundle: nil
        ) {
            config.detectionImages = images
            config.maximumNumberOfTrackedImages = 1
        }
        arView.session.delegate = context.coordinator
        arView.session.run(config, options: [.resetTracking, .removeExistingAnchors])
        
        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) { }
}

