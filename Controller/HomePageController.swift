//
//  HomePageController.swift
//  MaxCosmicJourney
//
//  Created by Joshua Cox on 3/23/24.
//

import UIKit

// The main view controller for the home page of the Max Cosmic Journey app.
// Displays the book's title and allows navigation to the author's details.
class HomePageController: UIViewController {
    // Label to display the title of the book.
    @IBOutlet weak var bookTitle: UILabel!
    // Button for navigating to the "About the Author" section.
    @IBOutlet weak var aboutAuthorButton: UIButton!
    
    // Sets up the book title label, background, and button actions.
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBookTitle()
        setupBackground()
        aboutAuthorButton.addTarget(self, action: #selector(proceedToAboutAuthor), for: .touchUpInside)
    }
    
    // Configures the book title label's appearance, layout, and font.
    func setupBookTitle() {
        bookTitle.translatesAutoresizingMaskIntoConstraints = false
        bookTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bookTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.size.height / 3).isActive = true
        bookTitle.widthAnchor.constraint(equalToConstant: 400).isActive = true
        bookTitle.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            print("Family: \(family) Font names: \(names)")
        }

        if let customFont = UIFont(name: "spacetext", size: 48) {
            bookTitle.font = customFont
        } else {
            print("Failed to load 'spacetext' font. Using system font.")
            bookTitle.font = UIFont.systemFont(ofSize: 48)
        }
        bookTitle.textColor = UIColor.white
        bookTitle.textAlignment = .center
        bookTitle.backgroundColor = UIColor.clear
        bookTitle.layer.shadowColor = UIColor.darkGray.cgColor
        bookTitle.layer.shadowOffset = CGSize(width: 2, height: 2)
        bookTitle.layer.shadowOpacity = 1
        bookTitle.layer.shadowRadius = 2
        
        bookTitle.adjustsFontSizeToFitWidth = true
        bookTitle.minimumScaleFactor = 0.5
    }
    
    // Sets the background image for the view.
    func setupBackground() {
        // Setting the background of the view to a space image
        if let backgroundImage = UIImage(named: "spaceBackground") {
            view.backgroundColor = UIColor(patternImage: backgroundImage)
        }
        
    }
    
    // Action triggered when the "About the Author" button is tapped.
    // Presents the parental gate before allowing access to the author's details.
    @IBAction func aboutAuthorTapped(_ sender: Any) {
        let parentalGateVC = ParentalGateViewController()
                parentalGateVC.delegate = self // Set the delegate to self
        parentalGateVC.modalPresentationStyle = .fullScreen // Or any other suitable presentation style
                present(parentalGateVC, animated: true, completion: nil)
    }
    
    // Action to proceed directly to the "About the Author" section.
    @objc func proceedToAboutAuthor() {
        // Create an instance of AboutAuthorViewController
        let aboutAuthorVC = AboutAuthorViewController(nibName: "AboutAuthorViewController", bundle: nil)
        
        // Present AboutAuthorViewController modally
        aboutAuthorVC.modalPresentationStyle = .pageSheet
        present(aboutAuthorVC, animated: true, completion: nil)
    }
    
        
}

extension HomePageController: ParentalGateViewControllerDelegate {
    func didCompletCircle() {
        let aboutAuthorVC = AboutAuthorViewController()
        aboutAuthorVC.modalPresentationStyle = .pageSheet
        present(aboutAuthorVC, animated: true, completion: nil)
    }
    
}


