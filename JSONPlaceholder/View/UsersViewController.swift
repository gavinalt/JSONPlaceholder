//
//  ViewController.swift
//  JSONPlaceholder
//
//  Created by Gavin Li on 6/23/20.
//  Copyright © 2020 Gavin Li. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {
  let appTitle = "JSONPlaceholder"
  let searchFieldPlaceHolder = "Search for Users"
  let tableViewCellIdentifier = "searcherTableCell"

  private let searchController: UISearchController
  private let tableView: UITableView
  private let resultIndicator: UIView
  private let resultCountLabel: UILabel

  var isSearchBarEmpty: Bool {
    return searchController.searchBar.text?.isEmpty ?? true
  }

  let usersViewModel: UsersViewModel

  init(viewModel: UsersViewModel) {
    usersViewModel = viewModel
    searchController = UISearchController(searchResultsController: nil)
    tableView = UITableView()
    resultIndicator = UIView()
    resultCountLabel = UILabel()
    super.init(nibName: nil, bundle: nil)
    usersViewModel.bind {
      DispatchQueue.main.async { [weak self] in
        self?.tableView.reloadData()
        if viewModel.numOfRows(in: 0) == 0 {
          self?.resultCountLabel.text = "No Results"
        } else {
          self?.resultCountLabel.text = "\(viewModel.numOfRows(in: 0)) Results"
        }
      }
    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  deinit {
    usersViewModel.unbind()
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    title = appTitle
    view.backgroundColor = .systemBackground
    resultIndicator.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 32)
    setupTableView()
    setupSearchController()

    usersViewModel.fetchData()
  }

  private func setupTableHeader() {
    resultIndicator.backgroundColor = .secondarySystemBackground
    resultCountLabel.fill(in: resultIndicator, leadingMargin: 8)
  }

  private func setupTableView() {
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.estimatedRowHeight = 32
    tableView.rowHeight = UITableView.automaticDimension

    tableView.register(UsersTableViewCell.self, forCellReuseIdentifier: tableViewCellIdentifier)
    tableView.dataSource = self
    tableView.delegate = self
    view.addSubview(tableView)
    tableView.fill(in: view)

    setupTableHeader()
  }

  private func setupSearchController() {
    searchController.delegate = self
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.autocapitalizationType = .none
    searchController.searchBar.placeholder = searchFieldPlaceHolder

    navigationItem.searchController = searchController
    navigationItem.hidesSearchBarWhenScrolling = false

    definesPresentationContext = true
    searchController.searchBar.delegate = self
  }

}

extension UsersViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    usersViewModel.numOfRows(in: section)
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier, for: indexPath) as! UsersTableViewCell
    cell.configureCell(basedOnName: usersViewModel.name(for: indexPath),
                       userName: usersViewModel.userName(for: indexPath),
                       email: usersViewModel.email(for: indexPath))
    return cell
  }
}

extension UsersViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let userId = usersViewModel.userId(for: indexPath)
    let albumsViewModel = AlbumsViewModel(with: userId)
    let albumsTableViewController = AlbumsTableViewController(viewModel: albumsViewModel)
    navigationController?.pushViewController(albumsTableViewController, animated: true)
    tableView.deselectRow(at: indexPath, animated: false)
  }
}

extension UsersViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
//    updateSearchResults(for: searchController)
  }
}

extension UsersViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    tableView.tableHeaderView = isSearchBarEmpty ? nil : resultIndicator
    usersViewModel.filterDataForSearchQuery(searchController.searchBar.text!)
  }
}

extension UsersViewController: UISearchControllerDelegate {

}
