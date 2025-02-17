# Max's Cosmic Journey

**Max's Cosmic Journey** is an interactive, story-driven iOS app that takes users on an imaginative journey through space. Follow Max as he explores the solar system, learning about planets through narrated pages and engaging visuals.

## Overview

MaxCosmicJourney is designed for kids and families, offering a mix of educational content and playful interactions. Users can navigate through pages of Max's space adventure, tap on planets for a closer look, and even play mini-games. The app also includes a parental gate to ensure secure access to certain content.

## Features

- **Narrated Story**: Each page of Max's journey is narrated using AVFoundation's text-to-speech capabilities, making the story accessible to younger audiences.
- **Interactive Pages**: Tap on planets and explore closer details through zoomable images.
- **Mini Game**: Play a game where you can add planets into orbit around the sun, using `SpriteKit` for a fun, interactive experience.
- **Parental Gate**: A simple drawing challenge is required to access parental content like the "About the Author" page.
- **Customizable Experience**: Users can adjust narration preferences to control when the app reads text aloud.

### **📖 Story Screens**  

#### **Welcome Screen**  
![Welcome Screen](https://raw.githubusercontent.com/jdcox02/MaxCosmicJourney/main/images/welcome.png)  

#### **Customize Narration Settings**  
![Settings Screen](https://raw.githubusercontent.com/jdcox02/MaxCosmicJourney/main/images/settings.png) 

#### **Max Discovers a Telescope**  
![Max in the Attic](https://raw.githubusercontent.com/jdcox02/MaxCosmicJourney/main/images/attic1.png)  

#### **Exploring Mercury**  
Users can tap to zoom in and explore details of Mercury’s cratered surface.
  
![Mercury](https://raw.githubusercontent.com/jdcox02/MaxCosmicJourney/main/images/mercury.png)  

#### **Exploring Mars**  
![Mars](https://raw.githubusercontent.com/jdcox02/MaxCosmicJourney/main/images/mars.png)  

#### **Exploring Venus**
This screen features an animated spaceship moving across the screen as Max learns about Venus.
    
![Venus](https://raw.githubusercontent.com/jdcox02/MaxCosmicJourney/main/images/venus.png)

#### **🛡️ Parental Controls**  
To access the **About the Author** section, users must complete a simple **drawing challenge** to verify adult access.  

![Parental Gate](https://raw.githubusercontent.com/jdcox02/MaxCosmicJourney/main/images/parentalgate.png)  

#### **About the Author Page**  
![About the Author](https://raw.githubusercontent.com/jdcox02/MaxCosmicJourney/main/images/aboutauthor.png)  

#### **🏁 End of the Journey**  
At the end of the story, users can **restart the book or play a game** to extend the fun!  

![End Screen](https://raw.githubusercontent.com/jdcox02/MaxCosmicJourney/main/images/end.png)  

#### **🕹️ Mini-Game: Orbital Simulator**  
The app includes a **physics-based game** where players can **add planets into orbit** around the sun. This feature, built using `SpriteKit`, enhances the interactive experience.  

![SpriteKit Mini-Game](https://raw.githubusercontent.com/jdcox02/MaxCosmicJourney/main/images/spritekit_minigame.png)  

---


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
   git clone https://github.com/jdcox02/MaxCosmicJourney
   ```
   
2. Open the project in Xcode:
   ```bash
   cd MaxCosmicJourney
   open MaxCosmicJourney.xcodeproj
    ```
### Usage

1. **Explore the Story**: Swipe through pages to follow Max’s adventure through space. The narration will play automatically if the "Read To Me" feature is enabled.
2. **Zoom into Planets**: Tap on planets like Mercury and Mars to zoom in and explore them in detail.
3. **Play a Mini Game**: Tap "Play a Game" at the end of the story to launch a fun orbit simulation using `SpriteKit`.
4. **Access Parental Content**: Draw a circle to unlock access to the "About the Author" section through the parental gate.

## Contact

For questions or feedback, please reach out to:

- **Name**: Josh Cox
- **Email**: [jdcox02@gmail.com](mailto:jdcox02@gmail.com)
- **GitHub**: [jdcox02](https://github.com/jdcox02)
- **LinkedIn**: [jdcox02](https://www.linkedin.com/in/jdcox02)
