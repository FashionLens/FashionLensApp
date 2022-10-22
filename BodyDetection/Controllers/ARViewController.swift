//
//  ARViewController.swift
//  BodyDetection
//
//  Created by Team Fashion Lens on 10/22/22.
//  Copyright © 2022 Apple. All rights reserved.
//

import UIKit
import RealityKit
import ARKit
import Combine

class Lighting: Entity, HasDirectionalLight, HasAnchoring {

    required init() {
        super.init()
        self.light = DirectionalLightComponent(color: .white,
                                           intensity: 2000,
                                    isRealWorldProxy: true)
    }
}


class ARViewController: UIViewController, ARSessionDelegate {

    @IBOutlet var arView: ARView!
    
    @IBOutlet weak var button1: UIButton!
    
    @IBOutlet weak var button2: UIButton!
    
    @IBOutlet weak var button3: UIButton!
    
    @IBOutlet weak var button4: UIButton!
    
    // The 3D character to display.
    var character: BodyTrackedEntity?
    let characterOffset: SIMD3<Float> = [0, 0, 0] // Offset the character by one meter to the left
    let characterAnchor = AnchorEntity()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        arView.session.delegate = self
        self.navigationController?.setNavigationBarHidden(true, animated: false)

        // If the iOS device doesn't support body tracking, raise a developer error for
        // this unhandled case.
        guard ARBodyTrackingConfiguration.isSupported else {
            fatalError("This feature is only supported on devices with an A12 chip")
        }

        // Run a body tracking configration.
        let configuration = ARBodyTrackingConfiguration()
        arView.session.run(configuration)
        
        arView.scene.addAnchor(characterAnchor)
    
        // add lights
        let light = Lighting()
        light.orientation = simd_quatf(angle: .pi/8,
                                        axis: [0, 1, 0])

        let directLightAnchor = AnchorEntity()
        directLightAnchor.addChild(light)
        characterAnchor.addChild(directLightAnchor)
                
        // Asynchronously load the 3D character.
        var cancellable: AnyCancellable? = nil
        cancellable = Entity.loadBodyTrackedAsync(named: "character/good_space_suit").sink(
            receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Error: Unable to load model: \(error.localizedDescription)")
                }
                cancellable?.cancel()
        }, receiveValue: { (character: Entity) in
            if let character = character as? BodyTrackedEntity {
                // Scale the character to human size
                character.scale = [0.01, 0.01, 0.01]
                character.position = [0.0, 0.0, 0.0]
//                character.orientation = simd_quatf(angle: -3.14/4, axis: SIMD3(1, 0, 0))
                self.character = character
                cancellable?.cancel()
            } else {
                print("Error: Unable to load model as BodyTrackedEntity")
            }
        })
    }

    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        for anchor in anchors {
            guard let bodyAnchor = anchor as? ARBodyAnchor else { continue }
            
            // Update the position of the character anchor's position.
            let bodyPosition = simd_make_float3(bodyAnchor.transform.columns.3)
            characterAnchor.position = bodyPosition + characterOffset
            // Also copy over the rotation of the body anchor, because the skeleton's pose
            // in the world is relative to the body anchor's rotation.
            characterAnchor.orientation = Transform(matrix: bodyAnchor.transform).rotation
   
            if let character = character, character.parent == nil {
                // Attach the character to its anchor as soon as
                // 1. the body anchor was detected and
                // 2. the character was loaded.
                characterAnchor.addChild(character)
            }
        }
    }
    
    
    @IBAction func button1Click(_ sender: UIButton) {
        selectButton(i: 0)
    }
    
    
    @IBAction func button2Click(_ sender: UIButton) {
        selectButton(i: 1)
    }
    
    
    @IBAction func button3Click(_ sender: UIButton) {
        selectButton(i: 2)
    }
    
    
    @IBAction func button4Click(_ sender: UIButton) {
        selectButton(i: 3)
    }
    
    func resetButtonSizes() {
        let normalBtnConfig = UIImage.SymbolConfiguration(pointSize: 65, weight: .semibold, scale: .large)
        let normalBtnImage = UIImage(systemName: "circle", withConfiguration: normalBtnConfig)
       
        button1.setImage(normalBtnImage, for: .normal)
        button2.setImage(normalBtnImage, for: .normal)
        button3.setImage(normalBtnImage, for: .normal)
        button4.setImage(normalBtnImage, for: .normal)
    }
    
    func selectButton(i: Int32) {
        resetButtonSizes()
        
        let largeBtnConfig = UIImage.SymbolConfiguration(pointSize: 100, weight: .semibold, scale: .large)
        let largeBtnImage = UIImage(systemName: "circle", withConfiguration: largeBtnConfig)
        
        if (i == 0) {
            button1.setImage(largeBtnImage, for: .normal)
        } else if (i == 1) {
            button2.setImage(largeBtnImage, for: .normal)
        } else if (i == 2) {
            button3.setImage(largeBtnImage, for: .normal)
        } else if (i == 3) {
            button4.setImage(largeBtnImage, for: .normal)
        }
    }
}
