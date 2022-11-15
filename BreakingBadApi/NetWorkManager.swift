//
//  NetWorkManager.swift
//  BreakingBadApi
//
//  Created by Николай Христолюбов on 08.11.2022.
//

import Foundation

enum Link: String {
    case characters = "https://www.breakingbadapi.com/api/characters"
}

class Networking {
    static let shared = Networking()
    private init () {}
    
    func fetchData(url: String, complition: @escaping(_ character: [Character]) -> Void) {
        
        guard let url = URL(string: Link.characters.rawValue) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            
            do {
                let characters = try JSONDecoder().decode([Character].self, from: data)
                complition(characters)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func fetchImage(url: URL?, complition: @escaping(_ image: Data) -> Void) {
        DispatchQueue.global().async {
            guard let url = url else { return }
            guard let imageData = try? Data(contentsOf: url) else { return }
            
            DispatchQueue.main.async {
                complition(imageData)
            }
        }
    }
}
