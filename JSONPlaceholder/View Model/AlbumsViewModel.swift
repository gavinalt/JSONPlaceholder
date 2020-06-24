//
//  AlbumsViewModel.swift
//  JSONPlaceholder
//
//  Created by Gavin Li on 6/23/20.
//  Copyright © 2020 Gavin Li. All rights reserved.
//

import Foundation

class AlbumsViewModel {
  let imageDownloader: ImageDownloader = ImageDownloader()

  private let networkService: NetworkServiceProtocol
  private let urlTranslator: DataTypeToURLTranslatorProtocol

  private var handler: ViewModelHandler?

  private var albums: [Album] = [] {
    didSet { handler?() }
  }

  let userId: Int

  init(with userId: Int,
       urlTranslator: DataTypeToURLTranslatorProtocol = DataTypeToURLTranslator(),
       networkService: NetworkServiceProtocol = NetworkService()) {
    self.userId = userId
    self.urlTranslator = urlTranslator
    self.networkService = networkService
  }

  func bind(_ handler: @escaping ViewModelHandler) {
    self.handler = handler
  }

  func unbind() {
    handler = nil
  }

  func fetchData() {
    networkService.loadJSONData(type: [Album].self,
                                url: urlTranslator.url(for: .albums(userId)),
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

  func numOfRows(in section: Int) -> Int {
    albums.count
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
