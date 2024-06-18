//
//  WinnerView.swift
//  TicTacToe
//
//  Created by MarcinWiatr on 18/06/2024.
//

import SwiftUI

struct WinnerView: View {
    let winner: Player
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Congratulations!")
                .font(.largeTitle)
                .foregroundColor(.green)
            
            Text("Player \(winner.rawValue) wins!")
                .font(.title)
                .foregroundColor(.blue)
            
            Button(action: {
                // Action to dismiss the view or restart the game
                // Add any necessary actions here
            }) {
                Text("Play Again")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
        .navigationBarBackButtonHidden(true)
    }
}

struct WinnerView_Previews: PreviewProvider {
    static var previews: some View {
        WinnerView(winner: .x)
    }
}
