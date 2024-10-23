//
//  EndOfBookView.swift
//  MaxCosmicJourney
//
//  Created by Joshua Cox on 4/7/24.
//

import SwiftUI

// Protocol to handle delegate actions related to Swifty's functionality.
// Includes a method to restart the book.
protocol EndOfBookViewDelegate {
    func restartBook()
}

// Swifty is a SwiftUI View that displays a message and options for the user to either restart the book or play a game.
struct EndOfBookView: View {
    // Delegate to handle actions outside of this view, such as restarting the book.
    var delegate: EndOfBookViewDelegate?

    // State variable to control whether the game view is presented.
    @State private var showGame = false
    
    var body: some View {
        VStack(spacing: 10) {
            // Displays a thank-you message to the user.
            Text("Thanks for reading!")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .padding(20)
            
            // Button to restart the book using the delegate method.
            Button(action: {
                delegate?.restartBook()
            }) {
                Text("Restart book")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(.cyan)
                    .cornerRadius(10)
            }
            
            // Button to play a game, setting `showGame` to true when pressed.
            Button(action: {
                print("play game button pressed")
                showGame = true
            }) {
                Text("Play a game")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(.green)
                    .cornerRadius(10)
            }
            .padding()
            .fullScreenCover(isPresented: $showGame) {  // Present the game view modally
                SpriteKitContainer()
            }
        }
    }
}

#Preview {
    EndOfBookView()
}
