//
//  AlbumViewModel.swift
//  JSONPlaceholder
//
//  Created by Gavin Li on 6/23/20.
//  Copyright © 2020 Gavin Li. All rights reserved.
//

import Foundation

class AlbumsViewModel {
  private let networkService: NetworkService = NetworkService()
  private var handler: ViewModelHandler?

  private var albums: [Album] = [] {
    didSet { handler?() }
  }

  private let userId: Int

  init(with userId: Int) {
    self.userId = userId
  }

  func bind(_ handler: @escaping ViewModelHandler) {
    self.handler = handler
  }

  func unbind() {
    handler = nil
  }

  func fetchData() {
    networkService.loadJSONData(type: [Album].self,
                                url: "https://jsonplaceholder.typicode.com/users/\(userId)/albums",
                                params: nil) { result in
      switch result {
      case .success(let albums):
        self.albums = albums
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
}

extension AlbumsViewModel {
  var numOfSection: Int {
    1
  }

  func title(for indexPath: IndexPath) -> String {
    albums[indexPath.row].title
  }

  func userId(for indexPath: IndexPath) -> Int {
    albums[indexPath.row].userId
  }

  func albumId(for indexPath: IndexPath) -> Int {
    albums[indexPath.row].id
  }
}
