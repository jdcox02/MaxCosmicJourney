//
//  AboutAuthorViewController.swift
//  MaxCosmicJourney
//
//  Created by Joshua Cox on 3/25/24.
//

import UIKit

// View controller for displaying information about the author of the book.
class AboutAuthorViewController: UIViewController {
    // Label displaying the title or name of the author.
    @IBOutlet weak var aboutAuthorLabel: UILabel!
    // Image view for showing the author's headshot.
    @IBOutlet weak var headshotImageView: UIImageView!
    // Text view for displaying a description or biography of the author.
    @IBOutlet weak var aboutAuthorDescription: UITextView!
    
    // Called when the view is awakened from nib or storyboard.
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // Called after the view has been loaded into memory.
    // Sets up the layout of the UI elements.
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()// Arrange the label, headshot, and description text view.
    }
    
    // Configures the layout and appearance of the author information elements.
    private func setupLayout() {
        // Center the aboutAuthorLabel vertically
        aboutAuthorLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutAuthorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        aboutAuthorLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true // Adjust top spacing as needed
        
        // Center the headshotImageView vertically
        headshotImageView.layer.cornerRadius = headshotImageView.frame.width / 2
        headshotImageView.translatesAutoresizingMaskIntoConstraints = false
        headshotImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        headshotImageView.topAnchor.constraint(equalTo: aboutAuthorLabel.bottomAnchor, constant: 20).isActive = true // Adjust top spacing as needed
                
        // Set up the aboutAuthorDescription text view
        aboutAuthorDescription.textColor = .black
        aboutAuthorDescription.backgroundColor = .clear
        aboutAuthorDescription.font = UIFont.systemFont(ofSize: 28)
        aboutAuthorDescription.textAlignment = .center
        aboutAuthorDescription.text = "Josh Cox is a graduate student in the Master's Program in Computer Science at the University of Chicago"
        
        aboutAuthorDescription.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        aboutAuthorDescription.translatesAutoresizingMaskIntoConstraints = false
        aboutAuthorDescription.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        aboutAuthorDescription.topAnchor.constraint(equalTo: headshotImageView.bottomAnchor, constant: 20).isActive = true
        aboutAuthorDescription.leadingAnchor.constraint(equalTo: headshotImageView.leadingAnchor, constant: -20).isActive = true
        aboutAuthorDescription.trailingAnchor.constraint(equalTo: headshotImageView.trailingAnchor, constant: 20).isActive = true
        aboutAuthorDescription.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
    }
    
    
}
