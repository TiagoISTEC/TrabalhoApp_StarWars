//
//  People.swift
//  Star_Wars_Species
//
//  Created by Aluno ISTEC on 27/06/2023.
//

import Foundation

struct People: Identifiable, Codable{
    let id = UUID().uuidString
    var name = ""
    var height = ""
    var mass = ""
    var hair_color = ""
    var skin_color = ""
    var eye_color = ""
    var birth_year = ""
    var gender = ""
    var pesquisa = ""
    enum CodingKeys : CodingKey {
        case name,height,mass,hair_color,skin_color,eye_color,birth_year,gender
    }
    
}
