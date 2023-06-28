//
//  SpeciesDisc.swift
//  Star_Wars_Species
//
//  Created by Aluno ISTEC on 27/06/2023.
//

/*import Foundation
@MainActor
class SpeciesDisc: ObservableObject{
    
    @Published var trending: [Species] = []
    @Published var searchResults: [Species] = []
    
    
    func loadTrending() {
        Task {
            let url = URL(string:"https://swapi.dev/api/species/" )!
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let trendingResults = try JSONDecoder().decode(Species.self, from: data)
                trending = Species.name
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    
    func search(term: String) {
        Task {
            isLoading = true
            let url = URL(string: "https://swapi.dev/api/species/?search=\(term)")!
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let searchResults = try JSONDecoder().decode(Returned.self, from: data)
                speciesArray = searchResults.results
                isLoading = false
            } catch {
                print("JSON ERROR: Could not convert data into JSON. \(error.localizedDescription)")
                isLoading = false
            }
        }
    }
}
*/
