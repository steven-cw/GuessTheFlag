//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Steven Williams on 9/21/23.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var tries = 0
    @State private var animationAmount = 0.0
    @State private var chosenFlag = -1
    
   
        
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700).ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                            // flag was tapped
                        } label: {
                            FlagImage(country: countries[number])
                        }
                        .rotation3DEffect(.degrees(chosenFlag == number ? 360 : 0), axis: (x: 0, y: 1, z: 0))
                        .opacity(chosenFlag == -1 || chosenFlag == number ? 1: 0.25)
                        .scaleEffect(chosenFlag == -1 || chosenFlag == number ? 1: 0.25)
                        .animation(.default, value: chosenFlag)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)/\(tries)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            } .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)/\(tries)")
        }
    }
    
    func flagTapped(_ number: Int) {
        chosenFlag = number
        
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            tries += 1
        }
        else {
            scoreTitle = "Wrong"
            tries += 1
        }
        animationAmount += 360
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        chosenFlag = -1
    }
}
    

#Preview {
    ContentView()
}
