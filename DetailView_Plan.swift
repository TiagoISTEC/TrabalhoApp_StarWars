//
//  DetailView_Plan.swift
//  Star_Wars_Species
//
//  Created by Aluno ISTEC on 27/06/2023.
//

import SwiftUI

struct DetailView_Plan: View {
    let planets: Planets
        var body: some View {
            VStack(alignment: .leading){
                Text(planets.name)
                    .font(.largeTitle)
                    .bold()
                    
                Rectangle()
                    .frame(height: 2)
                    .frame (maxWidth: .infinity)
                    .foregroundColor(.gray)
                    
            Group {
            
                HStack(alignment: .top){
                    Text("Rotations:")
                    .bold()
                    Text(planets.rotation_period)
                }
                
                HStack(alignment: .top){
                    Text("Orbital Period:")
                    .bold()
                    Text(planets.orbital_period)
                }
                
                HStack(alignment: .top){
                    Text("Diameter:")
                    .bold()
                    Text(planets.diameter)
                    
                    Spacer()
                    
                    Text("Climate:")
                    .bold()
                    Text(planets.climate)
                }
                
                
                HStack(alignment: .top){
                    Text("Gravity:")
                    .bold()
                    Text(planets.gravity)
                }
                
                HStack(alignment: .top){
                    Text("Terrain:")
                    .bold()
                    Text(planets.terrain)
                }
                
                HStack(alignment: .top){
                    Text("Surface Water:")
                    .bold()
                    Text(planets.surface_water)
                }
                
                HStack(alignment: .top){
                    Text("Population:")
                    .bold()
                    Text(planets.population)
                }
                
                }
                .font(.title2)
                
                
                VStack{
                AsyncImage(url: URL(string: returnPlanetsURL())) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(15)
                        .shadow(radius: 15)
                        .animation(.default, value: image)
                    } placeholder: {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                     }
                }
                
                .frame(maxWidth: .infinity)
                
                    Spacer()
                
                
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            
        }
    
    //funçao para mostrar imagem
        
    func returnPlanetsURL() -> String {
        var newName = planets.name.replacingOccurrences(of: " ", with: "-")
        newName = newName.replacingOccurrences(of: "'", with: "")
        
        let urlOptions = [
            "https://static.wikia.nocookie.net/starwars/images/1/1d/\(newName)_SWCT.png/revision/latest/scale-to-width-down/1000?cb=20160630022322",
            "https://static.wikia.nocookie.net/starwars/images/b/b0/\(newName)_TPM.png/revision/latest?cb=20131019121937",
            "https://static.wikia.nocookie.net/starwars/images/6/6d/\(newName)_AotC.png/revision/latest/scale-to-width-down/1000?cb=20121231120327"
        ]
        
        for url in urlOptions {
            if let url = URL(string: url), let imageData = try? Data(contentsOf: url) {
                return url.absoluteString
            }
        }
        
        return "" // Retorna uma string vazia se nenhum URL estiver disponível
    }
    
    
    }

    struct DetailView_Plan_Previews: PreviewProvider {
        static var previews: some View {
            DetailView_Plan(planets: Planets(name: "Swifter", rotation_period: "Coder", orbital_period: "sentient", diameter: "175", climate: "100",
                                             gravity: "Swift", terrain: "sentient", surface_water: "175",
                                             population: "1000000"))
        }
    }
