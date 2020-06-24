//
//  DataTypeToMockURLTranslator.swift
//  JSONPlaceholderTests
//
//  Created by Gavin Li on 6/24/20.
//  Copyright © 2020 Gavin Li. All rights reserved.
//

import Foundation
@testable import JSONPlaceholder

class DataTypeToMockURLTranslator: DataTypeToURLTranslator {
  let bundle = Bundle(for: DataTypeToMockURLTranslator.self)

  func url(for placeholderDataType: PlaceholderDataType) -> URL {
    let filePath: String
    switch placeholderDataType {
    case .users:
      guard let path = bundle.path(forResource: "users", ofType: "json") else {
        fatalError("users.json not found during testing")
      }
      filePath = path
    case .albums(_):
      guard let path = bundle.path(forResource: "albums", ofType: "json") else {
        fatalError("albums.json not found during testing")
      }
      filePath = path
    case .photos(_):
      guard let path = bundle.path(forResource: "photos", ofType: "json") else {
        fatalError("photos.json not found during testing")
      }
      filePath = path
    }

    return URL(fileURLWithPath: filePath)
  }
}
