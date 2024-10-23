//
//  PageViewController.swift
//  MaxCosmicJourney
//
//  Created by Joshua Cox on 3/23/24.
//

import UIKit
import AVFAudio

// Protocol for communicating page updates and presenting options.
protocol PageViewControllerDelegate {
    func didUpdatePageIndex(currentIndex: Int)
    func presentOptions()
}

// Manages the presentation of pages and text-to-speech functionality.
class PageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource, PageControllerDelegate, AVSpeechSynthesizerDelegate {
    var pages: [UIViewController] = []
    
    // Shared AVSpeechSynthesizer for text-to-speech functionality.
    let synthesizer = Narrator.shared
    
    // Custom delegate for handling page index updates and options.
    var customDelegate: PageViewControllerDelegate?
    
    // Initializes the PageViewController with a page curl transition style.
    init() {
        super.init(transitionStyle: .pageCurl, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(transitionStyle: .pageCurl, navigationOrientation: .horizontal, options: nil)
    }
    
    // Called after the view is loaded into memory.
    // Sets up the page data source, delegate, and initial pages.
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        setupPages()
        setViewControllers([pages[0]], direction: .forward, animated: false)
        synthesizer.delegate = self

    }
    
    // Creates the individual pages and sets up their content.
    func setupPages() {
        //Creating pages
        let page1 = PageController()
        let page2 = PageController()
        let page3 = PageController()
        let page4 = PageController()
        let page5 = PageController()
        let page6 = PageController()
        let page7 = PageController()
        
        //Setting page7 last page to be true
        page7.isLastPage = true
        
        //Creating page text
        page1.page_text = "Max is a curious kid. One day, he finds an old telescope in his attic. He's so excited to use it and see what's out there in space!"
        
        page2.page_text = "Max looks through the telescope and sees Mercury, the closest planet to the Sun. It looks like a tiny, hot rock with bumpy, glowing spots. Mercury is the fastest planet, zooming around the Sun faster than any other!"
        
        page3.page_text = "Next, Max sees Venus. It's covered in thick, shiny clouds and looks like a big, bright ball in the sky! Venus is the hottest planet, even hotter than Mercury, because its thick clouds trap heat from the Sun."
    
        page4.page_text = "Max spots Mars, the Red Planet. It has tall mountains and deep canyons. It's like a giant sandbox with hills! Mars is known for its red color and the possibility of having water, which makes scientists curious about it."
        
        page5.page_text = "Looking through the telescope, Max sees Jupiter. It's a huge ball with colorful stripes, like a giant, colorful beach ball floating in space! Jupiter is the biggest planet in our solar system and has a big storm called the Great Red Spot."
        
        page6.page_text = "Finally, Max finds Saturn. It has rings made of ice and dust, like a big ball with a beautiful ring around it. Saturn's rings are its most famous feature, and it's also known for having lots of moons."
        
        page7.page_text = "Max steps back and looks out his attic window. He sees Earth! There are houses, trees, and lots of people and animals. Earth is special because it's where Max lives!"
        
        //Setting up background images
        page1.backgroundImageName = "page1"
        page2.backgroundImageName = "page2_mercuryb"
        page3.backgroundImageName = "page3_venus"
        page4.backgroundImageName = "page4_marsb"
        page5.backgroundImageName = "page5_jupiter"
        page6.backgroundImageName = "page6_saturnb"
        page7.backgroundImageName = "page7"
        
        //Setting up images when tapping is available
        page2.tapImage = UIImage(named: "page2_mecury_zoomed")
        page4.tapImage = UIImage(named: "page4_mars_zoomed")

        //Setting up spaceship image for page 3
        page3.spaceshipImageView = UIImageView(image: UIImage(named: "spaceship2"))
        
        // Assigning delegate for all pages
        let allPages = [page1, page2, page3, page4, page5, page6, page7]
        allPages.forEach { page in
            page.delegate = self
        }
        
        // Appending the pages
        pages.append(contentsOf: allPages)
    }
    
