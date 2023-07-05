//
//  SpeciesViewModel.swift
//  Star_Wars_Species
//
//  Created by Aluno ISTEC on 21/06/2023.
//

import Foundation

@MainActor
class SpeciesViewModel: ObservableObject {
    struct Returned: Codable {
        var next: String?
        var results: [Species]
    }
    
        @Published var speciesArray: [Species] = []
        @Published var isLoading = false
        @Published var searchResultsArray: [Species] = []
    
        //URL da API
    
        var urlString = "https://swapi.dev/api/species/"
        
        //Funçao para carregar o URL (caso ele reconheça ele entra caso de negativo vai dar erro)
    
        func getData() async {
            isLoading = true
            print ("We are accssing the url  \(urlString)")
            
            guard let url = URL(string: urlString) else {
                print ("ERROR: clould not convert \(urlString) to URL")
                isLoading = false
                return
            }
            do{
                let (data, _) = try await URLSession.shared.data(from: url)
                do{
                    let returned = try JSONDecoder().decode(Returned.self, from: data)
                    print ("return: \(returned)")
                    urlString = returned.next ?? ""
                    speciesArray += returned.results
                    isLoading = false
                } catch {
                    
                    //erro ao coverter ao fazer
                    
                    print ("JSON ERROR: Could not convert data into JSON. \(error.localizedDescription)")
                    isLoading = false
                }
            } catch {
                print ("ERROR: could not get data from urlString \(urlString)")
                isLoading = false
            }
        }
    

    
   
    //funçao para carregar o resultado que o utlizador quer e descarta o resto
    
func loadNextIfNeeded(species: Species) async {
    guard let lastSpecies = speciesArray.last else { return }
    if lastSpecies.id == species.id {
        if !searchResultsArray.isEmpty {
            speciesArray += searchResultsArray
            searchResultsArray.removeAll()
        } else if urlString != "" {
            await getData()
        }
    }
}
    
    // funçao para carregar toda a data 
        func loadAll() async {
            guard urlString != "" else {return} //we' re done if urlString == "". No more pages
            await getData()
            
        }
    
}
