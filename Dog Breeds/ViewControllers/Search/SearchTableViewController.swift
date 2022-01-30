//
//  SearchTableViewController.swift
//  Dog Breeds
//
//  Created by Vittorio Allegra on 29/01/22.
//

import UIKit

class SearchTableViewController: UITableViewController {
    var delegate: SearchTableViewDelegate?
    
    private let reuseIdentifier = "TableCell"
    private let searchController = UISearchController(searchResultsController: nil)
    private var filteredList: [DogBreed] = []
    
    var list: [DogBreed] = [] { didSet { self.loadDogBreedsList() } }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search"
        
        self.searchController.searchResultsUpdater = self
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.sizeToFit()
        self.navigationItem.searchController = self.searchController
        
        self.tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: self.reuseIdentifier
        )
    }

    // MARK: - Table view data source

    override func numberOfSections(
        in tableView: UITableView
    ) -> Int {
        return 1
    }

    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return self.searchController.isActive
            ? self.filteredList.count
            : self.list.count
    }

    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: self.reuseIdentifier,
            for: indexPath
        )
        
        let breed = self.searchController.isActive
            ? self.filteredList[indexPath.row]
            : self.list[indexPath.row]
        cell.textLabel?.text = breed.capitalized
        cell.accessoryType = .disclosureIndicator

        return cell
    }
    
    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let breed = self.searchController.isActive
            ? self.filteredList[indexPath.row]
            : self.list[indexPath.row]
        self.delegate?.didSelectDogBreed(breed)
    }
}

private extension SearchTableViewController {
    func loadDogBreedsList() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension SearchTableViewController: UISearchResultsUpdating {
    func updateSearchResults(
        for searchController: UISearchController
    ) {
        guard self.list.count != 0,
              let text = searchController.searchBar.text else {
            return
        }
        
        self.filteredList = text.isEmpty
            ? self.list
            : self.list.filter({ $0.lowercased().contains(text.lowercased()) })
        self.tableView.reloadData()
    }
}
