# Max's Cosmic Journey

**Max's Cosmic Journey** is an interactive, story-driven iOS app that takes users on an imaginative journey through space. Follow Max as he explores the solar system, learning about planets through narrated pages and engaging visuals.

## Overview

MaxCosmicJourney is designed for kids and families, offering a mix of educational content and playful interactions. Users can navigate through pages of Max's space adventure, tap on planets for a closer look, and even play mini-games. The app also includes a parental gate to ensure secure access to certain content.

## Features

- **Narrated Story**: Each page of Max's journey is narrated using AVFoundation's text-to-speech capabilities, making the story accessible to younger audiences.
- **Interactive Pages**: Tap on planets and explore closer details through zoomable images.
- **Mini Games**: Play a game where you can add planets into orbit around the sun, using `SpriteKit` for a fun, interactive experience.
- **Parental Gate**: A simple drawing challenge is required to access parental content like the "About the Author" page.
- **Customizable Experience**: Users can adjust narration preferences to control when the app reads text aloud.

## Knowledge and Skills Demonstrated

- **Framework Integration**: Combines **UIKit** and **SwiftUI** to create a seamless user interface, showcasing versatility in using different UI frameworks.
- **Objective-C Integration**: Includes **Objective-C** for managing user settings, demonstrating the ability to work with both legacy and modern codebases.
- **Audio and Accessibility**: Uses **AVFoundation** for text-to-speech, enhancing accessibility and user engagement.
- **Interactive Elements**: Implements **SpriteKit** for a physics-based mini-game, adding an engaging, hands-on component to the learning experience.
- **Parental Controls**: Custom drawing-based parental gate ensures secure access to specific content, combining user interaction with security.

## Getting Started

### Prerequisites

- iOS 15.0+
- Xcode 13.0+
- Swift 5.0+

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/yourusername/MaxCosmicJourney.git
   cd MaxCosmicJourney
   ```
   
2. Clone the repository:
   ```bash
   open MaxCosmicJourney.xcodeproj
    ```
### Usage

1. **Explore the Story**: Swipe through pages to follow Max’s adventure through space. The narration will play automatically if the "Read To Me" feature is enabled.
2. **Zoom into Planets**: Tap on planets like Mercury and Mars to zoom in and explore them in detail.
3. **Play a Mini Game**: Tap "Play a Game" at the end of the story to launch a fun orbit simulation using `SpriteKit`.
4. **Access Parental Content**: Draw a circle to unlock access to the "About the Author" section through the parental gate.

### Technologies

- **Swift** & **Objective-C**: Demonstrates proficiency in both modern and legacy iOS languages.
- **UIKit** & **SwiftUI**: Combines traditional UIKit elements with modern SwiftUI for a flexible user interface.
- **SpriteKit**: Used for creating interactive, physics-based games, adding a fun, educational aspect to the app.
- **AVFoundation**: Powers the text-to-speech capabilities for narrating the story, making the app accessible and engaging.
- **UserDefaults**: Manages user preferences, such as the "Read To Me" mode and app launch counts, ensuring a personalized user experience.

