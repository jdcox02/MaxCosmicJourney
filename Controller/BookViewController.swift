//
//  BookViewController.swift
//  MaxCosmicJourney
//
//  Created by Joshua Cox on 4/5/24.
//

import UIKit
import SwiftUI

// View controller for managing a book-like reading experience with page navigation and optional text-to-speech.
class BookViewController: UIViewController, UIPageViewControllerDelegate {
    
    // Container view for holding the page view controller.
    @IBOutlet weak var containerView: UIView!
    var pageViewController: PageViewController?
    
    // Buttons for navigating pages and interacting with the book.
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var homeButton: UIButton!
    
    // SwiftUI View displayed when the user taps the exploreMoreButton at the end of the book.
    var swiftView = EndOfBookView()
    var hostingController: UIHostingController<EndOfBookView>!
    
    // Hide the navigation bar when the view appears.
    // Also checks the user's "Read To Me" preference and hides the play button if not needed.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //hide the navigation bar
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
        //If readToMePreference is tap to play, show play button.
        let readToMePreference = UserDefaults.standard.integer(forKey: "ReadToMePreference")
        playButton.isHidden = readToMePreference == 0 ? true: false
        
    }
    // Unhide the navigation bar when the view is dismissed.
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //If and when the BookViewController is set to be dismissed, we can unhide the navigation bar
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContainerView() // Configure the container view for the PageViewController.
        setupPageVC() // Initialize the PageViewController.
        setupHomeButton() // Set up the home button with constraints.

        //Set the delegate for the pageViewController.
        self.pageViewController?.customDelegate = self
        
        //Set the current index equal to 0 --- this is used to determine whether prev and next buttons are shown
        self.didUpdatePageIndex(currentIndex: 0)
        
        //Setting delegate before adding to hostController
        swiftView.delegate = self
        
        //Set the root view for the hosting controller
        hostingController = UIHostingController(rootView: swiftView)
                
    }
    // Configure the home button and position it in the view.
    func setupHomeButton(){
        homeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([homeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),homeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)])
        view.bringSubviewToFront(homeButton)
    }
    
    // Set up the container view that holds the page view controller.
    func setupContainerView(){
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.topAnchor), // 20 points from the top
            containerView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -20), // 20 points from the bottom
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor), // 20 points from the leading edge
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor), // 20 points from the trailing edge
        ])
    }
    
    // Initialize the PageViewController and add it to the container view.
    func setupPageVC(){
        //Create PageViewController
        pageViewController = PageViewController()
        
        //Add pageViewController's view to containerview subview
        containerView.addSubview(pageViewController!.view)
        
        // Set constraints for pageVC.view
        pageViewController!.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageViewController!.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            pageViewController!.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            pageViewController!.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            pageViewController!.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }
    
    // Action for when the "Previous" button is tapped. Navigates to the previous page.
    @IBAction func prevButtonTapped(_ sender: Any) {
        pageViewController?.goToPreviousPage()
    }
    
    // Action for when the "Next" button is tapped. Navigates to the next page.
    @IBAction func nextButtonTapped(_ sender: Any) {
        
        pageViewController?.goToNextPage()
    }
    
    // Action for when the "Play" button is tapped. Reads aloud the current page's text using the synthesizer.
    @IBAction func playButtonTapped(_ sender: Any) {
        if let currentPage = pageViewController?.viewControllers?.first as? PageController {
            let textToRead = currentPage.page_text
            currentPage.delegate?.setupAudio(page_text: textToRead)
        }
    }
    
    // Action for when the "Home" button is tapped. Stops any ongoing speech and navigates back to the home page.
    @IBAction func homeButtonTapped(_ sender: Any) {
        if let synthesizer = self.pageViewController?.synthesizer, synthesizer.isSpeaking {
            // Stop the synthesizer
            synthesizer.stopSpeaking(at: .immediate)

            }
        // Navigate to the home page
        navigationController?.popToRootViewController(animated: true)
        }
    

}


extension BookViewController: PageViewControllerDelegate {
    //Setting up function to use current index to determine whether prev and next buttons should be shown
    func didUpdatePageIndex(currentIndex: Int) {
        prevButton.isHidden = currentIndex == 0 ? true : false
        nextButton.isHidden = currentIndex == self.pageViewController!.pages.count - 1 ? true: false
    }
    
    //Setting up function to show hosting controller
    func presentOptions() {
        print("presentOptions was called")
        if let synthesizer = self.pageViewController?.synthesizer, synthesizer.isSpeaking {
            // Stop the synthesizer
            synthesizer.stopSpeaking(at: .immediate)

            }
        present(hostingController, animated: true, completion: nil)
    }
}

extension BookViewController: EndOfBookViewDelegate {
    //Function to allow SwiftUI View to restart book
    func restartBook() {
        // Allows the SwiftUI view to restart the book when the user selects that option.
        print("BookViewController restartbook called")
        hostingController.dismiss(animated: true) {
            // Reset the PageViewController to the first page.
            self.pageViewController!.setViewControllers([self.pageViewController!.pages[0]], direction: .reverse, animated: true, completion: nil)
            self.didUpdatePageIndex(currentIndex: 0)
        }
    }
}

