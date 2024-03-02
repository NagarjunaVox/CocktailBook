//
//  CocktailViewModel.swift
//  CocktailBook
//
//  Created by Nagarjuna on 3/1/24.
//

import Foundation

protocol CocktailViewModelDelegate:AnyObject{
    func cocktailsUpdated(_ cocktails: [Cocktail])

}

class CocktailViewModel{
    
    
    weak var delegate: CocktailViewModelDelegate?
    
    let cocktailHandler:CocktailsAPIDeligate
    
    init(cocktailHandler: CocktailsAPIDeligate = FakeCocktailsAPI()) {
        self.cocktailHandler = cocktailHandler
    }
    
    var cocktails = [Cocktail]()

    func fetchCocktails(){
        
        cocktailHandler.fetchCocktails{ result in
            DispatchQueue.main.async {
                
                switch result {
                case .success(let cocktails):
                    print("fetch new comments")
                    self.delegate?.cocktailsUpdated(cocktails)
                case .failure(let error):
                    print(error)
                    
                }
            }
            
            
        }
        
        
        
    }
    
}



