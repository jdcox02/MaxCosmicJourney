//
//  PageController.swift
//  MaxCosmicJourney
//
//  Created by Joshua Cox on 3/24/24.
//

import UIKit
import AVFAudio
import SwiftUI


// Protocol for communication between PageController and its delegate.
// Includes methods for setting up audio, updating reading progress, and presenting options.
protocol PageControllerDelegate {
    func setupAudio(page_text: String)
    func updateReadingProgress(pageController: PageController, range: NSRange)
    func presentOptions()
}

// Manages the presentation and interactions for a single page of the book.
class PageController: UIViewController, UIPageViewControllerDelegate {
    
    // Delegate for handling actions outside of this controller.
    var delegate: PageControllerDelegate?
    
    //Set up background and textview
    var backgroundImageView = UIImageView()
    var backgroundImageName: String = ""
    var textView = UITextView()
    var page_text: String = ""
    
    //Set up tappable images
    var tapImage: UIImage?
    var tapLabel = UILabel()
    var isImageZoomed = false
    
    //Set up buttons and labels
    var exploreMoreButton = UIButton()
    var spaceshipImageView: UIImageView?
    
    //Set up objects needed for animation
    var animator: UIDynamicAnimator?
    var textFadeInAnimator: UIViewPropertyAnimator?
    
    //Set up attribute to determine if on last page
    var isLastPage = false
    
    // Prepare the view for display and set up the text view and animations.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTextView()
        prepareTextFadeInAnimation()
        if spaceshipImageView != nil {
            setupSpaceship()
            animateSpaceship()
        }
        
    }
    
    // Called after the view has been loaded. Sets up the text view, background, and buttons.
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextView()
        setupBackgroundImage()
        setupExploreMoreButton()
        setupTapLabel()
    }
    // Start the text fade-in animation after the view appears.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textFadeInAnimator?.startAnimation()
    }
    
    // Configures the text view with the page's text content and layout.
    private func setupTextView() {
        textView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textView)
        
        // Constraints for textView
        NSLayoutConstraint.activate([
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            textView.heightAnchor.constraint(greaterThanOrEqualToConstant: 120)
        ])
                
        textView.text = page_text
        textView.font = UIFont.systemFont(ofSize: 28)
        textView.isEditable = false
        textView.textAlignment = .center
        textView.backgroundColor = .clear  // Start with clear background

    }
    
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { _ in
            self.setupBackgroundImage()
        })
    }
    // Sets up the background image for the page.
    private func setupBackgroundImage() {
        backgroundImageView = UIImageView()
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.image = UIImage(named: backgroundImageName)
        view.insertSubview(backgroundImageView, belowSubview: textView)  // Ensure the background is behind the textView.
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),  // Make the bottom of the image align with the top of the textView.
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    // Sets up the spaceship image and positions it for animation.
    func setupSpaceship(){
        view.addSubview(spaceshipImageView!)
        spaceshipImageView!.contentMode = .scaleToFill
        spaceshipImageView!.translatesAutoresizingMaskIntoConstraints = false


        NSLayoutConstraint.activate([
            spaceshipImageView!.widthAnchor.constraint(equalToConstant: 100),
            spaceshipImageView!.heightAnchor.constraint(equalToConstant: 100),
            spaceshipImageView!.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            spaceshipImageView!.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -100)])
        
        view.layoutIfNeeded()

    }
    // Animates the spaceship using a gravity behavior for a floating effect.
    func animateSpaceship(){
        self.animator = UIDynamicAnimator(referenceView: self.view)
        
        let gravity = UIGravityBehavior(items: [spaceshipImageView!])
        
        gravity.gravityDirection = CGVector(dx: 0.2, dy: -0.05)
        animator?.addBehavior(gravity)

    }
    
    // Sets up the "Explore More" button, which is visible only on the last page.
    func setupExploreMoreButton() {
        exploreMoreButton.setTitle("Explore More", for: .normal)
        exploreMoreButton.addTarget(self, action: #selector(exploreMoreButtonTapped), for: .touchUpInside)
        exploreMoreButton.isHidden = isLastPage == true ? false : true
        view.addSubview(exploreMoreButton)
        
        exploreMoreButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([exploreMoreButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                                     exploreMoreButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)])
    }
    
    // Prepares the text fade-in animation for a smooth appearance.
    private func prepareTextFadeInAnimation() {
        textFadeInAnimator = UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut) {
            self.textView.backgroundColor = .white  // End with the textView fully opaque
        }
        textFadeInAnimator?.addCompletion { position in
            if position == .end {
                let defaults = UserDefaults.standard
                let readToMePreference = defaults.integer(forKey: "ReadToMePreference")
                
                if readToMePreference == 0 {
                    self.delegate?.setupAudio(page_text: self.page_text)
                }
            }
        }
    }
    
    // Sets up a label for tappable images, allowing users to zoom in or out.
    private func setupTapLabel() {
        tapLabel.text = "Tap to get a closer look!"
        tapLabel.backgroundColor = .white
        tapLabel.textColor = .black
        tapLabel.translatesAutoresizingMaskIntoConstraints = false
        tapLabel.isHidden = true
        view.addSubview(tapLabel)
        
        NSLayoutConstraint.activate([
            tapLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            tapLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        if tapImage != nil {
            view.bringSubviewToFront(tapLabel)
            tapLabel.isHidden = !tapLabel.isHidden
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
            self.view.addGestureRecognizer(tapGesture)
            
        }
    }

    // Action for when the "Explore More" button is tapped, triggering the delegate method.
    @objc func exploreMoreButtonTapped() {
        self.delegate?.presentOptions()
    }
    
    // Handles tap gestures to toggle between zoomed-in and zoomed-out states of an image.
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        if isImageZoomed {
            // If the image is zoomed in, zoom out and update the label
            self.backgroundImageView.image = UIImage(named: backgroundImageName)  // Replace with your default image
            tapLabel.text = "Tap to get a closer look!"
            tapLabel.isHidden = false
        } else {
            // If the image is not zoomed in, zoom in and update the label
            self.backgroundImageView.image = tapImage
            tapLabel.text = "Tap to zoom out"  // Update the label text
            tapLabel.isHidden = false
        }
        isImageZoomed.toggle()  // Toggle the zoom state
    }

        
    
}
