//
//  ParentalGateViewController.swift
//  MaxCosmicJourney
//
//  Created by Joshua Cox on 3/30/24.
//

import UIKit

// Protocol for handling the completion of the circle-drawing task.
protocol ParentalGateViewControllerDelegate: AnyObject {
    func didCompletCircle()
}

// View controller that presents a drawing challenge to the user as a parental gate.
// The user must draw a circle around the moon to proceed.
class ParentalGateViewController: UIViewController {
    // Label providing instructions for the user.
    let instructionLabel = UILabel()
    
    // Image view for displaying the moon image.
    var tempImageView = UIImageView()
    
    // Image view for capturing the user's drawing.
    var drawingImageView = UIImageView()
    
    // Tracks the last touch point and whether the user is actively drawing.
    var lastPoint = CGPoint.zero
    var drawing = false
    
    // Stores all points from the user's drawing.
    var points: [CGPoint] = []
    
    // Delegate to inform when the circle has been successfully completed.
    weak var delegate: ParentalGateViewControllerDelegate?
    

    // Called after the view has loaded, setting up the background and UI elements.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black  // Or any color that suits your design
        setupImageViews()
        setupInstructionLabel()
    }
    
    // Sets up the image views for the moon and drawing overlay.
    func setupImageViews() {
        // Configure the moon image view to fill the screen.
        tempImageView.frame = view.bounds
        tempImageView.contentMode = .scaleAspectFit
        tempImageView.image = UIImage(named: "moon")
        view.addSubview(tempImageView)

        // Setup the transparent drawing overlay
        drawingImageView.frame = tempImageView.frame
        drawingImageView.contentMode = .scaleAspectFit
        drawingImageView.backgroundColor = .clear
        view.addSubview(drawingImageView)
    }
    
    // Captures the start of a touch and initializes drawing.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            lastPoint = touch.location(in: drawingImageView)
            drawing = false
            points = [lastPoint]
        }
    }
    
    // Tracks the user's finger movement to draw lines and store points.
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            drawing = true
            let currentPoint = touch.location(in: drawingImageView)
            drawlineFrom(fromPoint: lastPoint, toPoint: currentPoint)
            lastPoint = currentPoint
            points.append(currentPoint)
        }
    }
    
    // Handles the end of a touch, checks if the drawing resembles a circle.
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            if !drawing {
                drawlineFrom(fromPoint: lastPoint, toPoint: lastPoint)
            }
        // Check if the user's drawing is close to a circle shape.
            if isCircle() {
                dismiss(animated: true) { [weak self] in
                    self?.delegate?.didCompletCircle()
                }
            } else {
                // If the drawing is not a circle, clear it and prompt the user to try again.
                clearDrawing()
                showTryAgainPrompt()
            }
    }
    
    // Draws a line between two points on the drawing image view.
    func drawlineFrom(fromPoint: CGPoint, toPoint: CGPoint) {
        UIGraphicsBeginImageContext(drawingImageView.frame.size)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        drawingImageView.image?.draw(in: CGRect(x: 0, y: 0, width: drawingImageView.frame.width, height: drawingImageView.frame.height))
        
        // Draw the line segment.
        context.move(to: fromPoint)
        context.addLine(to: toPoint)
        context.setLineCap(.round)
        context.setLineWidth(20)
        context.setStrokeColor(UIColor.green.cgColor)
        context.strokePath()

        drawingImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    // Determines if the user's drawing approximates a circle.
    func isCircle() -> Bool {
        guard points.count > 2 else { return false }

        // Step 1: Find the furthest points (this is a naive implementation; optimizations could be made)
        var maxDistance = CGFloat(0)
        var furthestPoints = (start: CGPoint.zero, end: CGPoint.zero)
        for i in 0..<points.count {
            for j in i+1..<points.count {
                let distance = hypot(points[i].x - points[j].x, points[i].y - points[j].y)
                if distance > maxDistance {
                    maxDistance = distance
                    furthestPoints = (points[i], points[j])
                }
            }
        }

        // Step 2: Calculate the midpoint between the furthest points.
        let centerX = (furthestPoints.start.x + furthestPoints.end.x) / 2
        let centerY = (furthestPoints.start.y + furthestPoints.end.y) / 2
        let centerPoint = CGPoint(x: centerX, y: centerY)

        // Step 3: Check if all points are roughly equidistant from the midpoint
        let radius = maxDistance / 2
        let tolerance: CGFloat = 60.0  // Adjust tolerance based on your needs
        for point in points {
            let distance = hypot(point.x - centerPoint.x, point.y - centerPoint.y)
            if abs(distance - radius) > tolerance {
                return false
            }
        }

        return true
    }
    
    // Clears the current drawing.
    func clearDrawing() {
        drawingImageView.image = nil
    }
    
    // Displays an alert prompting the user to try drawing again.
    func showTryAgainPrompt() {
        let alert = UIAlertController(title: "Try Again", message: "Please draw a circle to proceed.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // Sets up the instruction label with appropriate text and constraints.
    func setupInstructionLabel() {
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        instructionLabel.text = "To proceed, please trace the outline of the moon with your finger."
        instructionLabel.textColor = .white
        instructionLabel.textAlignment = .center
        instructionLabel.numberOfLines = 0  // Allow label to wrap text
        view.addSubview(instructionLabel)

        // Constraints to position the label at the top
        NSLayoutConstraint.activate([
            instructionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            instructionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            instructionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}
