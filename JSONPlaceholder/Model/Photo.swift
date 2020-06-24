//
//  Photo.swift
//  JSONPlaceholder
//
//  Created by Gavin Li on 6/23/20.
//  Copyright © 2020 Gavin Li. All rights reserved.
//

import Foundation

struct Photo: Codable {
  let albumId: Int
  let id: Int
  let title: String
  let url: String
  let thumbnailUrl: String
}
