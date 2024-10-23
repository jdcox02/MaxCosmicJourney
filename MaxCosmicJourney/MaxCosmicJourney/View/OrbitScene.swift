//
//  OrbitScene.swift
//  MaxCosmicJourney
//
//  Created by Joshua Cox on 4/8/24.
//

import Foundation
import SpriteKit


// OrbitScene manages a space scene where users can add planets that orbit a sun.
// It includes interaction for adding planets and dismissing the scene.
class OrbitScene: SKScene {
    // Sun object representing the center of the orbit.
    var sun: SKSpriteNode!
    
    // Keeps track of when a touch begins to calculate duration.
    var touchStartTime: TimeInterval?
    
    // Label that functions as a dismiss button to exit the scene.
    var dismissButton: SKLabelNode!


    override func didMove(to view: SKView) {
        backgroundColor = .black
        setupSun()
        setupLabel()
        setupDismissButton()
    }
    //Create the sun object
    func setupSun() {
        sun = SKSpriteNode(imageNamed: "sun")
        sun.position = CGPoint(x: frame.midX, y: frame.midY)
        sun.size = CGSize(width: 100, height: 100)
        addChild(sun)
    }

    // Create an instructional label for adding planets.
    func setupLabel() {
        let label = SKLabelNode(text: "Tap to add a planet into orbit")
        label.fontColor = .white
        label.position = CGPoint(x: frame.midX, y: frame.maxY - 50)
        addChild(label)
    }
    
    // Create the dismiss button that allows users to exit the scene.
    func setupDismissButton() {
        dismissButton = SKLabelNode(text: "Dismiss")
        dismissButton.fontColor = .white
        dismissButton.position = CGPoint(x: frame.midX, y: frame.minY + 50)
        addChild(dismissButton)
    }

    
    // Capture the time when a touch begins.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            touchStartTime = touch.timestamp
        }
    }
    
    // When the touch ends, determine the duration and add an orbiting planet based on the touch duration.
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //When the touch ends, get the touch duration
        guard let touch = touches.first, let startTime = touchStartTime else { return }
        let touchDuration = touch.timestamp - startTime
        let location = touch.location(in: self)
        
        // Check if the dismiss button is tapped to close the scene.
        if dismissButton.contains(location) {
            view?.window?.rootViewController?.dismiss(animated: true, completion: nil)
        }
        
        //Set radius proportional to the touch duration with a minimum of 10
        let radius = max(touchDuration * 50, 10)
        
        // Add a new orbiting planet at the touch location.
        addOrbitingPlanet(at: location, radius: radius)
    }
    
    // Adds a new planet that orbits the sun at a specified location and radius.
    func addOrbitingPlanet(at position: CGPoint, radius: CGFloat) {
        
        //Create the planet with the radius
        let planet = SKShapeNode(circleOfRadius: radius)
        
        // Set the planet's fill color to a randomly generated color.
        planet.fillColor = generateRandomColor()
        
        //Make the stroke around the planet clear
        planet.strokeColor = .clear
        
        // Calculate the distance between the planet's position and the sun's position.
        let dx = position.x - sun.position.x
        
        // Calculate the orbit radius based on the distance (dx, dy).
        let dy = position.y - sun.position.y
        
        //Create an orbit radius based on the dx, dy
        let orbitRadius = sqrt(dx*dx + dy*dy)
        
        
        // Create a circular path around the sun using the calculated radius.
        let orbitPath = UIBezierPath(arcCenter: sun.position, radius: orbitRadius, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        
        // Create an action that makes the planet follow the orbit path.
        let orbitAction = SKAction.follow(orbitPath.cgPath, asOffset: false, orientToPath: false, duration: 5)
        
        // Make the orbit action repeat indefinitely to keep the planet in orbit.
        let repeatOrbitAction = SKAction.repeatForever(orbitAction)
        
        // Set the planet's initial position.
        planet.position = position
        
        // Add the planet to the scene.
        addChild(planet)
        
        // Start the orbit action for the planet.
        planet.run(repeatOrbitAction)
    }
    
    // Generates a random color for a planet.
    func generateRandomColor() -> UIColor {
        let red = CGFloat(arc4random_uniform(256)) / 255.0
        let green = CGFloat(arc4random_uniform(256)) / 255.0
        let blue = CGFloat(arc4random_uniform(256)) / 255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
