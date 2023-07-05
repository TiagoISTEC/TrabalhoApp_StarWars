//
//  PlanetsViewModel.swift
//  Star_Wars_Species
//
//  Created by Aluno ISTEC on 27/06/2023.
//

import Foundation
class PlanetsViewModel: ObservableObject {
    struct Returned: Codable {
        var next: String?
        var results: [Planets]
    }
        
        @Published var planetsArray: [Planets] = []
        @Published var isLoading = false
    @Published var searchResultsArray: [Planets] = []
    
    //URL da API
    
        var urlString = "https://swapi.dev/api/planets/"
    
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
                    planetsArray += returned.results
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
    
    func loadNextIfNeeded(planets: Planets) async {
        guard let lastPlanets = planetsArray.last else { return }
        if lastPlanets.id == planets.id {
            if !searchResultsArray.isEmpty {
                planetsArray += searchResultsArray
                searchResultsArray.removeAll()
            } else if urlString != "" {
                await getData()
            }
        }
    }
    
    // funçao para carregar toda a data
    
        func loadAll() async {
            guard urlString != "" else {return} 
            await getData()
            
        }
    
}
