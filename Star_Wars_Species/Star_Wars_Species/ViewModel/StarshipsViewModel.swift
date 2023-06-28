//
//  StarshipsViewModel.swift
//  Star_Wars_Species
//
//  Created by Aluno ISTEC on 27/06/2023.
//

import Foundation
@MainActor
class StarshipsViewModel: ObservableObject {
    struct Returned: Codable {
        var next: String?
        var results: [Starships]
    }
        
        @Published var starshipArray: [Starships] = []
        @Published var isLoading = false
        var urlString = "https://swapi.dev/api/starships/"
        
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
                    starshipArray += returned.results
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
        
        func loadNextIfNeeded(starships: Starships) async {
            guard let lastStarship = starshipArray.last else {return}
            if lastStarship.id == starships.id && urlString != "" {
                await getData()
            }
        }
        
        func loadAll() async {
            guard urlString != "" else {return} //we' re done if urlString == "". No more pages
            await getData()
            await loadAll()
        }
    
}
