//
//  DogBreedSearchController.swift
//  Dog Breeds
//
//  Created by Vittorio Allegra on 30/01/22.
//

import UIKit

protocol DogBreedSearchDelegate: AnyObject {
    func didSelectOption(_ option: DogBreed?)
}

class DogBreedSearchController: UISearchController {
    weak var searchDelegate: DogBreedSearchDelegate?
    var searchOptions: [DogBreed] = [] { didSet { self.loadSearchOptions() } }
    
    private let _searchResultsController = DogBreedSearchResultsController()
    
    init() {
        super.init(searchResultsController: self._searchResultsController)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.searchResultsUpdater = self
        self.automaticallyShowsSearchResultsController = false
        self.hidesNavigationBarDuringPresentation = false
        self.searchBar.sizeToFit()
        self.searchBar.delegate = self
        self._searchResultsController.delegate = self
    }
}

private extension DogBreedSearchController {
    func loadSearchOptions() {
        self._searchResultsController.searchOptions = self.searchOptions
    }
}

extension DogBreedSearchController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        self.showsSearchResultsController = searchController.searchBar.isFirstResponder
    }
}

extension DogBreedSearchController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self._searchResultsController.searchText = searchText
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
        self.searchBar.text = nil
        self.searchDelegate?.didSelectOption(nil)
    }
}

extension DogBreedSearchController: DogBreedSearchResultsDelegate {
    func didSelectOption(_ option: DogBreed) {
        self.searchBar.resignFirstResponder()
        self.searchBar.text = option.capitalized
        self.searchDelegate?.didSelectOption(option)
    }
}
