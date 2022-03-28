//
//  APIService.swift
//  SoulStudio
//
//  Created by Gautham Sritharan on 2022-03-28.
//

import Foundation

class ApiService {
    
    private var dataTask: URLSessionDataTask?
    
    func getBooksData(completion: @escaping (Result<Books, Error>) -> Void) {
        
        let booksURL = "https://www.googleapis.com/books/v1/volumes?q=flowers&startIndex=0&maxResults=10"
        
        guard let url = URL(string: booksURL) else {return}
        
        // Create URL Session - work on the background
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Handle Error
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                // Handle Empty Response
                print("Empty Response")
                return
            }
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                // Handle Empty Data
                print("Empty Data")
                return
            }
            
            do {
                // Parse the data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Books.self, from: data)
                
                // Back to the main thread
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
            
        }
        dataTask?.resume()
    }
}
