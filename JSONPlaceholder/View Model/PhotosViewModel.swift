//
//  PhotosViewModel.swift
//  JSONPlaceholder
//
//  Created by Gavin Li on 6/23/20.
//  Copyright © 2020 Gavin Li. All rights reserved.
//

import Foundation

class PhotosViewModel {
  private let networkService: NetworkService = NetworkService()
  private let imageDownloader: ImageDownloader = ImageDownloader()
  private var handler: ViewModelHandler?

  private var photos: [Photo] = [] {
    didSet { handler?() }
  }

  let albumId: Int

  private let urlTranslator: DataTypeToWebURLTranslator

  init(with albumId: Int, _ urlTranslator: DataTypeToWebURLTranslator = DataTypeToWebURLTranslator()) {
    self.urlTranslator = urlTranslator
    self.albumId = albumId
  }

  func bind(_ handler: @escaping ViewModelHandler) {
    self.handler = handler
  }

  func unbind() {
    handler = nil
  }

  func fetchData() {
    networkService.loadJSONData(type: [Photo].self,
                                url: urlTranslator.url(for: .photos(albumId)),
                                params: nil) { result in
      switch result {
      case .success(let photos):
        self.photos = photos
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
}

extension PhotosViewModel {
  var numOfSection: Int {
    1
  }

  func numOfRows(in section: Int) -> Int {
    photos.count
  }

  func title(for indexPath: IndexPath) -> String {
    photos[indexPath.row].title
  }

  func id(for indexPath: IndexPath) -> Int {
    photos[indexPath.row].id
  }

  func url(for indexPath: IndexPath) -> String {
    photos[indexPath.row].url
  }

  func thumbnailUrl(for indexPath: IndexPath) -> String {
    photos[indexPath.row].thumbnailUrl
  }

  func image(for indexPath: IndexPath, completion: @escaping (Data?) -> Void) {
    imageDownloader.getImageFrom(thumbnailUrl(for: indexPath), completion: completion)
  }
}
