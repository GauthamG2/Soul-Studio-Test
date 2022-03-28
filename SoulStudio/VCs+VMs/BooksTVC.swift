//
//  BooksTVC.swift
//  SoulStudio
//
//  Created by Gautham Sritharan on 2022-03-28.
//

import UIKit

class BooksTVC: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var lblBook: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    // MARK: - LifeCycle
    
    // Setup books values
    func setCellWithValuesOf(_ book: Items) {
        updateUI(title: book.volumeInfo.title, description: book.volumeInfo.description, thumbnail: book.volumeInfo.imageLinks.thumbnail)
    }
    
    // Update the UI Views
    private func updateUI(title: String?, description: String?, thumbnail: String?) {
        containerView.addCornerRadius(radius: 10)
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        self.lblBook.text = title
        self.lblDescription.text = description
        
        if let url = thumbnail {
            thumbnailImageView.setImageWithUrl(url)
        }
    }
}