    // Restarts the book by navigating back to the first page.
    func restartBook() {
        print("PageViewController restart book called")
        if let firstPage = pages.first {
            setViewControllers([firstPage], direction: .forward, animated: true, completion: nil)
            customDelegate?.didUpdatePageIndex(currentIndex: 0)
        }
    }

    
}

extension PageViewController {
    // Updates the current page index when a page transition completes.
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed, let viewController = pageViewController.viewControllers?.first, let index = pages.firstIndex(of: viewController) {
            self.customDelegate?.didUpdatePageIndex(currentIndex: index)
        }
        
    }
    // Returns the previous page when swiping left.
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = pages.firstIndex(of: viewController){
            if index > 0 {
                return pages[index - 1]
            } else {
                return nil
            }
        }
        return nil
    }
    
    // Returns the next page when swiping right.
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = pages.firstIndex(of: viewController){
            if index < pages.count - 1 {
                return pages[index + 1]
            } else {
                return nil
            }
        }
        return nil
    }
    
    // Sets up and starts audio playback for the current page's text.
    func setupAudio(page_text: String){
        synthesizer.stopSpeaking(at: .word)
        let voice = AVSpeechSynthesisVoice(language: "en_AU")
        let utterance = AVSpeechUtterance(string: page_text)
        utterance.voice = voice
        synthesizer.speak(utterance)
    }
    
    // Called when the speech synthesizer is about to speak a specific range of text.
    // Updates the reading progress by highlighting the spoken text.
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        if let currentController = self.viewControllers?.first as? PageController {
            
            // Updates the textView of the page to highlight the currently spoken text.
            updateReadingProgress(pageController: currentController, range: characterRange)
            print("\(currentController.isLastPage)")
            print("character range upper bound: \(characterRange.upperBound)")
            print("current page text count: \(currentController.page_text.count - 1)")
        }
    }
        // Updates the textView of the page to highlight the currently spoken text.
        func updateReadingProgress(pageController: PageController, range: NSRange) {
            guard let text = pageController.textView.text else { return }

            let normalFont = UIFont.systemFont(ofSize: 28)
            let boldFont = UIFont.boldSystemFont(ofSize: 28)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center

            // Apply font and paragraph style attributes to the attributed string
            let attributedString = NSMutableAttributedString(string: text,
                                                             attributes: [
                                                                 .font: normalFont,
                                                                 .paragraphStyle: paragraphStyle
                                                             ])

            // Apply bold font
            attributedString.addAttributes([.font: boldFont], range: range)

            // Set the attributed text
            DispatchQueue.main.async {
                pageController.textView.attributedText = attributedString
            }
        }
        
        // Navigate to the next page in the book.
        func goToNextPage() {
            if let currentViewController = viewControllers?.first,
               let currentIndex = pages.firstIndex(of: currentViewController),
               currentIndex < pages.count - 1 {
                synthesizer.stopSpeaking(at: .immediate)  // Stop any ongoing speech
                let nextViewController = pages[currentIndex + 1]
                setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
                self.customDelegate?.didUpdatePageIndex(currentIndex: currentIndex + 1)
            }
        }
    
        // Navigate to the previous page in the book.
        func goToPreviousPage() {
            if let currentViewController = viewControllers?.first,
               let currentIndex = pages.firstIndex(of: currentViewController),
               currentIndex > 0 {
                synthesizer.stopSpeaking(at: .immediate)  // Stop any ongoing speech
                let previousViewController = pages[currentIndex - 1]
                setViewControllers([previousViewController], direction: .reverse, animated: true, completion: nil)
                self.customDelegate?.didUpdatePageIndex(currentIndex: currentIndex - 1)
            }
        }
    
    func presentOptions() {
        self.customDelegate?.presentOptions()
    }

}
