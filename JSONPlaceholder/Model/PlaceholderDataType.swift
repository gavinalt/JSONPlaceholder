//
//  PlaceholderDataType.swift
//  JSONPlaceholder
//
//  Created by Gavin Li on 6/24/20.
//  Copyright © 2020 Gavin Li. All rights reserved.
//

import Foundation

enum PlaceholderDataType {
  case users
  case albums(Int)
  case photos(Int)
}

protocol DataTypeToURLTranslator {
  func url(for placeholderDataType: PlaceholderDataType) -> URL
}

class DataTypeToWebURLTranslator: DataTypeToURLTranslator {
  static let rootUrl = "https://jsonplaceholder.typicode.com/"

  func url(for placeholderDataType: PlaceholderDataType) -> URL {
    let urlString: String
    switch placeholderDataType {
    case .users:
      urlString = DataTypeToWebURLTranslator.rootUrl + "users/"
    case let .albums(userId):
      urlString = DataTypeToWebURLTranslator.rootUrl + "users/\(userId)/albums"
    case let .photos(albumId):
      urlString = DataTypeToWebURLTranslator.rootUrl + "albums/\(albumId)/photos"
    }
    guard let url = URL(string: urlString) else {
      fatalError("Invalid URL")
    }
    return url
  }
}
