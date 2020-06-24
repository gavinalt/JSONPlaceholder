//
//  AlbumsTableViewController.swift
//  JSONPlaceholder
//
//  Created by Gavin Li on 6/24/20.
//  Copyright © 2020 Gavin Li. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {
  let tableViewCellIdentifier = "albumsTableCell"
  private let albumsViewModel: AlbumsViewModel

  init(viewModel: AlbumsViewModel) {
    albumsViewModel = viewModel
    super.init(nibName: nil, bundle: nil)
    albumsViewModel.bind {
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Albums of User \(albumsViewModel.userId)"
    view.backgroundColor = .systemBackground

    albumsViewModel.fetchData()
  }

  // MARK: - Table view data source

  override func numberOfSections(in tableView: UITableView) -> Int {
    albumsViewModel.numOfSection
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    albumsViewModel.numOfRows(in: section)
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: UITableViewCell = {
      if let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier) {
        return cell
      } else {
        return UITableViewCell(style: .default, reuseIdentifier: tableViewCellIdentifier)
      }
    } ()
    cell.textLabel?.text = albumsViewModel.title(for: indexPath)
    cell.textLabel?.numberOfLines = 0

    return cell
  }

  // MARK: - Table view delegate

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let albumId = albumsViewModel.albumId(for: indexPath)
    let photosViewModel = PhotosViewModel(with: albumId, imageDownloader: albumsViewModel.imageDownloader)
    let photosCollectionViewController = PhotosCollectionViewController(viewModel: photosViewModel)
    navigationController?.pushViewController(photosCollectionViewController, animated: true)
    tableView.deselectRow(at: indexPath, animated: false)
  }
}
