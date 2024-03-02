//
//  File.swift
//  CocktailBook
//
//  Created by Nagarjuna on 3/1/24.
//

import Foundation

struct Cocktail:Codable,Comparable{
    
    
    let id: String
    let name: String
    let type: String
    let shortDescription: String
    let longDescription: String
    let preparationMinutes: Int
    let imageName: String
    let ingredients: [String]
    
    static func < (lhs: Cocktail, rhs: Cocktail) -> Bool {
            return lhs.name < rhs.name
        }
}
