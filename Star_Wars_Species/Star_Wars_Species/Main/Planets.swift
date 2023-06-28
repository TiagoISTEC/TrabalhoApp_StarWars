//
//  Planets.swift
//  Star_Wars_Species
//
//  Created by Aluno ISTEC on 27/06/2023.
//

import Foundation
struct Planets: Identifiable, Codable{
    let id = UUID().uuidString
    var name = ""
    var rotation_period = ""
    var orbital_period = ""
    var diameter = ""
    var climate = ""
    var gravity = ""
    var terrain = ""
    var surface_water = ""
    var population = ""
    
    enum CodingKeys : CodingKey {
        case name,rotation_period,orbital_period,diameter,climate,gravity,terrain,surface_water,population
    }
}
