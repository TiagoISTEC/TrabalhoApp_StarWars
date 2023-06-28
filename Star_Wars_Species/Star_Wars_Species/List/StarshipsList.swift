//
//  StarshipsList.swift
//  Star_Wars_Species
//
//  Created by Aluno ISTEC on 27/06/2023.
//

import SwiftUI
import AVFAudio

struct StarshipsList: View {
    
    @StateObject var starshipVM = StarshipsViewModel()
        @State private var audioPlayer: AVAudioPlayer!
        @State private var lastSound = -1
        @State private var pesquisa=""
            
            var body: some View {
                NavigationStack {
                    ZStack{
                    List(starshipVM.starshipArray) { starship in
                    LazyVStack {
                        NavigationLink {
                            DetailView_Starship(starship:starship)
                            
                        }label:{
                            
                            Text(starship.name)
                        }
                        
                        }
                        .task{
                           await starshipVM.loadNextIfNeeded(starships: starship)
                        }
                        
                    }
                    .font (.title)
                    .listStyle(.plain)
                    .navigationTitle("Starship")
                    
                    if starshipVM.isLoading{
                        ProgressView()
                    .scaleEffect(4)
                    .tint(.green)
                    }
                    
                    
                  }
                  
                  .toolbar{
                  ToolbarItem(placement: .bottomBar){
                      Button("Load All") {
                      Task {
                          await starshipVM.loadAll()
                      }
                    }
                  }
                      ToolbarItem(placement: .status) {
                          Text("\(starshipVM.starshipArray.count)StarShips Returned")
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
                    await starshipVM.getData()
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
                    playSound(soundName: "people_sounds")

                } catch{
                    print ("ERROR: \(error.localizedDescription) creating audioPlayer")
                }
            }
            
        }
struct StarshipsList_Previews: PreviewProvider {
    static var previews: some View {
        StarshipsList()
    }
}
