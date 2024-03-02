import Foundation
import Combine


enum DemoError: Error {
    case BadURL
    case NoData
    case DecodingError
}

class FakeCocktailsAPI: CocktailsAPIDeligate {
       
    func fetchCocktails(_ handler: @escaping (Result<[Cocktail], DemoError>) -> Void) {
            guard let url = Bundle.main.url(forResource: "sample", withExtension: "json"),
                  let data = try? Data(contentsOf: url),
                  let model = try? JSONDecoder().decode([Cocktail].self, from: data) else {
                      return handler(.failure(.DecodingError))
                  }
           handler(.success(model))
    }
    
}
