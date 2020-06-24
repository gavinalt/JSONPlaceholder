//
//  User.swift
//  JSONPlaceholder
//
//  Created by Gavin Li on 6/23/20.
//  Copyright © 2020 Gavin Li. All rights reserved.
//

import Foundation

struct User: Codable {
  let id: Int
  let name: String
  let userName: String
  let email: String
  let website: String
  let company: Company

  enum CodingKeys: String, CodingKey {
    case id
    case name
    case userName = "username"
    case email
    case website
    case company
  }
}

struct Company: Codable {
  let name: String
  let catchPhrase: String
  let bs: String
}
