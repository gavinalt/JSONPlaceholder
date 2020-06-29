//
//  SearchCategory.swift
//  JSONPlaceholder
//
//  Created by Gavin Li on 6/29/20.
//  Copyright © 2020 Gavin Li. All rights reserved.
//

import Foundation

enum SearchCategory {
  case all
  case name
  case userName
  case email
}

extension SearchCategory: CaseIterable { }

extension SearchCategory: RawRepresentable {
  typealias RawValue = String

  init?(rawValue: RawValue) {
    switch rawValue {
    case "All": self = .all
    case "Name": self = .name
    case "UserName": self = .userName
    case "Email": self = .email
    default: return nil
    }
  }

  var rawValue: RawValue {
    switch self {
    case .all: return "All"
    case .name: return "Name"
    case .userName: return "UserName"
    case .email: return "Email"
    }
  }
}
