//
//  PeopleViewModel.swift
//  Star_Wars_Species
//
//  Created by Aluno ISTEC on 27/06/2023.
//

import Foundation

@MainActor
class PeopleViewModel: ObservableObject {
    struct Returned: Codable {
        var next: String?
        var results: [People]
    }
        
        @Published var peopleArray: [People] = []
        @Published var isLoading = false
        var urlString = "https://swapi.dev/api/people/"
        
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
                    peopleArray += returned.results
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
        
        func loadNextIfNeeded(peopler: People) async {
            guard let lastPeople = peopleArray.last else {return}
            if lastPeople.id == peopler.id && urlString != "" {
                await getData()
            }
        }
    
    func search(term: String) {
        Task {
            isLoading = true
            let url = URL(string: "https://swapi.dev/api/people/?search=\(term)")!
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let searchResults = try JSONDecoder().decode(Returned.self, from: data)
                peopleArray = searchResults.results
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
