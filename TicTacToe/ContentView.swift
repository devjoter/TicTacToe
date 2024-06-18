//
//  ContentView.swift
//  TicTacToe
//
//  Created by MarcinWiatr on 18/06/2024.
//

import SwiftUI

// Define the Player enum to represent the two players: X and O
enum Player: String {
    case x = "X"
    case o = "O"
}

// Main ContentView struct that conforms to the View protocol
struct ContentView: View {
    // State variables to manage game state
    @State private var currentPlayer: Player = .x
    @State private var cells: [[Player?]] = Array(repeating: Array(repeating: nil, count: 3), count: 3)
    @State private var winner: Player?
    @State private var isDraw: Bool = false
    @State private var winningCells: Set<[Int]> = []
    
    var body: some View {
        VStack(spacing: 20) {
            // Title Text
            Text("Tic Tac Toe")
                .font(.system(size: 40, weight: .bold))
                .padding(.vertical)
            
            Spacer()
            
            // Display the current player's turn if there is no winner or draw
            if winner == nil && isDraw == false {
                Text("Player \(currentPlayer.rawValue)'s turn")
                    .font(.title2)
                    .foregroundColor(currentPlayer == .x ? .red : .blue)
            }
            
            // Loop to create the game grid
            ForEach(0..<3) { row in
                HStack(spacing: 20) {
                    ForEach(0..<3) { column in
                        // Button for each cell in the grid
                        Button(action: {
                            if cells[row][column] == nil {
                                // Update the cell with the current player's move
                                cells[row][column] = currentPlayer
                                // Switch to the other player
                                currentPlayer = currentPlayer == .x ? .o : .x
                                // Check if there is a winner or a draw
                                checkWinner()
                            }
                        }, label: {
                            // Cell design
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(currentColor(row, column))
                                    .frame(width: 80, height: 80)
                                    .shadow(radius: 5)
                                Text(cells[row][column]?.rawValue ?? "")
                                    .font(.system(size: 50, weight: .bold))
                                    .foregroundColor(.white)
                                    .scaleEffect(winningCells.contains([row, column]) ? 1.2 : 1.0)
                                    .animation(.easeInOut(duration: 0.5), value: cells[row][column])
                            }
                        })
                        .disabled(winner != nil) // Disable buttons if there is a winner
                    }
                }
            }
            
            Spacer()
            
            // Display the winner or draw status
            if let winner = winner {
                Text("Player \(winner.rawValue) wins!")
                    .font(.title)
                    .foregroundColor(.green)
                    .scaleEffect(2.0)
                    .animation(.linear(duration: 0.5))
                    .padding(.vertical)
            } else if isDraw {
                Text("It's a draw!")
                    .font(.title)
                    .foregroundColor(.orange)
                    .scaleEffect(2.0)
                    .animation(.linear(duration: 0.5))
                    .padding(.vertical)
            }
            
            Spacer()
            
            // Reset button to start a new game
            Button(action: resetGame) {
                Text("Reset Game")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
        }
        .padding()
        .background(Color(.systemGray6))
    }
    
    // Function to return the color for each cell based on the player
    func currentColor(_ row: Int, _ column: Int) -> Color {
        if cells[row][column] == .x {
            return .red
        } else if cells[row][column] == .o {
            return .blue
        }
        return .gray
    }
    
    // Function to check for a winner or a draw
    private func checkWinner() {
        // Check rows for a win
        for row in 0..<3 {
            if let player = cells[row][0], cells[row][1] == player, cells[row][2] == player {
                winner = player
                winningCells = Set([[row, 0], [row, 1], [row, 2]])
                return
            }
        }
        
        // Check columns for a win
        for column in 0..<3 {
            if let player = cells[0][column], cells[1][column] == player, cells[2][column] == player {
                winner = player
                winningCells = Set([[0, column], [1, column], [2, column]])
                return
            }
        }
        
        // Check diagonal (top-left to bottom-right) for a win
        if let player = cells[0][0], cells[1][1] == player, cells[2][2] == player {
            winner = player
            winningCells = Set([[0, 0], [1, 1], [2, 2]])
            return
        }
        
        // Check diagonal (top-right to bottom-left) for a win
        if let player = cells[0][2], cells[1][1] == player, cells[2][0] == player {
            winner = player
            winningCells = Set([[0, 2], [1, 1], [2, 0]])
            return
        }
        
        // Check for a draw (no empty cells left)
        if !cells.flatMap({ $0 }).contains(nil) {
            isDraw = true
        }
    }
    
    // Function to reset the game to its initial state
    private func resetGame() {
        currentPlayer = .x
        cells = Array(repeating: Array(repeating: nil, count: 3), count: 3)
        winner = nil
        isDraw = false
        winningCells = Set()
    }
}

// Preview provider for SwiftUI previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


