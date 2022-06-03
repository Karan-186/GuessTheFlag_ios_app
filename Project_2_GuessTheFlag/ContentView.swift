//
//  ContentView.swift
//  Project_2_GuessTheFlag
//
//  Created by KARAN  on 31/05/22.
//

import SwiftUI

struct Title : ViewModifier {
    func body(content: Content) -> some View {
        content
            .clipShape(Capsule())
            .shadow(radius: 5)
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
    @State private var scoreValue = 0
    @State private var roundsPlayed = 0
    @State private var maxReached = false
    
    

    @State private var countries = ["UK", "US", "Estonia","France","Germany","Ireland","Italy","Nigeria","Poland","Russia","Spain","India"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    
    
    var body: some View {
        ZStack{
            
            RadialGradient(stops: [
                .init(color: Color(red : 0.1 , green: 0.2, blue: 0.45 ), location: 0.3),
                .init(color: Color(red : 0.76 , green: 0.15, blue: 0.26 ), location: 0.3)
            ],center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            VStack{
                Spacer()
                Text("Guess The Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                VStack(spacing : 15){
                    VStack{
                        Text("Tap The Flag")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3){ number in
                        Button{
                            roundsPlayed += 1
                            if roundsPlayed==8{
                                maxReached=true
                            }
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .titleStyle()
                                
                                
                        }
                        
                    }
                    
                }
                .frame(maxWidth : .infinity)
                .padding(.vertical , 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
                Spacer()
                
                Text("Score : \(scoreValue)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore ){
            Button("Continue",action: askQuestion)
        }message: {
            Text("you score is \(scoreValue)")
        }
        .alert(scoreTitle,isPresented: $maxReached){
            Button("Restart" , action: reset)
        }message: {
            Text("Total score in 8 round's is \(scoreValue)")
        }
    }
    func flagTapped(_ number : Int){
        if number==correctAnswer{
            scoreTitle = "You are Correct"
            scoreValue += 1
        }else{
            scoreTitle = "Wrong! That’s the flag of \(countries[number])"
            scoreValue -= 1
        }
        showingScore=true
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0..<2)
    }
    
    func reset(){
        scoreTitle = ""
        scoreValue = 0
        roundsPlayed=0
        showingScore = false
        maxReached = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
