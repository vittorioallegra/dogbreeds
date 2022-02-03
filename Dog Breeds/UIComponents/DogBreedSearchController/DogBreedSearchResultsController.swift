//
//  DogBreedSearchResultsController.swift
//  Dog Breeds
//
//  Created by Vittorio Allegra on 30/01/22.
//

import UIKit

protocol DogBreedSearchResultsDelegate: AnyObject {
    func didSelectOption(_ option: DogBreed)
}

class DogBreedSearchResultsController: UITableViewController {
    weak var delegate: DogBreedSearchResultsDelegate?
    var searchOptions: [DogBreed] = [] { didSet { self.loadSearchOptions() } }
    var searchText: String = "" { didSet { self.loadSearchText() } }
    
    private let reuseIdentifier = "SearchTableCell"
    private var filteredSearchOptions: [DogBreed] = []
    
    init() {
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        return self.getSearchOptions().count
    }

    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: self.reuseIdentifier,
            for: indexPath
        )
        
        let breed = self.getSearchOptions()[indexPath.row]
        cell.textLabel?.text = breed.capitalized
        cell.accessoryType = .disclosureIndicator

        return cell
    }
    
    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let breed = self.getSearchOptions()[indexPath.row]
        self.delegate?.didSelectOption(breed)
    }
}

private extension DogBreedSearchResultsController {
    func loadSearchOptions() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func loadSearchText() {
        DispatchQueue.main.async {
            self.filteredSearchOptions = self.searchText.isEmpty
                ? self.searchOptions
                : self.searchOptions.filter({ $0.lowercased().contains(self.searchText.lowercased()) })
            self.tableView.reloadData()
        }
    }
    
    func getSearchOptions() -> [DogBreed] {
        return self.searchText.isEmpty
            ? self.searchOptions
            : self.filteredSearchOptions
    }
}
