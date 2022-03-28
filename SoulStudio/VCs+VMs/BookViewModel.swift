//
//  BookViewModel.swift
//  SoulStudio
//
//  Created by Gautham Sritharan on 2022-03-28.
//

import Foundation

class BookViewModel {
    
    private var apiService = ApiService()
    private var items = [Items]()
    
    func fetchBooksData(completion: @escaping () -> ()) {
        
        // weak self - prevent retain cycles
        apiService.getBooksData { [weak self] (result) in
            
            switch result {
            case .success(let listOf):
                self?.items = listOf.items
                completion()
            case .failure(let error):
                // Something is wrong with the JSON file or the model
                print("Error processing json data: \(error)")
            }
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        if items.count != 0 {
            return items.count
        }
        return 0
    }
    
    func cellForRowAt (indexPath: IndexPath) -> Items {
        return items[indexPath.row]
    }
}
