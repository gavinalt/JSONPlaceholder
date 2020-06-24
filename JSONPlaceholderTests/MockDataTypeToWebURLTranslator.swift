//
//  MockDataTypeToWebURLTranslator.swift
//  JSONPlaceholderTests
//
//  Created by Gavin Li on 6/24/20.
//  Copyright © 2020 Gavin Li. All rights reserved.
//

import Foundation
@testable import JSONPlaceholder

class MockDataTypeToURLTranslator: DataTypeToURLTranslatorProtocol {
  func url(for placeholderDataType: PlaceholderDataType) -> URL {

    let bundle = Bundle(for: MockNetworkService.self)
    let fileName: String
    switch placeholderDataType {
    case .users:
      fileName = "users"
    case .albums(_):
      fileName = "albums"
    case .photos(_):
      fileName = "photos"
    }
    guard let path = bundle.path(forResource: fileName, ofType: "json") else {
      fatalError("Invalid URL")
    }
    let url = URL(fileURLWithPath: path)
    return url
  }
}
