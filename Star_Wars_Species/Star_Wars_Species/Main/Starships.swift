//
//  Starships.swift
//  Star_Wars_Species
//
//  Created by Aluno ISTEC on 27/06/2023.
//

import Foundation

struct Starships: Identifiable, Codable{
    let id = UUID().uuidString
    var name = ""
    var model = ""
    var manufacturer = ""
    var cost_in_credits = ""
    var lenght = ""
    var max_atmosphering_speed = ""
    var crew = ""
    var passengers = ""
    var cargo_capacity = ""
    var consumables = ""
    var hyperdrive_rating = ""
    var MGLT = ""
    var starship_class = ""
    var pilots = ""
    var pesquisa = ""
    enum CodingKeys : CodingKey {
        case name, model ,manufacturer ,cost_in_credits , lenght ,max_atmosphering_speed , crew , passengers , cargo_capacity,consumables ,hyperdrive_rating ,MGLT , starship_class ,pilots 
    }
    
}
