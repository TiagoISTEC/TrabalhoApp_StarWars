//
//  DetailView_People.swift
//  Star_Wars_Species
//
//  Created by Aluno ISTEC on 27/06/2023.
//

import SwiftUI


struct DetailView_People: View {
let people: People
var body: some View {
        VStack(alignment: .leading){
                    Text(people.name)
                        .font(.largeTitle)
                        .bold()
                        
                    Rectangle()
                        .frame(height: 2)
                        .frame (maxWidth: .infinity)
                        .foregroundColor(.gray)
                        
                Group {
                
                    HStack(alignment: .top){
                        Text("Height:")
                        .bold()
                        Text(people.height)
                    }
                    
                    HStack(alignment: .top){
                        Text("Mass:")
                        .bold()
                        Text(people.mass)
                    }
                    
                    HStack(alignment: .top){
                        Text("Hair Color:")
                        .bold()
                        Text(people.hair_color)
                        
                        Spacer()
                        
                        Text("Skin Color:")
                        .bold()
                        Text(people.skin_color)
                    }
                    
                    
                    HStack(alignment: .top){
                        Text("Eye Color:")
                        .bold()
                        Text(people.eye_color)
                    }
                    
                    HStack(alignment: .top){
                        Text("Birth Year:")
                        .bold()
                        Text(people.birth_year)
                    }
                    
                    HStack(alignment: .top){
                        Text("Gender:")
                        .bold()
                        Text(people.gender)
                    }
           
                    }
                    .font(.title2)
                    
                    
                    VStack{
                    AsyncImage(url: URL(string: returnSpeciesURL())) { image in
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
            
            func returnSpeciesURL() -> String {
                var newName = people.name.replacingOccurrences(of: " ", with: "-")
                newName = newName.replacingOccurrences(of: "'", with: "")
                return "https://gallaugher.com/wp-content/uploads/2023/04/\(newName).jpg"
            }
        

        struct DetailView_People_Previews: PreviewProvider {
            static var previews: some View {
                DetailView_People(people:People(name: "sasas",height: "190",mass: "3213",hair_color: "blue",skin_color: "black",eye_color: "green",birth_year: "1990",gender: "homossexual"))
            }
        }

}
