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
        var urlString = "https://swapi.dev/api/planets/"
        
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
                    print ("JSON ERROR: Could not convert data into JSON. \(error.localizedDescription)")
                    isLoading = false
                }
            } catch {
                print ("ERROR: could not get data from urlString \(urlString)")
                isLoading = false
            }
        }
        
        func loadNextIfNeeded(planets: Planets) async {
            guard let lastPlanets = planetsArray.last else {return}
            if lastPlanets.id == planets.id && urlString != "" {
                await getData()
            }
        }
    func search(term: String) {
        Task {
            isLoading = true
            let url = URL(string: "https://swapi.dev/api/planets/?search=\(term)")!
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let searchResults = try JSONDecoder().decode(Returned.self, from: data)
                planetsArray = searchResults.results
                isLoading = false
            } catch {
                print("JSON ERROR: Could not convert data into JSON. \(error.localizedDescription)")
                isLoading = false
            }
        }
    }
    
        func loadAll() async {
            guard urlString != "" else {return} //we' re done if urlString == "". No more pages
            await getData()
            await loadAll()
        }
    
}
