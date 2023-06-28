//
//  PlanetsList.swift
//  Star_Wars_Species
//
//  Created by Aluno ISTEC on 27/06/2023.
//

import SwiftUI
import AVFAudio

struct PlanetsList: View {
    @StateObject var planetsVM = PlanetsViewModel()
        @State private var audioPlayer: AVAudioPlayer!
        @State private var lastSound = -1
        @State private var pesquisa=""
        
        var body: some View {
            NavigationStack {
                ZStack{
                    List{
                        Section{
                            HStack{
                                
                                TextField("Search", text: $pesquisa)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                Button("Search"){
                                    planetsVM.search(term: pesquisa)
                                }
                                
                            }
                        }
                        ForEach(planetsVM.planetsArray) { planet in
                            LazyVStack {
                                NavigationLink {
                                    DetailView_Plan(planets:planet)
                                    
                                    
                                }label:{
                                    
                                    Text(planet.name)
                                }
                                
                            }
                            .task{
                                await planetsVM.loadNextIfNeeded(planets: planet)
                            }
                            
                        }
                        .font (.title)
                        .listStyle(.plain)
                        .navigationTitle("Planets")
                        
                        if planetsVM.isLoading{
                            ProgressView()
                                .scaleEffect(4)
                                .tint(.green)
                        }
                    }
                
              }
              
              .toolbar{
              ToolbarItem(placement: .bottomBar){
                  Button("Load All") {
                  Task {
                      await planetsVM.loadAll()
                  }
                }
              }
                  ToolbarItem(placement: .status) {
                      Text("\(planetsVM.planetsArray.count)Planets Returned")
                  }
                  ToolbarItem(placement: .bottomBar){
                      Button{
                          var nextSound: Int
                          repeat {
                              nextSound = Int.random(in: 0...2)
                          } while nextSound == lastSound
                          lastSound = nextSound
                          playSound(soundName: "\(lastSound)")
                          
                      }label:{
                          Image ("Store_starwars (2)")
                          .resizable()
                          .scaledToFit()
                          .frame(height: 25)
                      }
                  }
              }
              
            }
            .task {
                await planetsVM.getData()
            }
        }
        
        func playSound(soundName: String){
            guard let soundFile = NSDataAsset (name: soundName) else{
                print("ERROR: Could not read file named \(soundName)")
                return
            }
            do{
                audioPlayer = try AVAudioPlayer(data: soundFile.data)
                audioPlayer.play()
                playSound(soundName: "planets_sounds")

            } catch{
                print ("ERROR: \(error.localizedDescription) creating audioPlayer")
            }
        }
        
    }

    struct ContentView2_Previews: PreviewProvider {
        static var previews: some View {
            PlanetsList()
        }
    }

