//
//  ContentView.swift
//  Star_Wars_Species
//
//  Created by Aluno ISTEC on 21/06/2023.
//

import SwiftUI
import AVFAudio

struct SpeciesList: View {
    @StateObject var speciesVM = SpeciesViewModel()
        @State private var audioPlayer: AVAudioPlayer!
        @State private var lastSound = -1
        @State private var pesquisa=""

        
        var body: some View {
            NavigationStack {
                ZStack{
                    
                    List{
                        Section() {
                            HStack{
                                TextField("Search", text: $pesquisa)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                Button("Search"){
                                    speciesVM.search(term: pesquisa)
                                }}
                        }
                        ForEach(speciesVM.speciesArray) { species in
                            LazyVStack {
                                NavigationLink {
                                    DetailView(species:species)
                                    
                                    
                                }label:{
                                    
                                    Text(species.name)
                                }
                                
                            }
                            .task{
                                await speciesVM.loadNextIfNeeded(species: species)
                            }
                            
                            
                        }
                        
                        .font (.title)
                        .listStyle(.plain)
                        .navigationTitle("Species")
                        
                        if speciesVM.isLoading{
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
                      await speciesVM.loadAll()
                  }
                }
              }
                  ToolbarItem(placement: .status) {
                      Text("\(speciesVM.speciesArray.count)Specie Returned")
                  }
                  ToolbarItem(placement: .bottomBar){
                      Button{
                          var nextSound: Int
                          repeat {
                              nextSound = Int.random(in: 0...8)
                          } while nextSound == lastSound
                          lastSound = nextSound
                          playSound(soundName: "\(lastSound)")
                          
                      }label:{
                          Image ("peek")
                          .resizable()
                          .scaledToFit()
                          .frame(height: 25)
                      }
                  }
              }
              
            }
            .task {
                await speciesVM.getData()
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
            } catch{
                print ("ERROR: \(error.localizedDescription) creating audioPlayer")
            }
        }
        
    }

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            SpeciesList()
        }
    } 
