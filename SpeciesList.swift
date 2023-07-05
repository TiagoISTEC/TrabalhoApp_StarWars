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
        @State private var n=0;
    
    //Variavel para retornar lista toda se a pesquisa estiver vazia ou entao os resultados da pesquisa

    var filteredSpecies: [Species] {
            if pesquisa.isEmpty {
                return speciesVM.speciesArray
            } else {
                return speciesVM.speciesArray.filter { $0.name.lowercased().contains(pesquisa.lowercased()) }
            }
        }
    
   
    
        var body: some View {
            NavigationStack {
                ZStack{
                    
                    List{
                        Section() {
                            HStack{
                                
                                //barra de pesquisa
                                
                                TextField("Search", text: $pesquisa)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                               }
                        }
                        
                        //correr a lista
                        
                            ForEach(filteredSpecies) { species in
                                LazyVStack {
                                    NavigationLink {
                                        
                                        //redereciona para view dos detalhes
                                        
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
                  
                  //botao para carregar todos os resultados
                  
                  Button("Load All") {
                  Task {
                      await speciesVM.loadAll()
                  }
                }
              }
                  ToolbarItem(placement: .status) {
                      
                      //Mostra a quantidade de especies
                      
                      Text("\(speciesVM.speciesArray.count) Species")
                  }
                  ToolbarItem(placement: .bottomBar){
                      
                      //botao para produzir um som
                      
                      Button{
                          var nextSound: Int
                          repeat {
                              nextSound = Int.random(in: 0...8)
                          } while nextSound == lastSound
                          lastSound = nextSound
                          playSound(soundName: "\(lastSound)")
                          
                          
                      }label:{
                          
                          //selecionaar imagem do icon do som
                          
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
   
    //funçao para produzir um som
    
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
