//
//  BooksVC.swift
//  SoulStudio
//
//  Created by Gautham Sritharan on 2022-03-28.
//

import UIKit
import PullToRefreshKit

class BooksVC: UIViewController {
    
    // MARK: - Variables
    
    private var viewModel = BookViewModel()
    var refresher : UIRefreshControl!
    
    // MARK: - Outlets
     
    @IBOutlet weak var booksTableView: UITableView!
     
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadBooksData()
        addPullToRefresh()
    }
    
    private func loadBooksData() {
        viewModel.fetchBooksData { [weak self] in
            self?.booksTableView.dataSource = self
            self?.booksTableView.reloadData()
        }
    }
    
    func addPullToRefresh() {
        self.refresher = UIRefreshControl()
        self.booksTableView!.alwaysBounceVertical = true
        self.refresher.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.refresher.addTarget(self, action: #selector(loadData), for: .valueChanged)
        self.booksTableView!.addSubview(refresher)
    }
    
    @objc func loadData() {
        self.booksTableView!.refreshControl?.beginRefreshing()
        booksTableView.reloadData()
        stopRefresher()
    }
    
    func stopRefresher() {
        self.booksTableView!.refreshControl?.endRefreshing()
        refresher.endRefreshing()
    }
}


// MARK: - TableView
extension BooksVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BooksTVC", for: indexPath) as! BooksTVC
        let items = viewModel.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValuesOf(items)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
}
