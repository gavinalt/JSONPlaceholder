//
//  Album.swift
//  JSONPlaceholder
//
//  Created by Gavin Li on 6/23/20.
//  Copyright © 2020 Gavin Li. All rights reserved.
//

import Foundation

struct Album: Codable {
  let userId: Int
  let id: Int
  var title: String
}
