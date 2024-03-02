import Foundation
import Combine

protocol CocktailsAPIDeligate: AnyObject {
    func fetchCocktails(_ handler: @escaping (Result<[Cocktail], DemoError>) -> Void)
}
