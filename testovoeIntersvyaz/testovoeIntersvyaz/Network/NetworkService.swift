//
//  NetworkService.swift
//  testovoeIntersvyaz
//
//  Created by Fedor Boriskin on 08.02.2022.
//

import Foundation
import UIKit

struct NetworkService {
    
    static let shared = NetworkService()
    
    func startURLSessionDataTask(completion: @escaping ([Cartoons]) -> Void) {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos/") else { return }
        let decoder = JSONDecoder()
        
        let urlSession = URLSession.shared
        urlSession.dataTask(with: url) { data, response , error in
            
            guard let data = data else { return }
            if let post = try? decoder.decode([Cartoons].self, from: data) {
                completion(post)
                }
        
            if let error = error {
                print(error.localizedDescription)
            }
            
        }.resume()
    
    }
    
}
    
    
    
    
    

