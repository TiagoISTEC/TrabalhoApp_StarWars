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
    
    //Variavel para retornar lista toda se a pesquisa estiver vazia ou entao os resultados da pesquisa
    
    var filteredPeople: [People] {
            if pesquisa.isEmpty {
                return peopleVM.peopleArray
            } else {
                return peopleVM.peopleArray.filter { $0.name.lowercased().contains(pesquisa.lowercased()) }
            }
        }
    
        var body: some View {
            NavigationStack {
                ZStack{
                    List{
                        Section{
                            HStack{
                                
                                //barra de pesquisa
                                
                                TextField("Search", text: $pesquisa)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                
                                
                            }
                        }
                        
                        //correr a lista
                        
                        ForEach(filteredPeople) { peoples in
                            LazyVStack {
                                NavigationLink {
                                    
                                    //redereciona para view dos detalhes
                                    
                                    DetailView_People(people:peoples)
                                    
                                    
                                }label:{
                                    
                                    Text(peoples.name)
                                }
                                
                            }
                            .task{
                                await peopleVM.loadNextIfNeeded(people: peoples)
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
                  
                  //botao para carregar todos os resultados
                  
                  Button("Load All") {
                  Task {
                      await peopleVM.loadAll()
                  }
                }
              }
                  ToolbarItem(placement: .status) {
                      
                      //Mostra a quantidade de especies
                      
                      Text("\(peopleVM.peopleArray.count) People")
                  }
                  ToolbarItem(placement: .bottomBar){
                      
                      //botao para produzir um som
                      
                      
                      Button{
                          var nextSound: Int
                          repeat {
                              nextSound = Int.random(in: 0...2)
                          } while nextSound == lastSound
                          lastSound = nextSound
                          playSound(soundName: "\(lastSound)")
                          
                      }label:{
                          
                          //selecionaar imagem do icon do som
                          
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
        
    //funçao para produzir um som
    
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
