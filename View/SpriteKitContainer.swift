//
//  SpriteKitContainer.swift
//  MaxCosmicJourney
//
//  Created by Joshua Cox on 4/8/24.
//

import Foundation
import SpriteKit
import SwiftUI

// A SwiftUI wrapper that integrates SpriteKit by using a UIViewControllerRepresentable.
// This allows the use of SpriteKit scenes within a SwiftUI-based app.
struct SpriteKitContainer: UIViewControllerRepresentable {
    // Creates and configures a UIViewController that hosts an SKView for displaying the SpriteKit scene.
    func makeUIViewController(context: Context) -> UIViewController {
        
        // Create a standard UIViewController to host the SKView.
        let controller = UIViewController()
        
        // Create an SKView that fills the entire screen.
        let skView = SKView(frame: UIScreen.main.bounds)
        
        // Add the SKView as a subview to the controller's view.
        controller.view.addSubview(skView)
        
        // Create and configure the SpriteKit scene.
        let scene = OrbitScene(size: skView.bounds.size)
        scene.scaleMode = .resizeFill
        
        // Present the scene within the SKView.
        skView.presentScene(scene)
        
        return controller
    }
    
    // Updates the UIViewController when the SwiftUI view is updated.
    // This method is currently empty as no updates are needed for the view controller.
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}
