//
//  PeopleList.swift
//  Star_Wars_Species
//
//  Created by Aluno ISTEC on 27/06/2023.
//

import SwiftUI

import AVFAudio

struct PeopleList: View {
    @StateObject var peopleVM = PeopleViewModel()
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
                                    peopleVM.search(term: pesquisa)
                                }
                                
                            }
                        }
                        ForEach(peopleVM.peopleArray) { peoples in
                            LazyVStack {
                                NavigationLink {
                                    DetailView_People(people:peoples)
                                    
                                    
                                }label:{
                                    
                                    Text(peoples.name)
                                }
                                
                            }
                            .task{
                                await peopleVM.loadNextIfNeeded(peopler: peoples)
                            }
                            
                        }
                        .font (.title)
                        .listStyle(.plain)
                        .navigationTitle("People")
                        
                        if peopleVM.isLoading{
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
                      await peopleVM.loadAll()
                  }
                }
              }
                  ToolbarItem(placement: .status) {
                      Text("\(peopleVM.peopleArray.count)People Returned")
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
                          Image ("Store_starwars (1)")
                          .resizable()
                          .scaledToFit()
                          .frame(height: 25)
                      }
                  }
              }
              
            }
            .task {
                await peopleVM.getData()
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

struct PeopleList_Previews: PreviewProvider {
    static var previews: some View {
        PeopleList()
    }
}
