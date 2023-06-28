//
//  Pagina_Inicial.swift
//  Star_Wars_Species
//
//  Created by Aluno ISTEC on 26/06/2023.
//

import SwiftUI
import UIKit

struct Pagina_Inicial: View {
    var urlString = "https://swapi.dev/api/species/"
    var body: some View{
        
        NavigationView {
            
            GeometryReader{ geo in
                
                    Image("background")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                        .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                        .opacity(1.0)
                    
              
                
                
                VStack{
                    NavigationLink(destination:SpeciesList()){
                        Text("Species")
                            .frame(width:200,height: 50,alignment: .center)
                            .fontWeight(.bold)
                            .font(.system(size:20))
                            .foregroundColor(.black)
                            .background(.yellow)
                            .clipShape(Capsule())
                            .shadow(color: .red, radius: 15,x: 8,y: 8)
                            .padding(20)
                    }
                    NavigationLink(destination:PlanetsList()){
                        Text("Planets")
                            .frame(width:200,height: 50,alignment: .center)
                            .fontWeight(.bold)
                            .font(.system(size:20))
                            .foregroundColor(.black)
                            .background(.yellow)
                            .clipShape(Capsule())
                            .shadow(color: .red, radius: 15,x: 8,y: 8)
                            .padding(20)
                        
                    }
                    
                    NavigationLink(destination:PeopleList()){
                        Text("People")
                            .frame(width:200,height: 50,alignment: .center)
                            .fontWeight(.bold)
                            .font(.system(size:20))
                            .foregroundColor(.black)
                            .background(.yellow)
                            .clipShape(Capsule())
                            .shadow(color: .red, radius: 15,x: 8,y: 8)
                            .padding(20)
                    }
                    
                    
                }.frame(width: 200,height: 200,alignment: .center)
                    .padding(.leading,100)
                    .padding(.top,250)
                
            }
        }
        
    }
    
    struct Pagina_Inicial_Previews: PreviewProvider {
        static var previews: some View {
            Pagina_Inicial()
        }
    }
    
}
