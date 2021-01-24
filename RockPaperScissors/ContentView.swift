//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Kevin Boulala on 23/01/2021.
//

import SwiftUI

struct ContentView: View {
    private let symbols = ["✊":"✋", "✋":"✌️", "✌️":"✊"]
    
    @State private var bot = "✊"
    @State private var shouldWin = Bool.random()
    @State private var color = Color.gray
    
    @State private var showResult = false
    
    @State private var isWin = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [color, .black]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 100) {

                VStack(spacing: 20) {
                    Text("Rock Paper Scissors")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                    
                    HStack {
                        Text("You must ")
                            .foregroundColor(.white)
                        Text("\(shouldWin ? "win" : "loose")")
                            .fontWeight(.heavy)
                            .foregroundColor(shouldWin ? .green : .red)
                        Text(" against")
                            .foregroundColor(.white)
                    }
                    
                    Text("\(bot)")
                        .font(.largeTitle)
                }
                
                VStack(spacing: 20) {
                    Text("Choose")
                        .foregroundColor(.white)
                    HStack(spacing: 50) {
                        ForEach(symbols.sorted(by: >), id: \.key) { key, _ in
                            Button(action: {
                                isWin = roundResult(bot: bot, player: key, shouldWin: shouldWin)
                                updateUI()
                                showResult = true
                            }, label: {
                                Text(key)
                                    .font(.largeTitle)
                            })
                        }
                    }
                }
                
                
                Spacer()
            }
        }
        .alert(isPresented: $showResult, content: {
            Alert(title: Text("Score"), message: Text("You \(isWin ? "win" : "loose")!"), dismissButton: Alert.Button.default(Text("Continue"), action: {
                color = .gray
                newRound()
            }))
        })
    }
    
    func roundResult(bot: String, player: String, shouldWin: Bool) -> Bool {
        if shouldWin {
            return player == symbols[bot]
        }
        
        return player == symbols.first(where: { $0.value == bot })?.key
    }
    
    func updateUI() {
        if isWin {
            color = .green
        } else {
            color = .red
        }
    }
    
    func newRound() {
        bot = symbols.randomElement()!.key
        shouldWin = Bool.random()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
